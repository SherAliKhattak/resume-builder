import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
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

    return Material(
      color: scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.lg),
        side: BorderSide(
          color: Theme.of(context).brightness == Brightness.dark
              ? scheme.outlineVariant.withValues(alpha: 0.4)
              : AppColors.fieldBorder,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.lg),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: scheme.onSurface.withValues(alpha: 0.04),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  hidden
                      ? Icons.visibility_off_outlined
                      : icon ?? Icons.circle_outlined,
                  size: 18,
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: textTheme.titleMedium?.copyWith(
                    color: hidden ? scheme.onSurfaceVariant : scheme.onSurface,
                  ),
                ),
              ),
              if (hidden)
                Icon(
                  Icons.chevron_right_rounded,
                  color: scheme.onSurfaceVariant,
                )
              else if (complete)
                Icon(Icons.check_rounded, size: 20, color: scheme.onSurface)
              else
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
