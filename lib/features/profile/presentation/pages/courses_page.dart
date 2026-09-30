import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/widgets/app_text_field.dart';
import '../../../../app/widgets/form_sheet.dart';
import '../../../../app/widgets/repeatable_list_page.dart';
import '../../domain/models/profile_models.dart';
import '../cubit/courses_cubit.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursesCubit, List<Course>>(
      builder: (context, items) {
        final cubit = context.read<CoursesCubit>();
        return RepeatableListPage<Course>(
          title: 'Courses and certifications',
          items: items,
          emptyMessage: 'No courses yet. Add one you want on the resume.',
          addLabel: 'Add course',
          itemTitle: (item) => item.name.isEmpty ? 'New course' : item.name,
          itemSubtitle: (item) =>
              [item.issuer, item.date].where((p) => p.isNotEmpty).join(' · '),
          idOf: (item) => item.id,
          onAdd: () => _open(context, cubit, const Course()),
          onEdit: (item) => _open(context, cubit, item),
          onDelete: cubit.remove,
          onUndo: cubit.undoRemove,
          onReorder: cubit.reorder,
        );
      },
    );
  }

  Future<void> _open(BuildContext context, CoursesCubit cubit, Course item) async {
    var name = item.name;
    var issuer = item.issuer;
    var date = item.date;
    var url = item.url;
    await showFormSheet(
      context: context,
      title: item.id == 0 ? 'Add course' : 'Edit course',
      primaryLabel: 'Done',
      fields: [
        AppTextField(
          label: 'Name',
          hint: 'AWS Cloud Practitioner',
          initialValue: name,
          onChanged: (value) => name = value,
        ),
        AppTextField(
          label: 'From',
          hint: 'Amazon',
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
          label: 'Link',
          hint: 'credential.net/abc',
          initialValue: url,
          onChanged: (value) => url = value,
          keyboardType: TextInputType.url,
          textCapitalization: TextCapitalization.none,
        ),
      ],
      onSave: () => cubit.save(
        item.copyWith(
          name: name.trim(),
          issuer: issuer.trim(),
          date: date.trim(),
          url: url.trim(),
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
