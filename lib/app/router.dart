import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../features/export/presentation/pages/export_page.dart';
import '../features/home/presentation/pages/home_page.dart';
import '../features/job_description/presentation/pages/job_description_page.dart';
import '../features/onboarding/presentation/pages/onboarding_page.dart';
import '../features/profile/presentation/cubit/awards_cubit.dart';
import '../features/profile/presentation/cubit/courses_cubit.dart';
import '../features/profile/presentation/cubit/custom_sections_cubit.dart';
import '../features/profile/presentation/cubit/education_cubit.dart';
import '../features/profile/presentation/cubit/experience_cubit.dart';
import '../features/profile/presentation/cubit/languages_cubit.dart';
import '../features/profile/presentation/cubit/personal_info_cubit.dart';
import '../features/profile/presentation/cubit/profile_overview_cubit.dart';
import '../features/profile/presentation/cubit/projects_cubit.dart';
import '../features/profile/presentation/cubit/sections_cubit.dart';
import '../features/profile/presentation/cubit/skills_cubit.dart';
import '../features/profile/presentation/cubit/summary_cubit.dart';
import '../features/profile/presentation/pages/awards_page.dart';
import '../features/profile/presentation/pages/courses_page.dart';
import '../features/profile/presentation/pages/custom_sections_page.dart';
import '../features/profile/presentation/pages/education_page.dart';
import '../features/profile/presentation/pages/experience_page.dart';
import '../features/profile/presentation/pages/languages_page.dart';
import '../features/profile/presentation/pages/personal_info_page.dart';
import '../features/profile/presentation/pages/profile_page.dart';
import '../features/profile/presentation/pages/projects_page.dart';
import '../features/profile/presentation/pages/sections_page.dart';
import '../features/profile/presentation/pages/skills_page.dart';
import '../features/profile/presentation/pages/summary_page.dart';
import '../features/templates/presentation/pages/template_gallery_page.dart';
import '../features/templates/presentation/pages/template_preview_page.dart';
import 'di.dart';

GoRouter createRouter({required bool showOnboarding}) {
  return GoRouter(
    initialLocation: showOnboarding ? '/onboarding' : '/',
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(path: '/', builder: (context, state) => const HomePage()),
      GoRoute(
        path: '/profile',
        builder: (context, state) => BlocProvider(
          create: (_) => ProfileOverviewCubit(getIt(), getIt())..start(),
          child: const ProfilePage(),
        ),
      ),
      GoRoute(
        path: '/profile/personal',
        builder: (context, state) => BlocProvider(
          create: (_) => PersonalInfoCubit(getIt())..start(),
          child: const PersonalInfoPage(),
        ),
      ),
      GoRoute(
        path: '/profile/summary',
        builder: (context, state) => BlocProvider(
          create: (_) => SummaryCubit(getIt())..start(),
          child: const SummaryPage(),
        ),
      ),
      GoRoute(
        path: '/profile/experience',
        builder: (context, state) => BlocProvider(
          create: (_) => ExperienceCubit(getIt())..start(),
          child: const ExperiencePage(),
        ),
      ),
      GoRoute(
        path: '/profile/education',
        builder: (context, state) => BlocProvider(
          create: (_) => EducationCubit(getIt())..start(),
          child: const EducationPage(),
        ),
      ),
      GoRoute(
        path: '/profile/skills',
        builder: (context, state) => BlocProvider(
          create: (_) => SkillsCubit(getIt())..start(),
          child: const SkillsPage(),
        ),
      ),
      GoRoute(
        path: '/profile/courses',
        builder: (context, state) => BlocProvider(
          create: (_) => CoursesCubit(getIt())..start(),
          child: const CoursesPage(),
        ),
      ),
      GoRoute(
        path: '/profile/projects',
        builder: (context, state) => BlocProvider(
          create: (_) => ProjectsCubit(getIt())..start(),
          child: const ProjectsPage(),
        ),
      ),
      GoRoute(
        path: '/profile/languages',
        builder: (context, state) => BlocProvider(
          create: (_) => LanguagesCubit(getIt())..start(),
          child: const LanguagesPage(),
        ),
      ),
      GoRoute(
        path: '/profile/awards',
        builder: (context, state) => BlocProvider(
          create: (_) => AwardsCubit(getIt())..start(),
          child: const AwardsPage(),
        ),
      ),
      GoRoute(
        path: '/profile/custom',
        builder: (context, state) => BlocProvider(
          create: (_) => CustomSectionsCubit(getIt())..start(),
          child: const CustomSectionsPage(),
        ),
      ),
      GoRoute(
        path: '/profile/sections',
        builder: (context, state) => BlocProvider(
          create: (_) => SectionsCubit(getIt())..start(),
          child: const SectionsPage(),
        ),
      ),
      GoRoute(
        path: '/jd',
        builder: (context, state) => const JobDescriptionPage(),
      ),
      GoRoute(
        path: '/templates',
        builder: (context, state) => const TemplateGalleryPage(),
      ),
      GoRoute(
        path: '/templates/preview',
        builder: (context, state) {
          final id = state.uri.queryParameters['id'] ?? 'classic';
          return TemplatePreviewPage(templateId: id);
        },
      ),
      GoRoute(path: '/export', builder: (context, state) => const ExportPage()),
    ],
  );
}
