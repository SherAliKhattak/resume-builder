import 'package:flutter/material.dart';

import '../../../../core/constants/section_keys.dart';
import '../../../profile/domain/models/resume_data.dart';
import '../../../../app/theme/app_spacing.dart';

class ResumePaperView extends StatelessWidget {
  const ResumePaperView({super.key, required this.data});

  final ResumeData data;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final personal = data.personal;
    final contact = [
      personal.email,
      personal.phone,
      personal.location,
      personal.linkedin,
      personal.github,
      personal.portfolio,
    ].where((part) => part.trim().isNotEmpty).join('  |  ');

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenPadding,
        AppSpacing.sm,
        AppSpacing.screenPadding,
        AppSpacing.lg,
      ),
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(AppRadii.md),
            border: Border.all(
              color: scheme.outlineVariant.withValues(alpha: 0.5),
            ),
            boxShadow: [
              BoxShadow(
                color: scheme.shadow.withValues(alpha: 0.08),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 24, 22, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  personal.fullName.isEmpty ? 'Your name' : personal.fullName,
                  style: text.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    height: 1.1,
                  ),
                ),
                if (personal.title.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(personal.title, style: text.titleSmall),
                ],
                if (contact.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    contact,
                    style: text.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
                if (data.summary.trim().isNotEmpty) ...[
                  const SizedBox(height: 18),
                  _SectionLabel('Summary'),
                  Text(data.summary, style: text.bodyMedium),
                ],
                if (data.experiences.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  _SectionLabel(SectionKeys.label(SectionKeys.experience)),
                  for (final item in data.experiences) ...[
                    Text(
                      [
                        item.role,
                        item.company,
                      ].where((part) => part.trim().isNotEmpty).join('  |  '),
                      style: text.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    if (item.startDate.isNotEmpty ||
                        item.endDate.isNotEmpty ||
                        item.isCurrent)
                      Text(
                        [
                          item.startDate,
                          item.isCurrent ? 'Present' : item.endDate,
                        ].where((part) => part.trim().isNotEmpty).join(' - '),
                        style: text.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    for (final bullet in item.bullets.take(4))
                      Padding(
                        padding: const EdgeInsets.only(top: 3, left: 2),
                        child: Text('•  $bullet', style: text.bodySmall),
                      ),
                    const SizedBox(height: 10),
                  ],
                ],
                if (data.educations.isNotEmpty) ...[
                  _SectionLabel(SectionKeys.label(SectionKeys.education)),
                  for (final item in data.educations)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        [
                          item.school,
                          [item.degree, item.field]
                              .where((part) => part.trim().isNotEmpty)
                              .join(' '),
                        ].where((part) => part.trim().isNotEmpty).join('  |  '),
                        style: text.bodyMedium,
                      ),
                    ),
                ],
                if (data.skillGroups.isNotEmpty) ...[
                  _SectionLabel(SectionKeys.label(SectionKeys.skills)),
                  Text(
                    [
                      for (final group in data.skillGroups)
                        for (final skill in group.skills) skill.name,
                    ].where((name) => name.trim().isNotEmpty).join('  •  '),
                    style: text.bodyMedium,
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        label.toUpperCase(),
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          letterSpacing: 0.6,
          fontWeight: FontWeight.w700,
          color: scheme.primary,
        ),
      ),
    );
  }
}
