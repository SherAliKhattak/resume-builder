import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/widgets/app_screen.dart';
import '../../../../app/widgets/step_header.dart';
import '../../../profile/domain/repositories/resume_repository.dart';
import '../../domain/template_registry.dart';
import '../cubit/template_cubits.dart';
import '../widgets/template_thumbnail.dart';

class TemplateGalleryPage extends StatelessWidget {
  const TemplateGalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TemplateGalleryCubit(
        getIt<ResumeRepository>(),
        getIt<TemplateRegistry>(),
      )..start(),
      child: const _GalleryView(),
    );
  }
}

class _GalleryView extends StatelessWidget {
  const _GalleryView();

  void _goToPrevious(BuildContext context) {
    if (context.canPop()) {
      context.pop();
      return;
    }
    context.go('/jd');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TemplateGalleryCubit, TemplateGalleryState>(
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
        final cubit = context.read<TemplateGalleryCubit>();
        final templates = cubit.registry.all;
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, _) {
            if (didPop) return;
            _goToPrevious(context);
          },
          child: AppScreen(
            title: 'Template',
            showBanner: true,
            header: const StepHeader(step: 3),
            leading: BackButton(onPressed: () => _goToPrevious(context)),
            primaryLabel: 'Next',
            onPrimary: () => context.push('/export'),
            secondary: TextButton(
              onPressed: () => context.push(
                '/templates/preview?id=${state.selectedId}',
              ),
              child: const Text('Preview'),
            ),
            body: GridView.builder(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenPadding,
                AppSpacing.sm,
                AppSpacing.screenPadding,
                AppSpacing.lg,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: AppSpacing.md,
                mainAxisSpacing: AppSpacing.md,
                childAspectRatio: 0.72,
              ),
              itemCount: templates.length,
              itemBuilder: (context, index) {
                final template = templates[index];
                return TemplateThumbnail(
                  name: template.name,
                  selected: template.id == state.selectedId,
                  png: state.thumbnails[template.id],
                  onTap: () => cubit.select(template.id),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
