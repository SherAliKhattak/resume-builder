import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/widgets/app_screen.dart';
import '../../../../core/backup/backup_service.dart';
import '../../../../core/import/resume_import_service.dart';
import '../../../profile/domain/repositories/resume_repository.dart';
import '../cubit/home_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(
        getIt<ResumeRepository>(),
        getIt<BackupService>(),
        getIt<ResumeImportService>(),
      )..start(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
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
            ),
          );
      },
      builder: (context, state) {
        final scheme = Theme.of(context).colorScheme;
        final textTheme = Theme.of(context).textTheme;
        return AppScreen(
          title: 'Resume Builder',
          actions: [
            PopupMenuButton<String>(
              tooltip: 'More',
              icon: const Icon(Icons.more_vert_rounded),
              onSelected: (value) {
                final cubit = context.read<HomeCubit>();
                if (value == 'upload') cubit.importResume();
                if (value == 'backup') cubit.exportBackup();
                if (value == 'restore') cubit.importBackup();
              },
              itemBuilder: (context) => const [
                PopupMenuItem(value: 'upload', child: Text('Upload a resume')),
                PopupMenuItem(value: 'backup', child: Text('Backup')),
                PopupMenuItem(value: 'restore', child: Text('Restore')),
              ],
            ),
          ],
          primaryLabel: state.hasStarted ? 'Continue' : 'Create Resume',
          onPrimary: state.busy ? null : () => context.go('/profile'),
          primaryEnabled: !state.busy,
          secondary: TextButton(
            onPressed: state.busy
                ? null
                : () => context.read<HomeCubit>().importResume(),
            child: const Text('Upload a resume'),
          ),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenPadding,
              AppSpacing.sm,
              AppSpacing.screenPadding,
              AppSpacing.lg,
            ),
            children: [
              const SizedBox(height: AppSpacing.md),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: scheme.primaryContainer,
                    borderRadius: BorderRadius.circular(AppRadii.lg),
                  ),
                  child: Icon(
                    Icons.description_outlined,
                    size: 32,
                    color: scheme.onPrimaryContainer,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'A calm way to write a resume.',
                style: textTheme.headlineMedium,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Upload a current resume if you have one. We fill empty fields on this device, and you add anything that is still missing.',
                style: textTheme.bodyLarge?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              const _HomePoint(
                icon: Icons.upload_file_outlined,
                title: 'Start from a file',
                body: 'Import a PDF or Word resume and fill empty fields.',
              ),
              const SizedBox(height: AppSpacing.md),
              const _HomePoint(
                icon: Icons.manage_search_outlined,
                title: 'Match a job post',
                body: 'See what you already cover, then add what is missing.',
              ),
              const SizedBox(height: AppSpacing.md),
              const _HomePoint(
                icon: Icons.picture_as_pdf_outlined,
                title: 'Export a clean PDF',
                body: 'Pick a template and share an ATS-friendly resume.',
              ),
            ],
          ),
        );
      },
    );
  }
}

class _HomePoint extends StatelessWidget {
  const _HomePoint({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(AppRadii.sm),
          ),
          child: Icon(icon, size: 20, color: scheme.primary),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: textTheme.titleMedium),
              const SizedBox(height: 2),
              Text(
                body,
                style: textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
