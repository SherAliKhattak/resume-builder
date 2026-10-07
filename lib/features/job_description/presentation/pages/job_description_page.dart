import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/widgets/app_screen.dart';
import '../../../../app/widgets/app_text_field.dart';
import '../../../../app/widgets/chip_list.dart';
import '../../../../app/widgets/step_header.dart';
import '../../../ads/ads_service.dart';
import '../../../profile/domain/repositories/resume_repository.dart';
import '../../domain/ats_reviewer.dart';
import '../cubit/job_description_cubit.dart';
import '../widgets/ai_review_card.dart';

class JobDescriptionPage extends StatelessWidget {
  const JobDescriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => JobDescriptionCubit(
        getIt<ResumeRepository>(),
        reviewer: getIt<AtsReviewer>(),
      )..start(),
      child: const _JobDescriptionView(),
    );
  }
}

class _JobDescriptionView extends StatefulWidget {
  const _JobDescriptionView();

  @override
  State<_JobDescriptionView> createState() => _JobDescriptionViewState();
}

class _JobDescriptionViewState extends State<_JobDescriptionView> {
  final _text = TextEditingController();
  bool _seeded = false;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  Future<void> _flushFromField(BuildContext context) async {
    final cubit = context.read<JobDescriptionCubit>();
    if (!cubit.state.ready) return;
    if (_text.text != cubit.state.rawText) {
      cubit.onChanged(_text.text);
    }
    await cubit.flushPending();
  }

  Future<void> _goToPrevious(BuildContext context) async {
    await _flushFromField(context);
    if (!context.mounted) return;
    if (context.canPop()) {
      context.pop();
      return;
    }
    context.go('/profile');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobDescriptionCubit, JobDescriptionState>(
      listenWhen: (prev, next) =>
          (next.ready && !prev.ready) ||
          (next.message != null && next.message != prev.message),
      listener: (context, state) {
        if (state.ready && !_seeded) {
          _seeded = true;
          _text.text = state.rawText;
        }
        final message = state.message;
        if (message == null) return;
        final messenger = ScaffoldMessenger.maybeOf(context);
        messenger
          ?..clearSnackBars()
          ..showSnackBar(
            SnackBar(
              content: Text(message),
              duration: state.aiError == message
                  ? const Duration(seconds: 4)
                  : AppDurations.snackBar,
              persist: false,
            ),
          );
        context.read<JobDescriptionCubit>().clearMessage();
      },
      builder: (context, state) {
        if (state.ready && !_seeded) {
          _seeded = true;
          _text.text = state.rawText;
        }
        final analyzed = state.aiReview != null;
        final cubit = context.read<JobDescriptionCubit>();
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, _) {
            if (didPop) return;
            _goToPrevious(context);
          },
          child: AppScreen(
            title: 'Job post',
            header: const StepHeader(step: 2),
            leading: BackButton(onPressed: () => _goToPrevious(context)),
            primaryLabel: analyzed ? 'Next' : 'Analyze',
            primaryEnabled: analyzed || state.rawText.trim().isNotEmpty,
            onPrimary: state.busy
                ? null
                : () async {
                    await _flushFromField(context);
                    if (!context.mounted) return;
                    if (analyzed) {
                      context.push('/templates');
                      return;
                    }
                    await cubit.analyze();
                    if (!context.mounted) return;
                    if (context.read<JobDescriptionCubit>().state.aiReview ==
                        null) {
                      return;
                    }
                    await getIt<AdsService>().showInterstitial();
                  },
            secondary: TextButton(
              onPressed: () async {
                await _flushFromField(context);
                if (context.mounted) context.push('/templates');
              },
              child: const Text('Skip'),
            ),
            body: ListView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenPadding,
                AppSpacing.sm,
                AppSpacing.screenPadding,
                AppSpacing.lg,
              ),
              children: [
                AppTextField(
                  label: 'Job post',
                  hint: 'Paste the full job post, including required skills.',
                  helperText: 'The review uses this text as the source of truth.',
                  controller: _text,
                  maxLines: 10,
                  minLines: 8,
                  keyboardType: TextInputType.multiline,
                  onChanged: cubit.onChanged,
                ),
                if (state.busy) ...[
                  const SizedBox(height: AppSpacing.md),
                  const LinearProgressIndicator(),
                ],
                if (state.aiError != null && state.aiReview == null) ...[
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    state.aiError!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: cubit.requestAiReview,
                        child: const Text('Try the review again'),
                      ),
                    ),
                ],
                if (state.aiReview != null) ...[
                  const SizedBox(height: AppSpacing.xl),
                  if (state.aiError != null) ...[
                    Text(
                      state.aiError!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: cubit.requestAiReview,
                        child: const Text('Try the review again'),
                      ),
                    ),
                  ] else ...[
                    AiReviewCard(
                      review: state.aiReview!,
                      onAddSkill: cubit.addSuggestedSkill,
                      onApplySummary: cubit.applySuggestedSummary,
                    ),
                    if (state.aiReview!.matchedKeywords.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.lg),
                      Text(
                        'You have',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      ChipList(
                        items: state.aiReview!.matchedKeywords,
                        tone: ChipTone.matched,
                      ),
                    ],
                    if (state.aiReview!.missingKeywords.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.lg),
                      Text(
                        'Consider adding',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      ChipList(
                        items: state.aiReview!.missingKeywords,
                        tone: ChipTone.consider,
                      ),
                    ],
                  ],
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
