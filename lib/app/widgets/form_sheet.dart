import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';
import 'app_button.dart';
import 'app_text_field.dart';

Future<void> showFormSheet({
  required BuildContext context,
  required String title,
  required List<Widget> fields,
  required String primaryLabel,
  required VoidCallback onSave,
  VoidCallback? onDelete,
}) async {
  final confirmed = await showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (sheetContext) {
      return _FormSheetBody(
        title: title,
        fields: fields,
        primaryLabel: primaryLabel,
        showDelete: onDelete != null,
      );
    },
  );
  if (confirmed == 'save') {
    onSave();
  } else if (confirmed == 'delete') {
    onDelete?.call();
  }
}

class _FormSheetBody extends StatelessWidget {
  const _FormSheetBody({
    required this.title,
    required this.fields,
    required this.primaryLabel,
    required this.showDelete,
  });

  final String title;
  final List<Widget> fields;
  final String primaryLabel;
  final bool showDelete;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final bottom = media.viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.screenPadding,
        AppSpacing.sm,
        AppSpacing.screenPadding,
        bottom + AppSpacing.md,
      ),
      child: SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: media.size.height * 0.86),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: AppSpacing.md),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  itemCount: fields.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: AppSpacing.md),
                  itemBuilder: (context, index) => fields[index],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              AppButton(
                label: primaryLabel,
                onPressed: () => Navigator.of(context).pop('save'),
              ),
              if (showDelete) ...[
                const SizedBox(height: AppSpacing.xs),
                TextButton(
                  onPressed: () => Navigator.of(context).pop('delete'),
                  child: Text(
                    'Delete',
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

void showUndoBar({
  required BuildContext context,
  required String message,
  required VoidCallback onUndo,
}) {
  final messenger = ScaffoldMessenger.maybeOf(context);
  if (messenger == null) return;
  messenger
    ..clearSnackBars()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
        duration: AppDurations.snackBar,
        persist: false,
        action: SnackBarAction(label: 'Undo', onPressed: onUndo),
      ),
    );
}

class AppSwitchField extends StatelessWidget {
  const AppSwitchField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label, style: Theme.of(context).textTheme.bodyLarge),
      value: value,
      onChanged: onChanged,
    );
  }
}

class BulletField extends StatelessWidget {
  const BulletField({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  final String initialValue;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: 'Highlights',
      hint: 'One point per line, like:\nCut load time by 40%',
      initialValue: initialValue,
      onChanged: onChanged,
      maxLines: 5,
      minLines: 3,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
    );
  }
}

List<String> bulletsFromText(String raw) {
  return raw
      .split('\n')
      .map((line) => line.replaceFirst(RegExp(r'^[\s•\-]+'), '').trim())
      .where((line) => line.isNotEmpty)
      .toList();
}
