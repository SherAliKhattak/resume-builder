import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/errors/app_error.dart';
import '../../core/errors/error_logger.dart';
import '../theme/app_spacing.dart';
import 'app_button.dart';
import 'app_text_field.dart';

Future<void> showFormSheet({
  required BuildContext context,
  required String title,
  required List<Widget> fields,
  required String primaryLabel,
  required FutureOr<void> Function() onSave,
  FutureOr<void> Function()? onDelete,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (sheetContext) {
      Future<void> run(FutureOr<void> Function() action, String name) async {
        try {
          await action();
          if (sheetContext.mounted) Navigator.of(sheetContext).pop();
        } catch (error, stack) {
          logAppError(name, error, stack);
          if (!sheetContext.mounted) return;
          ScaffoldMessenger.of(sheetContext)
            ..clearSnackBars()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  userFacingMessage(
                    error,
                    fallback: 'Could not save that. Try again.',
                  ),
                ),
                duration: AppDurations.snackBar,
                persist: false,
              ),
            );
        }
      }

      return _FormSheetBody(
        title: title,
        fields: fields,
        primaryLabel: primaryLabel,
        onSave: () => unawaited(run(onSave, 'FormSheet.save')),
        onDelete: onDelete == null
            ? null
            : () => unawaited(run(onDelete, 'FormSheet.delete')),
      );
    },
  );
}

void disposeSheetControllers(Iterable<TextEditingController> controllers) {
  Future<void>.delayed(const Duration(milliseconds: 400), () {
    for (final controller in controllers) {
      controller.dispose();
    }
  });
}

class _FormSheetBody extends StatelessWidget {
  const _FormSheetBody({
    required this.title,
    required this.fields,
    required this.primaryLabel,
    required this.onSave,
    this.onDelete,
  });

  final String title;
  final List<Widget> fields;
  final String primaryLabel;
  final VoidCallback onSave;
  final VoidCallback? onDelete;

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
                child: ListView(
                  shrinkWrap: true,
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  children: [
                    for (var index = 0; index < fields.length; index++) ...[
                      if (index > 0) const SizedBox(height: AppSpacing.md),
                      fields[index],
                    ],
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              AppButton(label: primaryLabel, onPressed: onSave),
              if (onDelete != null) ...[
                const SizedBox(height: AppSpacing.xs),
                TextButton(
                  onPressed: onDelete,
                  child: Text(
                    'Delete',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
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
    this.controller,
    this.initialValue = '',
    this.onChanged,
  });

  final TextEditingController? controller;
  final String initialValue;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: 'Highlights',
      hint: 'One point per line, like:\nCut load time by 40%',
      controller: controller,
      initialValue: controller == null ? initialValue : null,
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
