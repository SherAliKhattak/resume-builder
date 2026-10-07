import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AppCanvas extends StatelessWidget {
  const AppCanvas({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: dark
              ? const [Color(0xFF15202B), Color(0xFF111827), Color(0xFF0B1220)]
              : const [
                  AppColors.canvasTop,
                  AppColors.canvasMid,
                  AppColors.canvasBottom,
                ],
          stops: const [0, 0.42, 1],
        ),
      ),
      child: child,
    );
  }
}

class GlassOrb extends StatelessWidget {
  const GlassOrb({super.key, this.size = 96});

  final double size;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            center: const Alignment(-0.28, -0.38),
            radius: 0.95,
            colors: dark
                ? const [Color(0xFF93C5FD), Color(0xFF1E3A5F)]
                : const [Color(0xFFFFFFFF), AppColors.orb, Color(0xFF9CC4E6)],
            stops: dark ? const [0.1, 1] : const [0.05, 0.55, 1],
          ),
          boxShadow: [
            BoxShadow(
              color: (dark ? const Color(0xFF60A5FA) : AppColors.orb)
                  .withValues(alpha: 0.45),
              blurRadius: 28,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Icon(
          Icons.auto_awesome,
          size: size * 0.28,
          color: Colors.white.withValues(alpha: 0.92),
        ),
      ),
    );
  }
}
