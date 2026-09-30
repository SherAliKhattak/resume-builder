import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/widgets/app_screen.dart';
import '../../../../app/widgets/step_header.dart';
import '../../../profile/domain/repositories/resume_repository.dart';
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
      create: (_) => ExportCubit(
        getIt<ResumeRepository>(),
        getIt<TemplateRegistry>(),
      )..start(),
      child: const _ExportView(),
    );
  }
}

class _ExportView extends StatelessWidget {
  const _ExportView();

  void _goToPrevious(BuildContext context) {
    if (context.canPop()) {
      context.pop();
      return;
    }
    context.go('/templates');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExportCubit, ExportState>(
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
          primaryEnabled: !state.busy,
          onPrimary: state.busy ? null : cubit.share,
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
                  childrenPadding: const EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    0,
                    AppSpacing.md,
                    AppSpacing.md,
                  ),
                  title: const Text('Customize'),
                  subtitle: Text(
                    'Color, type size, and margins',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Accent color',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
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
                                settings.copyWith(accentColor: color),
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
              Expanded(
                child: !state.ready
                    ? const Center(child: CircularProgressIndicator())
                    : PdfRasterView(
                        repaintToken: (
                          settings.templateId,
                          settings.accentColor,
                          settings.fontSize,
                          settings.margin,
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
