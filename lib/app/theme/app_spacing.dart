import 'package:flutter/animation.dart';

class AppSpacing {
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
  static const xxl = 48.0;

  static const tapTarget = 48.0;
  static const screenPadding = 20.0;
}

class AppRadii {
  static const sm = 10.0;
  static const md = 14.0;
  static const lg = 18.0;
  static const xl = 24.0;
  static const full = 99.0;
}

class AppDurations {
  static const fast = Duration(milliseconds: 180);
  static const medium = Duration(milliseconds: 280);
  static const emphasized = Duration(milliseconds: 380);
  static const saved = Duration(milliseconds: 1400);
  static const snackBar = Duration(seconds: 2);
}

class AppCurves {
  static const standard = Curves.easeOutCubic;
  static const emphasized = Curves.easeInOutCubic;
}
