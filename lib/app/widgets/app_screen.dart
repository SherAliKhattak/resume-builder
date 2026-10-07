import 'package:flutter/material.dart';

import '../../features/ads/banner_ad_slot.dart';
import '../theme/app_spacing.dart';
import 'app_button.dart';
import 'app_canvas.dart';
import 'saved_indicator.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({
    super.key,
    required this.title,
    required this.body,
    this.primaryLabel,
    this.onPrimary,
    this.primaryEnabled = true,
    this.secondary,
    this.header,
    this.actions,
    this.showSaved = false,
    this.leading,
    this.implyLeading = true,
    this.extendBodyBehindAppBar = false,
    this.showBanner = false,
  });

  final String title;
  final Widget body;
  final String? primaryLabel;
  final VoidCallback? onPrimary;
  final bool primaryEnabled;
  final Widget? secondary;
  final Widget? header;
  final List<Widget>? actions;
  final bool showSaved;
  final Widget? leading;
  final bool implyLeading;
  final bool extendBodyBehindAppBar;
  final bool showBanner;

  @override
  Widget build(BuildContext context) {
    return AppCanvas(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        appBar: AppBar(
          title: Text(title),
          leading: leading,
          automaticallyImplyLeading: implyLeading && leading == null,
          actions: [
            if (showSaved)
              const Padding(
                padding: EdgeInsets.only(right: AppSpacing.sm),
                child: Center(child: SavedIndicator(visible: true)),
              ),
            ...?actions,
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ?header,
            Expanded(child: body),
          ],
        ),
        bottomNavigationBar: showBanner || primaryLabel != null
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (showBanner) const BannerAdSlot(),
                  if (primaryLabel != null)
                    BottomActionBar(
                      secondary: secondary,
                      child: AnimatedSwitcher(
                        duration: AppDurations.fast,
                        switchInCurve: AppCurves.standard,
                        switchOutCurve: AppCurves.standard,
                        child: SizedBox(
                          key: ValueKey('$primaryLabel-$primaryEnabled'),
                          width: double.infinity,
                          child: AppButton(
                            label: primaryLabel!,
                            onPressed: onPrimary,
                            enabled: primaryEnabled,
                          ),
                        ),
                      ),
                    ),
                ],
              )
            : null,
      ),
    );
  }
}
