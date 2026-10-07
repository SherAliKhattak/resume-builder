import 'package:flutter/material.dart';

import '../../../../app/theme/app_spacing.dart';
import '../../domain/models/ats_review.dart';

class AiReviewCard extends StatelessWidget {
  const AiReviewCard({
    super.key,
    required this.review,
    required this.onAddSkill,
    required this.onApplySummary,
  });

  final AtsReview review;
  final ValueChanged<String> onAddSkill;
  final VoidCallback onApplySummary;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '${review.score}%',
              textAlign: TextAlign.center,
              style: textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'How well you match',
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            _BulletSection(title: 'Strengths', items: review.strengths),
            _BulletSection(title: 'Weaknesses', items: review.weaknesses),
            if (review.missingKeywords.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.lg),
              Text('Suggested skills', style: textTheme.titleSmall),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  for (final skill in review.missingKeywords)
                    ActionChip(
                      label: Text('Add $skill'),
                      onPressed: () => onAddSkill(skill),
                    ),
                ],
              ),
            ],
            if (review.alternativeWords.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.lg),
              Text('Word swaps', style: textTheme.titleSmall),
              const SizedBox(height: AppSpacing.sm),
              for (final entry in review.alternativeWords.entries)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                  child: Text('${entry.key} → ${entry.value}'),
                ),
            ],
            if (review.profileSummary != null) ...[
              const SizedBox(height: AppSpacing.lg),
              Text('Suggested summary', style: textTheme.titleSmall),
              const SizedBox(height: AppSpacing.sm),
              Text(review.profileSummary!),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: onApplySummary,
                  child: const Text('Use this summary'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _BulletSection extends StatelessWidget {
  const _BulletSection({required this.title, required this.items});

  final String title;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: AppSpacing.sm),
          for (final item in items)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
              child: Text('• $item'),
            ),
        ],
      ),
    );
  }
}
