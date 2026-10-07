import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/widgets/app_canvas.dart';
import '../../../../app/widgets/app_screen.dart';
import '../../../../app/widgets/app_text_field.dart';
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

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  final _name = TextEditingController();
  final _title = TextEditingController();
  var _seeded = false;

  @override
  void dispose() {
    _name.dispose();
    _title.dispose();
    super.dispose();
  }

  Future<void> _buildResume() async {
    await context.read<HomeCubit>().begin(name: _name.text, title: _title.text);
    if (!mounted) return;
    context.go('/profile');
  }

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
              persist: false,
            ),
          );
      },
      builder: (context, state) {
        if (state.hasStarted && !_seeded) {
          _seeded = true;
          getIt<ResumeRepository>().watchPersonalInfo().first.then((info) {
            if (!mounted) return;
            if (_name.text.isEmpty) _name.text = info.fullName;
            if (_title.text.isEmpty) _title.text = info.title;
          });
        }
        final textTheme = Theme.of(context).textTheme;
        final scheme = Theme.of(context).colorScheme;
        return AppScreen(
          title: '',
          implyLeading: false,
          showBanner: true,
          actions: [
            PopupMenuButton<String>(
              tooltip: 'More',
              icon: const Icon(Icons.more_horiz_rounded),
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
          primaryLabel: 'Build Resume',
          onPrimary: state.busy ? null : _buildResume,
          primaryEnabled: !state.busy,
          secondary: TextButton(
            onPressed: () => context.read<HomeCubit>().importResume(),
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
              const SizedBox(height: 28),
              const Center(child: GlassOrb(size: 108)),
              const SizedBox(height: 36),
              Text(
                'Create resume',
                textAlign: TextAlign.center,
                style: textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Enter your name and target role, then fill in the rest on this device.',
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 28),
              AppTextField(
                label: 'Full Name',
                hint: 'Jane Doe',
                controller: _name,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                autofillHints: const [AutofillHints.name],
                prefixIcon: Icons.person_outline_rounded,
              ),
              const SizedBox(height: 14),
              AppTextField(
                label: 'Job Role',
                hint: 'Product designer',
                controller: _title,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.done,
                prefixIcon: Icons.work_outline_rounded,
                onSubmitted: (_) {
                  if (!state.busy) _buildResume();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
