import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';

class SectionCard extends StatelessWidget {
  const SectionCard({
    super.key,
    required this.title,
    required this.complete,
    required this.onTap,
    this.hidden = false,
    this.icon,
  });

  final String title;
  final bool complete;
  final VoidCallback onTap;
  final bool hidden;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final status = hidden
        ? 'Hidden'
        : complete
        ? 'Ready'
        : 'Add details';
    final statusColor = hidden
        ? scheme.onSurfaceVariant
        : complete
        ? scheme.primary
        : scheme.onSurfaceVariant;

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.lg),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: 14,
          ),
          child: Row(
            children: [
              _StatusGlyph(
                complete: complete,
                hidden: hidden,
                icon: icon,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: textTheme.titleMedium?.copyWith(
                        color: hidden
                            ? scheme.onSurfaceVariant
                            : scheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      status,
                      style: textTheme.bodySmall?.copyWith(color: statusColor),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: scheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusGlyph extends StatelessWidget {
  const _StatusGlyph({
    required this.complete,
    required this.hidden,
    this.icon,
  });

  final bool complete;
  final bool hidden;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final Color background;
    final Color foreground;
    final IconData glyph;
    if (hidden) {
      background = scheme.surfaceContainerHighest;
      foreground = scheme.onSurfaceVariant;
      glyph = Icons.visibility_off_outlined;
    } else if (complete) {
      background = scheme.primaryContainer;
      foreground = scheme.onPrimaryContainer;
      glyph = Icons.check_rounded;
    } else {
      background = scheme.surfaceContainerHighest;
      foreground = scheme.primary;
      glyph = icon ?? Icons.add_rounded;
    }

    return AnimatedContainer(
      duration: AppDurations.fast,
      curve: AppCurves.standard,
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppRadii.sm),
      ),
      child: Icon(glyph, size: 20, color: foreground),
    );
  }
}
