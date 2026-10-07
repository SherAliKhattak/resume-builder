import 'package:flutter/foundation.dart';

/// AdMob IDs. Defaults are Google's official test units.
///
/// Replace them before a store release with `--dart-define`, for example:
/// `ADMOB_ANDROID_APP_ID`, `ADMOB_IOS_APP_ID`,
/// `ADMOB_ANDROID_BANNER_ID`, `ADMOB_IOS_BANNER_ID`,
/// `ADMOB_ANDROID_INTERSTITIAL_ID`, `ADMOB_IOS_INTERSTITIAL_ID`.
///
/// The Android/iOS app IDs in the native manifests must also be updated.
class AdsConfig {
  static const androidAppId = String.fromEnvironment(
    'ADMOB_ANDROID_APP_ID',
    defaultValue: 'ca-app-pub-3940256099942544~3347511713',
  );
  static const iosAppId = String.fromEnvironment(
    'ADMOB_IOS_APP_ID',
    defaultValue: 'ca-app-pub-3940256099942544~1458002511',
  );
  static const androidBannerId = String.fromEnvironment(
    'ADMOB_ANDROID_BANNER_ID',
    defaultValue: 'ca-app-pub-3940256099942544/6300978111',
  );
  static const iosBannerId = String.fromEnvironment(
    'ADMOB_IOS_BANNER_ID',
    defaultValue: 'ca-app-pub-3940256099942544/2934735716',
  );
  static const androidInterstitialId = String.fromEnvironment(
    'ADMOB_ANDROID_INTERSTITIAL_ID',
    defaultValue: 'ca-app-pub-3940256099942544/1033173712',
  );
  static const iosInterstitialId = String.fromEnvironment(
    'ADMOB_IOS_INTERSTITIAL_ID',
    defaultValue: 'ca-app-pub-3940256099942544/4411468910',
  );

  static const interstitialMinInterval = Duration(seconds: 45);

  static bool get isIos =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;

  static String get bannerUnitId => isIos ? iosBannerId : androidBannerId;

  static String get interstitialUnitId =>
      isIos ? iosInterstitialId : androidInterstitialId;
}
