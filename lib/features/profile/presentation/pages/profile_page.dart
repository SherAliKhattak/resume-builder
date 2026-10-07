import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_spacing.dart';
import '../../../../app/widgets/app_screen.dart';
import '../../../../app/widgets/section_card.dart';
import '../../../../app/widgets/step_header.dart';
import '../../../../core/constants/section_keys.dart';
import '../cubit/profile_overview_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const _routes = {
    SectionKeys.personal: '/profile/personal',
    SectionKeys.summary: '/profile/summary',
    SectionKeys.experience: '/profile/experience',
    SectionKeys.education: '/profile/education',
    SectionKeys.skills: '/profile/skills',
    SectionKeys.courses: '/profile/courses',
    SectionKeys.projects: '/profile/projects',
    SectionKeys.languages: '/profile/languages',
    SectionKeys.awards: '/profile/awards',
    SectionKeys.custom: '/profile/custom',
  };

  static const _icons = {
    SectionKeys.personal: Icons.person_outline_rounded,
    SectionKeys.summary: Icons.notes_outlined,
    SectionKeys.experience: Icons.work_outline_rounded,
    SectionKeys.education: Icons.school_outlined,
    SectionKeys.skills: Icons.auto_awesome_outlined,
    SectionKeys.courses: Icons.workspace_premium_outlined,
    SectionKeys.projects: Icons.layers_outlined,
    SectionKeys.languages: Icons.translate_rounded,
    SectionKeys.awards: Icons.emoji_events_outlined,
    SectionKeys.custom: Icons.dashboard_customize_outlined,
  };

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileOverviewCubit, ProfileOverviewState>(
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
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, _) {
            if (didPop) return;
            _goToPrevious(context);
          },
          child: AppScreen(
            title: state.fullName.trim().isEmpty
                ? 'Resume'
                : 'Resume ${state.fullName.trim()}',
            showBanner: true,
            header: const StepHeader(step: 1),
            leading: BackButton(onPressed: () => _goToPrevious(context)),
            actions: [
              IconButton(
                tooltip: 'Fill empty fields from a file',
                onPressed: () =>
                    context.read<ProfileOverviewCubit>().importResume(),
                icon: const Icon(Icons.upload_file_outlined),
              ),
            ],
            primaryLabel: 'Next',
            onPrimary: () => context.go('/jd'),
            primaryEnabled: true,
            secondary: TextButton(
              onPressed: () => context.push('/profile/sections'),
              child: const Text('Add or remove sections'),
            ),
            body: ListView.separated(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenPadding,
                AppSpacing.sm,
                AppSpacing.screenPadding,
                AppSpacing.lg,
              ),
              itemCount: state.sections.length,
              separatorBuilder: (_, _) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final section = state.sections[index];
                return SectionCard(
                  title: SectionKeys.label(section.key),
                  complete: section.complete,
                  hidden: section.hidden,
                  icon: _icons[section.key],
                  onTap: () {
                    final route = _routes[section.key];
                    if (route != null) context.push(route);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _goToPrevious(BuildContext context) {
    if (context.canPop()) {
      context.pop();
      return;
    }
    context.go('/');
  }
}
