import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/widgets/app_screen.dart';
import '../../../../app/widgets/app_text_field.dart';
import '../../../../app/widgets/chip_list.dart';
import '../../../../app/widgets/step_header.dart';
import '../../../../core/analysis/keyword_analyzer.dart';
import '../../../profile/domain/repositories/resume_repository.dart';
import '../cubit/job_description_cubit.dart';

class JobDescriptionPage extends StatelessWidget {
  const JobDescriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => JobDescriptionCubit(
        getIt<ResumeRepository>(),
        getIt<KeywordAnalyzer>(),
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobDescriptionCubit, JobDescriptionState>(
      listener: (context, state) {
        if (_seeded) return;
        _seeded = true;
        _text.text = state.rawText;
      },
      builder: (context, state) {
        if (!_seeded && state.rawText.isNotEmpty) {
          _seeded = true;
          _text.text = state.rawText;
        }
        final analyzed = state.analysis != null;
        return AppScreen(
          title: 'Job post',
          header: const StepHeader(step: 2),
          primaryLabel: analyzed ? 'Next' : 'Analyze',
          primaryEnabled: analyzed || state.rawText.trim().isNotEmpty,
          onPrimary: state.busy
              ? null
              : () async {
                  final cubit = context.read<JobDescriptionCubit>();
                  await cubit.flushPending();
                  if (!context.mounted) return;
                  if (analyzed) {
                    context.push('/templates');
                  } else {
                    cubit.analyze();
                  }
                },
          secondary: TextButton(
            onPressed: () async {
              await context.read<JobDescriptionCubit>().flushPending();
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
                hint: 'Paste the job post here',
                controller: _text,
                maxLines: 10,
                minLines: 8,
                keyboardType: TextInputType.multiline,
                onChanged: context.read<JobDescriptionCubit>().onChanged,
              ),
              if (state.busy) ...[
                const SizedBox(height: AppSpacing.md),
                const LinearProgressIndicator(),
              ],
              if (state.analysis != null) ...[
                const SizedBox(height: AppSpacing.xl),
                _MatchScore(
                  percent: state.analysis!.percent,
                  suggestion: state.suggestion,
                ),
                const SizedBox(height: AppSpacing.lg),
                Text('You have', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: AppSpacing.sm),
                ChipList(items: state.analysis!.matched, tone: ChipTone.matched),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  'Consider adding',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppSpacing.sm),
                ChipList(
                  items: state.analysis!.missing,
                  tone: ChipTone.consider,
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _MatchScore extends StatelessWidget {
  const _MatchScore({required this.percent, this.suggestion});

  final int percent;
  final String? suggestion;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final value = (percent / 100).clamp(0.0, 1.0);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            SizedBox(
              width: 108,
              height: 108,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 108,
                    height: 108,
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0, end: value),
                      duration: AppDurations.emphasized,
                      curve: AppCurves.standard,
                      builder: (context, animated, _) {
                        return CircularProgressIndicator(
                          value: animated,
                          strokeWidth: 8,
                          backgroundColor: scheme.surfaceContainerHighest,
                          color: scheme.primary,
                          strokeCap: StrokeCap.round,
                        );
                      },
                    ),
                  ),
                  Text(
                    '$percent%',
                    style: textTheme.headlineMedium?.copyWith(
                      color: scheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'How well your details match this job',
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
            if (suggestion != null) ...[
              const SizedBox(height: AppSpacing.md),
              Text(
                suggestion!,
                textAlign: TextAlign.center,
                style: textTheme.bodyLarge,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
