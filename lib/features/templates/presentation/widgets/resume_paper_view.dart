import 'package:flutter/material.dart';

import '../../../../core/constants/section_keys.dart';
import '../../../profile/domain/models/resume_data.dart';
import '../../domain/resume_font.dart';
import '../../pdf/resume_links.dart';
import '../../../../app/theme/app_spacing.dart';

class ResumePaperView extends StatelessWidget {
  const ResumePaperView({super.key, required this.data});

  final ResumeData data;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final family = ResumeFont.fromId(data.settings.fontFamily).flutterFamily;
    final text = Theme.of(context).textTheme.apply(fontFamily: family);
    final personal = data.personal;
    final contact = [
      personal.email,
      personal.phone,
      personal.location,
      if (personal.linkedin.trim().isNotEmpty) displayUrl(personal.linkedin),
      if (personal.github.trim().isNotEmpty) displayUrl(personal.github),
      if (personal.portfolio.trim().isNotEmpty) displayUrl(personal.portfolio),
    ].where((part) => part.trim().isNotEmpty).join('  ·  ');

    return Theme(
      data: Theme.of(context).copyWith(textTheme: text),
      child: ListView(
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
                color: scheme.outlineVariant.withValues(alpha: 0.45),
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
              padding: const EdgeInsets.fromLTRB(24, 26, 24, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    personal.fullName.isEmpty ? 'Your name' : personal.fullName,
                    style: text.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      height: 1.08,
                      letterSpacing: 0.2,
                    ),
                  ),
                  if (personal.title.isNotEmpty) ...[
                    const SizedBox(height: 5),
                    Text(
                      personal.title,
                      style: text.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: scheme.onSurface,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                  if (contact.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      contact,
                      style: text.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                        height: 1.35,
                      ),
                    ),
                  ],
                  const SizedBox(height: 14),
                  Divider(
                    height: 1,
                    color: scheme.primary.withValues(alpha: 0.7),
                  ),
                  if (data.summary.trim().isNotEmpty) ...[
                    const SizedBox(height: 16),
                    _SectionLabel('Summary'),
                    Text(
                      data.summary,
                      style: text.bodyMedium?.copyWith(height: 1.4),
                    ),
                  ],
                  if (data.experiences.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    _SectionLabel(SectionKeys.label(SectionKeys.experience)),
                    for (final item in data.experiences) ...[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              item.role.trim().isNotEmpty
                                  ? item.role
                                  : item.company,
                              style: text.titleSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          if (item.startDate.isNotEmpty ||
                              item.endDate.isNotEmpty ||
                              item.isCurrent)
                            Text(
                              [
                                    item.startDate,
                                    item.isCurrent ? 'Present' : item.endDate,
                                  ]
                                  .where((part) => part.trim().isNotEmpty)
                                  .join(' – '),
                              style: text.bodySmall?.copyWith(
                                color: scheme.onSurfaceVariant,
                              ),
                            ),
                        ],
                      ),
                      if (item.role.trim().isNotEmpty &&
                          item.company.trim().isNotEmpty)
                        Text(
                          item.company,
                          style: text.bodySmall?.copyWith(
                            color: scheme.onSurfaceVariant,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      for (final bullet in item.bullets.take(4))
                        Padding(
                          padding: const EdgeInsets.only(top: 3, left: 2),
                          child: Text('•  $bullet', style: text.bodySmall),
                        ),
                      const SizedBox(height: 12),
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
                              ]
                              .where((part) => part.trim().isNotEmpty)
                              .join('  ·  '),
                          style: text.bodyMedium,
                        ),
                      ),
                  ],
                  if (data.skillGroups.isNotEmpty) ...[
                    _SectionLabel(SectionKeys.label(SectionKeys.skills)),
                    for (final group in data.skillGroups)
                      if (group.skills.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text.rich(
                            TextSpan(
                              children: [
                                if (group.name.isNotEmpty)
                                  TextSpan(
                                    text: '${group.name}  ',
                                    style: text.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                TextSpan(
                                  text:
                                      [
                                            for (final skill in group.skills)
                                              skill.name,
                                          ]
                                          .where(
                                            (name) => name.trim().isNotEmpty,
                                          )
                                          .join('  ·  '),
                                  style: text.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
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
      padding: const EdgeInsets.only(bottom: 8, top: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              letterSpacing: 0.8,
              fontWeight: FontWeight.w800,
              color: scheme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Divider(height: 1, thickness: 0.8, color: scheme.primary),
        ],
      ),
    );
  }
}
