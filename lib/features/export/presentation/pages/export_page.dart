import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/widgets/app_screen.dart';
import '../../../../app/widgets/step_header.dart';
import '../../../../core/constants/section_keys.dart';
import '../../../ads/ads_service.dart';
import '../../../profile/domain/repositories/resume_repository.dart';
import '../../../templates/domain/resume_font.dart';
import '../../../templates/domain/template_registry.dart';
import '../../../templates/presentation/cubit/template_cubits.dart';
import '../../../templates/pdf/pdf_safe.dart';
import '../../../templates/presentation/widgets/pdf_raster_view.dart';
import '../../../templates/presentation/widgets/resume_paper_view.dart';
import '../../../../seed/sample_resume.dart';

class ExportPage extends StatelessWidget {
  const ExportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ExportCubit(getIt<ResumeRepository>(), getIt<TemplateRegistry>())
            ..start(),
      child: const _ExportView(),
    );
  }
}

class _ExportView extends StatefulWidget {
  const _ExportView();

  @override
  State<_ExportView> createState() => _ExportViewState();
}

class _ExportViewState extends State<_ExportView> {
  var _awaitingAd = false;

  void _goToPrevious(BuildContext context) {
    if (context.canPop()) {
      context.pop();
      return;
    }
    context.go('/templates');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExportCubit, ExportState>(
      listenWhen: (prev, next) =>
          next.message != null && next.message != prev.message,
      listener: (context, state) {
        final message = state.message;
        if (message == null) return;
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
            SnackBar(
              content: Text(message),
              duration: AppDurations.snackBar,
              persist: false,
            ),
          );
      },
      builder: (context, state) {
        final cubit = context.read<ExportCubit>();
        final settings = state.data.settings;
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, _) {
            if (didPop) return;
            _goToPrevious(context);
          },
          child: AppScreen(
            title: 'Preview and export',
            header: const StepHeader(step: 4),
            leading: BackButton(onPressed: () => _goToPrevious(context)),
            primaryLabel: 'Download / Share PDF',
            primaryEnabled: !state.busy && !_awaitingAd,
            onPrimary: state.busy || _awaitingAd
                ? null
                : () async {
                    setState(() => _awaitingAd = true);
                    try {
                      await getIt<AdsService>().showInterstitial();
                      if (!context.mounted) return;
                      await cubit.share();
                    } finally {
                      if (mounted) setState(() => _awaitingAd = false);
                    }
                  },
            body: Column(
              children: [
                Card(
                  margin: const EdgeInsets.fromLTRB(
                    AppSpacing.screenPadding,
                    0,
                    AppSpacing.screenPadding,
                    AppSpacing.sm,
                  ),
                  child: ExpansionTile(
                    tilePadding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                    ),
                    childrenPadding: EdgeInsets.zero,
                    title: const Text('Customize'),
                    subtitle: Text(
                      'Color, font, skills placement, type size, and margins',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: (MediaQuery.sizeOf(context).height * 0.38)
                              .clamp(180.0, 320.0),
                        ),
                        child: SingleChildScrollView(
                            padding: const EdgeInsets.fromLTRB(
                              AppSpacing.md,
                              0,
                              AppSpacing.md,
                              AppSpacing.md,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'Accent color',
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(height: AppSpacing.sm),
                                Wrap(
                                  spacing: AppSpacing.sm,
                                  runSpacing: AppSpacing.sm,
                                  children: [
                                    for (final color in AppColors.accentSwatches)
                                      _AccentDot(
                                        color: Color(color),
                                        selected: settings.accentColor == color,
                                        onTap: () {
                                          HapticFeedback.selectionClick();
                                          cubit.updateSettings(
                                            settings.copyWith(
                                              accentColor: color,
                                            ),
                                          );
                                        },
                                      ),
                                  ],
                                ),
                                const SizedBox(height: AppSpacing.md),
                                Text(
                                  'Font',
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(height: AppSpacing.sm),
                                Wrap(
                                  spacing: AppSpacing.sm,
                                  runSpacing: AppSpacing.sm,
                                  children: [
                                    for (final font in ResumeFont.values)
                                      ChoiceChip(
                                        label: Text(
                                          font.label,
                                          style: TextStyle(
                                            fontFamily: font.flutterFamily,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        selected: settings.resumeFont == font,
                                        onSelected: (_) {
                                          HapticFeedback.selectionClick();
                                          cubit.updateSettings(
                                            settings.copyWith(
                                              fontFamily: font.id,
                                            ),
                                          );
                                        },
                                      ),
                                  ],
                                ),
                                const SizedBox(height: AppSpacing.md),
                                Text(
                                  'Skills placement',
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(height: AppSpacing.sm),
                                Wrap(
                                  spacing: AppSpacing.sm,
                                  runSpacing: AppSpacing.sm,
                                  children: [
                                    ChoiceChip(
                                      label: const Text('Before experience'),
                                      selected:
                                          settings.skillsPlacement ==
                                          SkillsPlacement.beforeExperience,
                                      onSelected: (_) {
                                        HapticFeedback.selectionClick();
                                        cubit.updateSettings(
                                          settings.withSkillsPlacement(
                                            SkillsPlacement.beforeExperience,
                                          ),
                                        );
                                      },
                                    ),
                                    ChoiceChip(
                                      label: const Text('After experience'),
                                      selected:
                                          settings.skillsPlacement ==
                                          SkillsPlacement.afterExperience,
                                      onSelected: (_) {
                                        HapticFeedback.selectionClick();
                                        cubit.updateSettings(
                                          settings.withSkillsPlacement(
                                            SkillsPlacement.afterExperience,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: AppSpacing.md),
                                Text(
                                  'Text size ${settings.fontSize.round()}',
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                Slider(
                                  min: 8,
                                  max: 13,
                                  divisions: 5,
                                  value: settings.fontSize.clamp(8, 13),
                                  onChanged: (value) => cubit.updateSettings(
                                    settings.copyWith(fontSize: value),
                                  ),
                                ),
                                Text(
                                  'Margins ${settings.margin.round()}',
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                Slider(
                                  min: 24,
                                  max: 56,
                                  divisions: 8,
                                  value: settings.margin.clamp(24, 56),
                                  onChanged: (value) => cubit.updateSettings(
                                    settings.copyWith(margin: value),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: !state.ready
                      ? const Center(child: CircularProgressIndicator())
                      : PdfRasterView(
                          repaintToken: (
                            settings.templateId,
                            settings.accentColor,
                            settings.fontFamily,
                            settings.fontSize,
                            settings.margin,
                            settings.sectionOrder.join(','),
                            state.data.personal.fullName,
                            state.data.summary,
                            state.data.experiences.length,
                            state.data.educations.length,
                            state.data.skillGroups.length,
                            state.data.projects.length,
                          ),
                          fallback: ResumePaperView(
                            data: pdfSafeResume(
                              SampleResume.forPreview(state.data),
                            ),
                          ),
                          buildPdf: cubit.buildPdf,
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _AccentDot extends StatelessWidget {
  const _AccentDot({
    required this.color,
    required this.selected,
    required this.onTap,
  });

  final Color color;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: AnimatedContainer(
          duration: AppDurations.fast,
          curve: AppCurves.standard,
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(
              color: selected
                  ? Theme.of(context).colorScheme.onSurface
                  : Colors.transparent,
              width: 2.5,
            ),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: selected ? 0.4 : 0.18),
                blurRadius: selected ? 10 : 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: selected
              ? const Icon(Icons.check_rounded, size: 20, color: Colors.white)
              : null,
        ),
      ),
    );
  }
}
