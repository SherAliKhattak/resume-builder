import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/widgets/app_text_field.dart';
import '../../../../app/widgets/form_sheet.dart';
import '../../../../app/widgets/repeatable_list_page.dart';
import '../../domain/models/profile_models.dart';
import '../cubit/education_cubit.dart';

class EducationPage extends StatelessWidget {
  const EducationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EducationCubit, List<Education>>(
      builder: (context, items) {
        final cubit = context.read<EducationCubit>();
        return RepeatableListPage<Education>(
          title: 'Education',
          items: items,
          emptyMessage: 'No schools yet. Add your latest program.',
          addLabel: 'Add school',
          itemTitle: (item) => item.school.isEmpty ? 'New school' : item.school,
          itemSubtitle: (item) => [
            item.degree,
            item.field,
          ].where((part) => part.isNotEmpty).join(' · '),
          idOf: (item) => item.id,
          onAdd: () => _open(context, cubit, const Education()),
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
    EducationCubit cubit,
    Education item,
  ) async {
    final school = TextEditingController(text: item.school);
    final degree = TextEditingController(text: item.degree);
    final field = TextEditingController(text: item.field);
    final start = TextEditingController(text: item.startDate);
    final end = TextEditingController(text: item.endDate);
    final details = TextEditingController(text: item.details);

    try {
      await showFormSheet(
        context: context,
        title: item.id == 0 ? 'Add school' : 'Edit school',
        primaryLabel: 'Done',
        fields: [
          AppTextField(
            label: 'School',
            hint: 'University of Texas',
            controller: school,
          ),
          AppTextField(
            label: 'Degree',
            hint: 'B.S.',
            controller: degree,
          ),
          AppTextField(
            label: 'Field',
            hint: 'Computer Science',
            controller: field,
          ),
          AppTextField(
            label: 'Start',
            hint: '2015',
            controller: start,
          ),
          AppTextField(
            label: 'End',
            hint: '2019',
            controller: end,
          ),
          AppTextField(
            label: 'Notes',
            hint: 'Thesis, honors, or coursework',
            controller: details,
            maxLines: 3,
            minLines: 2,
          ),
        ],
        onSave: () {
          cubit.save(
            item.copyWith(
              school: school.text.trim(),
              degree: degree.text.trim(),
              field: field.text.trim(),
              startDate: start.text.trim(),
              endDate: end.text.trim(),
              details: details.text.trim(),
            ),
          );
        },
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
      disposeSheetControllers([school, degree, field, start, end, details]);
    }
  }
}
