import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';
import 'app_screen.dart';
import 'form_sheet.dart';

class RepeatableListPage<T> extends StatelessWidget {
  const RepeatableListPage({
    super.key,
    required this.title,
    required this.items,
    required this.emptyMessage,
    required this.addLabel,
    required this.itemTitle,
    required this.onEdit,
    required this.onDelete,
    required this.onReorder,
    required this.onAdd,
    required this.onUndo,
    this.itemSubtitle,
    this.idOf,
  });

  final String title;
  final List<T> items;
  final String emptyMessage;
  final String addLabel;
  final String Function(T) itemTitle;
  final String Function(T)? itemSubtitle;
  final Object Function(T)? idOf;
  final ValueChanged<T> onEdit;
  final ValueChanged<T> onDelete;
  final void Function(int oldIndex, int newIndex) onReorder;
  final VoidCallback onAdd;
  final VoidCallback onUndo;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return AppScreen(
      title: title,
      primaryLabel: addLabel,
      onPrimary: onAdd,
      body: Stack(
        children: [
          ReorderableListView.builder(
            buildDefaultDragHandles: false,
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenPadding,
              AppSpacing.sm,
              AppSpacing.screenPadding,
              AppSpacing.lg,
            ),
            itemCount: items.length,
            onReorder: onReorder,
            proxyDecorator: (child, index, animation) {
              return AnimatedBuilder(
                animation: animation,
                builder: (context, child) {
                  final t = AppCurves.standard.transform(animation.value);
                  return Transform.scale(
                    scale: 1 + (0.02 * t),
                    child: Material(
                      elevation: 2 + 6 * t,
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(AppRadii.lg),
                      child: child,
                    ),
                  );
                },
                child: child,
              );
            },
            itemBuilder: (itemContext, index) {
              final item = items[index];
              return Padding(
                key: ValueKey(idOf?.call(item) ?? '${itemTitle(item)}-$index'),
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: Dismissible(
                  key: ValueKey('dismiss-${idOf?.call(item) ?? index}'),
                  direction: DismissDirection.endToStart,
                  background: DecoratedBox(
                    decoration: BoxDecoration(
                      color: scheme.errorContainer,
                      borderRadius: BorderRadius.circular(AppRadii.lg),
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: AppSpacing.md),
                        child: Text(
                          'Delete',
                          style: TextStyle(
                            color: scheme.onErrorContainer,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  onDismissed: (_) {
                    onDelete(item);
                    showUndoBar(
                      context: context,
                      message: 'Removed',
                      onUndo: onUndo,
                    );
                  },
                  child: Card(
                    child: ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(
                        AppSpacing.md,
                        AppSpacing.sm,
                        AppSpacing.xs,
                        AppSpacing.sm,
                      ),
                      title: Text(itemTitle(item)),
                      subtitle: itemSubtitle == null
                          ? null
                          : Text(itemSubtitle!(item)),
                      onTap: () => onEdit(item),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            tooltip: 'Delete',
                            onPressed: () {
                              onDelete(item);
                              showUndoBar(
                                context: context,
                                message: 'Removed',
                                onUndo: onUndo,
                              );
                            },
                            icon: const Icon(Icons.delete_outline_rounded),
                          ),
                          ReorderableDragStartListener(
                            index: index,
                            child: const Padding(
                              padding: EdgeInsets.all(AppSpacing.sm),
                              child: Icon(Icons.drag_handle_rounded),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          if (items.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Text(
                  emptyMessage,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
