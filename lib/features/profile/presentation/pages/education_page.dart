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
    var school = item.school;
    var degree = item.degree;
    var field = item.field;
    var start = item.startDate;
    var end = item.endDate;
    var details = item.details;

    await showFormSheet(
      context: context,
      title: item.id == 0 ? 'Add school' : 'Edit school',
      primaryLabel: 'Done',
      fields: [
        AppTextField(
          label: 'School',
          hint: 'University of Texas',
          initialValue: school,
          onChanged: (value) => school = value,
        ),
        AppTextField(
          label: 'Degree',
          hint: 'B.S.',
          initialValue: degree,
          onChanged: (value) => degree = value,
        ),
        AppTextField(
          label: 'Field',
          hint: 'Computer Science',
          initialValue: field,
          onChanged: (value) => field = value,
        ),
        AppTextField(
          label: 'Start',
          hint: '2015',
          initialValue: start,
          onChanged: (value) => start = value,
        ),
        AppTextField(
          label: 'End',
          hint: '2019',
          initialValue: end,
          onChanged: (value) => end = value,
        ),
        AppTextField(
          label: 'Notes',
          hint: 'Thesis, honors, or coursework',
          initialValue: details,
          onChanged: (value) => details = value,
          maxLines: 3,
          minLines: 2,
        ),
      ],
      onSave: () {
        cubit.save(
          item.copyWith(
            school: school.trim(),
            degree: degree.trim(),
            field: field.trim(),
            startDate: start.trim(),
            endDate: end.trim(),
            details: details.trim(),
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
  }
}
