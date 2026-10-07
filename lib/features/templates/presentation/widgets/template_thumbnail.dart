import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../app/theme/app_spacing.dart';

class TemplateThumbnail extends StatelessWidget {
  const TemplateThumbnail({
    super.key,
    required this.name,
    required this.selected,
    required this.onTap,
    this.png,
  });

  final String name;
  final bool selected;
  final VoidCallback onTap;
  final Uint8List? png;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Semantics(
      button: true,
      selected: selected,
      label: name,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  HapticFeedback.selectionClick();
                  onTap();
                },
                borderRadius: BorderRadius.circular(AppRadii.md),
                child: AnimatedContainer(
                  duration: AppDurations.medium,
                  curve: AppCurves.standard,
                  decoration: BoxDecoration(
                    color: scheme.surface,
                    borderRadius: BorderRadius.circular(AppRadii.lg),
                    border: Border.all(
                      color: selected
                          ? scheme.onSurface.withValues(alpha: 0.7)
                          : scheme.outlineVariant.withValues(alpha: 0.35),
                      width: selected ? 1.4 : 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(
                          alpha: selected ? 0.08 : 0.04,
                        ),
                        blurRadius: selected ? 18 : 10,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadii.md - 1),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: png == null
                              ? Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                      AppSpacing.sm,
                                    ),
                                    child: Text(
                                      name,
                                      textAlign: TextAlign.center,
                                      style: textTheme.bodyMedium,
                                    ),
                                  ),
                                )
                              : Image.memory(
                                  png!,
                                  fit: BoxFit.cover,
                                  gaplessPlayback: true,
                                  cacheWidth: 280,
                                ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: AnimatedScale(
                            scale: selected ? 1 : 0,
                            duration: AppDurations.fast,
                            curve: AppCurves.standard,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: scheme.onSurface,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: scheme.shadow.withValues(alpha: 0.2),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Icon(
                                  Icons.check_rounded,
                                  size: 16,
                                  color: scheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          AnimatedDefaultTextStyle(
            duration: AppDurations.fast,
            style: (textTheme.titleMedium ?? const TextStyle()).copyWith(
              fontSize: 13,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
              color: scheme.onSurface,
            ),
            child: Text(
              name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
