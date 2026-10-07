import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/widgets/app_text_field.dart';
import '../../../../app/widgets/form_sheet.dart';
import '../../../../app/widgets/repeatable_list_page.dart';
import '../../domain/models/profile_models.dart';
import '../cubit/languages_cubit.dart';

class LanguagesPage extends StatelessWidget {
  const LanguagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguagesCubit, List<Language>>(
      builder: (context, items) {
        final cubit = context.read<LanguagesCubit>();
        return RepeatableListPage<Language>(
          title: 'Languages',
          items: items,
          emptyMessage: 'No languages yet. Add the ones you speak.',
          addLabel: 'Add language',
          itemTitle: (item) => item.name.isEmpty ? 'New language' : item.name,
          itemSubtitle: (item) => item.proficiency,
          idOf: (item) => item.id,
          onAdd: () => _open(context, cubit, const Language()),
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
    LanguagesCubit cubit,
    Language item,
  ) async {
    final name = TextEditingController(text: item.name);
    final proficiency = TextEditingController(text: item.proficiency);

    try {
      await showFormSheet(
        context: context,
        title: item.id == 0 ? 'Add language' : 'Edit language',
        primaryLabel: 'Done',
        fields: [
          AppTextField(
            label: 'Language',
            hint: 'Spanish',
            controller: name,
          ),
          AppTextField(
            label: 'Level',
            hint: 'Conversational',
            controller: proficiency,
          ),
        ],
        onSave: () => cubit.save(
          item.copyWith(
            name: name.text.trim(),
            proficiency: proficiency.text.trim(),
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
    } finally {
      disposeSheetControllers([name, proficiency]);
    }
  }
}
