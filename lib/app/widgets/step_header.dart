import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';

class StepHeader extends StatelessWidget {
  const StepHeader({
    super.key,
    required this.step,
    this.total = 4,
  });

  final int step;
  final int total;

  static const _labels = ['Details', 'Job', 'Template', 'Export'];

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final progress = (step / total).clamp(0.0, 1.0);
    final label = step >= 1 && step <= _labels.length
        ? _labels[step - 1]
        : 'Step $step';

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenPadding,
        4,
        AppSpacing.screenPadding,
        AppSpacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Step $step of $total',
                style: textTheme.bodySmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                ),
              ),
              const Spacer(),
              Text(
                label,
                style: textTheme.bodySmall?.copyWith(
                  color: scheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadii.full),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: progress),
              duration: AppDurations.emphasized,
              curve: AppCurves.standard,
              builder: (context, value, _) {
                return LinearProgressIndicator(
                  value: value,
                  minHeight: 5,
                  backgroundColor: scheme.surfaceContainerHighest,
                  color: scheme.primary,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
