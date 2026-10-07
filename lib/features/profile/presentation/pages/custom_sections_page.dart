import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/widgets/app_text_field.dart';
import '../../../../app/widgets/form_sheet.dart';
import '../../../../app/widgets/repeatable_list_page.dart';
import '../../domain/models/profile_models.dart';
import '../cubit/custom_sections_cubit.dart';

class CustomSectionsPage extends StatelessWidget {
  const CustomSectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomSectionsCubit, List<CustomSection>>(
      builder: (context, items) {
        final cubit = context.read<CustomSectionsCubit>();
        return RepeatableListPage<CustomSection>(
          title: 'Custom sections',
          items: items,
          emptyMessage: 'Add a section that does not fit the others.',
          addLabel: 'Add section',
          itemTitle: (item) => item.title.isEmpty ? 'New section' : item.title,
          itemSubtitle: (item) => item.body,
          idOf: (item) => item.id,
          onAdd: () => _open(context, cubit, const CustomSection()),
          onEdit: (item) => _open(context, cubit, item),
          onDelete: cubit.remove,
          onUndo: cubit.undoRemove,
          onReorder: cubit.reorder,
        );
      },
    );
  }

  Future<void> _open(
    BuildContext context,
    CustomSectionsCubit cubit,
    CustomSection item,
  ) async {
    final title = TextEditingController(text: item.title);
    final body = TextEditingController(text: item.body);

    try {
      await showFormSheet(
        context: context,
        title: item.id == 0 ? 'Add section' : 'Edit section',
        primaryLabel: 'Done',
        fields: [
          AppTextField(
            label: 'Title',
            hint: 'Volunteer work',
            controller: title,
          ),
          AppTextField(
            label: 'Details',
            hint: 'What you want on the resume.',
            controller: body,
            maxLines: 6,
            minLines: 4,
          ),
        ],
        onSave: () => cubit.save(
          item.copyWith(title: title.text.trim(), body: body.text.trim()),
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
    } finally {
      disposeSheetControllers([title, body]);
    }
  }
}
