import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/widgets/app_text_field.dart';
import '../../../../app/widgets/form_sheet.dart';
import '../../../../app/widgets/repeatable_list_page.dart';
import '../../domain/models/profile_models.dart';
import '../cubit/awards_cubit.dart';

class AwardsPage extends StatelessWidget {
  const AwardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AwardsCubit, List<Award>>(
      builder: (context, items) {
        final cubit = context.read<AwardsCubit>();
        return RepeatableListPage<Award>(
          title: 'Awards',
          items: items,
          emptyMessage: 'No awards yet. Add one if you like.',
          addLabel: 'Add award',
          itemTitle: (item) => item.title.isEmpty ? 'New award' : item.title,
          itemSubtitle: (item) =>
              [item.issuer, item.date].where((p) => p.isNotEmpty).join(' · '),
          idOf: (item) => item.id,
          onAdd: () => _open(context, cubit, const Award()),
          onEdit: (item) => _open(context, cubit, item),
          onDelete: cubit.remove,
          onUndo: cubit.undoRemove,
          onReorder: cubit.reorder,
        );
      },
    );
  }

  Future<void> _open(BuildContext context, AwardsCubit cubit, Award item) async {
    var title = item.title;
    var issuer = item.issuer;
    var date = item.date;
    var description = item.description;
    await showFormSheet(
      context: context,
      title: item.id == 0 ? 'Add award' : 'Edit award',
      primaryLabel: 'Done',
      fields: [
        AppTextField(
          label: 'Award',
          hint: 'Engineering Excellence',
          initialValue: title,
          onChanged: (value) => title = value,
        ),
        AppTextField(
          label: 'From',
          hint: 'Northwind Labs',
          initialValue: issuer,
          onChanged: (value) => issuer = value,
        ),
        AppTextField(
          label: 'Date',
          hint: '2024',
          initialValue: date,
          onChanged: (value) => date = value,
        ),
        AppTextField(
          label: 'Notes',
          hint: 'For shipping the offline mobile suite.',
          initialValue: description,
          onChanged: (value) => description = value,
          maxLines: 3,
          minLines: 2,
        ),
      ],
      onSave: () => cubit.save(
        item.copyWith(
          title: title.trim(),
          issuer: issuer.trim(),
          date: date.trim(),
          description: description.trim(),
        ),
      ),
      onDelete: item.id == 0
          ? null
          : () {
              cubit.remove(item);
              showUndoBar(
                context: context,
                message: 'Removed',
                onUndo: cubit.undoRemove,
              );
            },
    );
  }
}
