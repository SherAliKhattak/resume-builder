import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../app/di.dart';
import '../../app/theme/app_colors.dart';
import '../../core/errors/error_logger.dart';
import 'ads_config.dart';
import 'ads_service.dart';

class BannerAdSlot extends StatefulWidget {
  const BannerAdSlot({super.key});

  @override
  State<BannerAdSlot> createState() => _BannerAdSlotState();
}

class _BannerAdSlotState extends State<BannerAdSlot> {
  BannerAd? _ad;
  var _ready = false;
  int? _width;

  bool get _supported {
    if (!getIt.isRegistered<AdsService>()) return false;
    return getIt<AdsService>().supported;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _load();
  }

  Future<void> _load() async {
    if (!_supported) return;
    final width = MediaQuery.sizeOf(context).width.truncate();
    if (width <= 0 || width == _width) return;
    _width = width;

    await _ad?.dispose();
    _ad = null;
    if (mounted) setState(() => _ready = false);

    AdSize size = AdSize.banner;
    try {
      final adaptive = await AdSize.getLargeAnchoredAdaptiveBannerAdSize(width);
      if (adaptive != null) size = adaptive;
    } catch (error, stack) {
      logAppError('Ads.banner.size', error, stack);
    }
    if (!mounted) return;

    final ad = BannerAd(
      size: size,
      adUnitId: AdsConfig.bannerUnitId,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (loaded) {
          if (!mounted) {
            loaded.dispose();
            return;
          }
          setState(() => _ready = true);
        },
        onAdFailedToLoad: (failed, error) {
          failed.dispose();
          logAppError('Ads.banner.load', error);
          if (mounted) {
            setState(() {
              _ad = null;
              _ready = false;
            });
          }
        },
      ),
    );
    _ad = ad;
    try {
      await ad.load();
    } catch (error, stack) {
      logAppError('Ads.banner.load', error, stack);
      await ad.dispose();
      if (_ad == ad) _ad = null;
    }
  }

  @override
  void dispose() {
    _ad?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready || _ad == null) return const SizedBox.shrink();
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface.withValues(alpha: 0.72),
        border: Border(
          top: BorderSide(
            color: Theme.of(context).brightness == Brightness.dark
                ? scheme.outlineVariant.withValues(alpha: 0.4)
                : AppColors.fieldBorder,
          ),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        height: _ad!.size.height.toDouble(),
        child: Center(child: AdWidget(ad: _ad!)),
      ),
    );
  }
}
