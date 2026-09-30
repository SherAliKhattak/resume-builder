import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';
import 'app_button.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: leading,
        automaticallyImplyLeading: leading == null,
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
      bottomNavigationBar: primaryLabel == null
          ? null
          : BottomActionBar(
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
    );
  }
}
