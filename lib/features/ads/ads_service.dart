import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../core/errors/error_logger.dart';
import 'ads_config.dart';

abstract class AdsService {
  bool get supported;

  Future<void> initialize();

  /// Shows a preloaded interstitial if one is ready and the interval has passed.
  /// Never throws. Continues immediately when no ad is available.
  Future<void> showInterstitial();
}

class NoOpAdsService implements AdsService {
  const NoOpAdsService();

  @override
  bool get supported => false;

  @override
  Future<void> initialize() async {}

  @override
  Future<void> showInterstitial() async {}
}

class AdMobAdsService implements AdsService {
  AdMobAdsService({
    this.minInterval = AdsConfig.interstitialMinInterval,
    DateTime Function()? clock,
  }) : _clock = clock ?? DateTime.now;

  final Duration minInterval;
  final DateTime Function() _clock;

  InterstitialAd? _interstitial;
  DateTime? _lastShown;
  var _loading = false;

  @override
  bool get supported =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS);

  @override
  Future<void> initialize() async {
    if (!supported) return;
    try {
      await MobileAds.instance.initialize();
      preloadInterstitial();
    } catch (error, stack) {
      logAppError('Ads.initialize', error, stack);
    }
  }

  @override
  Future<void> showInterstitial() async {
    if (!supported) return;
    if (!canShowInterstitial(_lastShown, _clock(), minInterval)) {
      return;
    }
    final ad = _interstitial;
    if (ad == null) {
      preloadInterstitial();
      return;
    }
    _interstitial = null;
    final done = Completer<void>();
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (shown) {
        shown.dispose();
        if (!done.isCompleted) done.complete();
        preloadInterstitial();
      },
      onAdFailedToShowFullScreenContent: (shown, error) {
        logAppError('Ads.interstitial.show', error);
        shown.dispose();
        if (!done.isCompleted) done.complete();
        preloadInterstitial();
      },
    );
    try {
      await ad.show();
      _lastShown = _clock();
      await done.future;
    } catch (error, stack) {
      logAppError('Ads.interstitial.show', error, stack);
      ad.dispose();
      if (!done.isCompleted) done.complete();
      preloadInterstitial();
    }
  }

  void preloadInterstitial() {
    if (!supported || _loading || _interstitial != null) return;
    _loading = true;
    InterstitialAd.load(
      adUnitId: AdsConfig.interstitialUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _loading = false;
          _interstitial = ad;
        },
        onAdFailedToLoad: (error) {
          _loading = false;
          logAppError('Ads.interstitial.load', error);
        },
      ),
    );
  }
}

bool canShowInterstitial(
  DateTime? lastShown,
  DateTime now,
  Duration minInterval,
) {
  if (lastShown == null) return true;
  return now.difference(lastShown) >= minInterval;
}

AdsService createAdsService() {
  final candidate = AdMobAdsService();
  return candidate.supported ? candidate : const NoOpAdsService();
}
