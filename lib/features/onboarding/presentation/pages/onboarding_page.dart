import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/widgets/app_button.dart';
import '../../../../app/widgets/app_screen.dart';
import '../../../profile/domain/repositories/resume_repository.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _controller = PageController();
  int _index = 0;

  static const _pages = [
    (
      Icons.edit_note_rounded,
      'Your details, once',
      'Add your work, school, and skills in short, focused steps. We save as you type.',
    ),
    (
      Icons.manage_search_rounded,
      'Paste a job post',
      'We read it on this device and show what you already cover — and what you might add.',
    ),
    (
      Icons.picture_as_pdf_rounded,
      'Pick a look and share',
      'Choose a template, preview the PDF, then download or share it.',
    ),
  ];

  Future<void> _finish() async {
    final repo = getIt<ResumeRepository>();
    final settings = await repo.getSettings();
    await repo.saveSettings(settings.copyWith(hasSeenOnboarding: true));
    if (!mounted) return;
    context.go('/');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final last = _index == _pages.length - 1;
    final scheme = Theme.of(context).colorScheme;
    return AppScreen(
      title: 'Welcome',
      actions: [
        AppTextButton(label: 'Skip', onPressed: _finish),
      ],
      primaryLabel: last ? 'Get started' : 'Next',
      onPrimary: () {
        if (last) {
          _finish();
        } else {
          _controller.nextPage(
            duration: AppDurations.medium,
            curve: AppCurves.standard,
          );
        }
      },
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: _pages.length,
              onPageChanged: (value) => setState(() => _index = value),
              itemBuilder: (context, index) {
                final page = _pages[index];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenPadding,
                    AppSpacing.lg,
                    AppSpacing.screenPadding,
                    AppSpacing.md,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          color: scheme.primaryContainer,
                          borderRadius: BorderRadius.circular(AppRadii.lg),
                        ),
                        child: Icon(
                          page.$1,
                          size: 36,
                          color: scheme.onPrimaryContainer,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        page.$2,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        page.$3,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                      const Spacer(flex: 2),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < _pages.length; i++)
                  AnimatedContainer(
                    duration: AppDurations.fast,
                    curve: AppCurves.standard,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 8,
                    width: i == _index ? 22 : 8,
                    decoration: BoxDecoration(
                      color: i == _index
                          ? scheme.primary
                          : scheme.outlineVariant,
                      borderRadius: BorderRadius.circular(AppRadii.full),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
