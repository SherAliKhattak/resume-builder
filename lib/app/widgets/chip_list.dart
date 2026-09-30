import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

enum ChipTone { neutral, matched, consider }

class ChipList extends StatelessWidget {
  const ChipList({
    super.key,
    required this.items,
    this.tone = ChipTone.neutral,
    this.onDeleted,
  });

  final List<String> items;
  final ChipTone tone;
  final ValueChanged<String>? onDeleted;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    final scheme = Theme.of(context).colorScheme;
    final dark = scheme.brightness == Brightness.dark;
    late final Color background;
    late final Color foreground;
    switch (tone) {
      case ChipTone.matched:
        background = dark
            ? const Color(0xFF14532D).withValues(alpha: 0.55)
            : AppColors.matchedContainer;
        foreground = dark ? const Color(0xFF86EFAC) : AppColors.matched;
      case ChipTone.consider:
        background = dark
            ? const Color(0xFF7C2D12).withValues(alpha: 0.5)
            : AppColors.considerContainer;
        foreground = dark ? const Color(0xFFFDBA74) : AppColors.consider;
      case ChipTone.neutral:
        background = scheme.surfaceContainerHighest;
        foreground = scheme.onSurface;
    }

    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        for (final item in items)
          Chip(
            label: Text(item),
            backgroundColor: background,
            labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: foreground,
              fontWeight: FontWeight.w600,
            ),
            onDeleted: onDeleted == null ? null : () => onDeleted!(item),
            deleteIconColor: foreground,
            visualDensity: VisualDensity.compact,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
      ],
    );
  }
}
