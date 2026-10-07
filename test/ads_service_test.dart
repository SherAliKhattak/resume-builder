import 'package:flutter_test/flutter_test.dart';
import 'package:resume_builder/features/ads/ads_service.dart';

void main() {
  test('NoOp ads never claim support or throw', () async {
    const ads = NoOpAdsService();
    expect(ads.supported, isFalse);
    await ads.initialize();
    await ads.showInterstitial();
  });

  test('interstitials wait out the minimum interval', () {
    final first = DateTime.utc(2026, 10, 1, 10);
    expect(
      canShowInterstitial(null, first, const Duration(seconds: 45)),
      isTrue,
    );
    expect(
      canShowInterstitial(
        first,
        first.add(const Duration(seconds: 44)),
        const Duration(seconds: 45),
      ),
      isFalse,
    );
    expect(
      canShowInterstitial(
        first,
        first.add(const Duration(seconds: 45)),
        const Duration(seconds: 45),
      ),
      isTrue,
    );
  });
}
