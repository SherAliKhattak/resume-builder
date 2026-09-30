import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/widgets/app_text_field.dart';
import '../../../../app/widgets/form_sheet.dart';
import '../../../../app/widgets/repeatable_list_page.dart';
import '../../domain/models/profile_models.dart';
import '../cubit/projects_cubit.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectsCubit, List<Project>>(
      builder: (context, items) {
        final cubit = context.read<ProjectsCubit>();
        return RepeatableListPage<Project>(
          title: 'Projects',
          items: items,
          emptyMessage: 'No projects yet. Add one you are proud of.',
          addLabel: 'Add project',
          itemTitle: (item) => item.name.isEmpty ? 'New project' : item.name,
          itemSubtitle: (item) => item.techStack,
          idOf: (item) => item.id,
          onAdd: () => _open(context, cubit, const Project()),
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
    ProjectsCubit cubit,
    Project item,
  ) async {
    var name = item.name;
    var link = item.link;
    var description = item.description;
    var tech = item.techStack;
    var bullets = item.bullets.join('\n');
    await showFormSheet(
      context: context,
      title: item.id == 0 ? 'Add project' : 'Edit project',
      primaryLabel: 'Done',
      fields: [
        AppTextField(
          label: 'Name',
          hint: 'Garden Log',
          initialValue: name,
          onChanged: (value) => name = value,
        ),
        AppTextField(
          label: 'Link',
          hint: 'github.com/you/garden-log',
          initialValue: link,
          onChanged: (value) => link = value,
          keyboardType: TextInputType.url,
          textCapitalization: TextCapitalization.none,
        ),
        AppTextField(
          label: 'Description',
          hint: 'A small app for tracking plants.',
          initialValue: description,
          onChanged: (value) => description = value,
          maxLines: 3,
          minLines: 2,
        ),
        AppTextField(
          label: 'Tech',
          hint: 'Flutter, SQLite',
          initialValue: tech,
          onChanged: (value) => tech = value,
        ),
        BulletField(
          initialValue: bullets,
          onChanged: (value) => bullets = value,
        ),
      ],
      onSave: () => cubit.save(
        item.copyWith(
          name: name.trim(),
          link: link.trim(),
          description: description.trim(),
          techStack: tech.trim(),
          bullets: bulletsFromText(bullets),
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
