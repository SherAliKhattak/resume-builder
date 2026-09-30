import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/widgets/app_text_field.dart';
import '../../../../app/widgets/form_sheet.dart';
import '../../../../app/widgets/repeatable_list_page.dart';
import '../../domain/models/profile_models.dart';
import '../cubit/experience_cubit.dart';

class ExperiencePage extends StatelessWidget {
  const ExperiencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExperienceCubit, List<Experience>>(
      builder: (context, items) {
        final cubit = context.read<ExperienceCubit>();
        return RepeatableListPage<Experience>(
          title: 'Work experience',
          items: items,
          emptyMessage: 'No jobs yet. Add your most recent role.',
          addLabel: 'Add job',
          itemTitle: (item) =>
              item.role.isEmpty ? 'New role' : item.role,
          itemSubtitle: (item) => [
            item.company,
            _range(item),
          ].where((part) => part.isNotEmpty).join(' · '),
          idOf: (item) => item.id,
          onAdd: () => _open(context, cubit, const Experience()),
          onEdit: (item) => _open(context, cubit, item),
          onDelete: cubit.remove,
          onUndo: cubit.undoRemove,
          onReorder: cubit.reorder,
        );
      },
    );
  }

  String _range(Experience item) {
    if (item.isCurrent) {
      return item.startDate.isEmpty ? 'Present' : '${item.startDate} – Present';
    }
    if (item.startDate.isEmpty && item.endDate.isEmpty) return '';
    return '${item.startDate} – ${item.endDate}';
  }

  Future<void> _open(
    BuildContext context,
    ExperienceCubit cubit,
    Experience item,
  ) async {
    var role = item.role;
    var company = item.company;
    var start = item.startDate;
    var end = item.endDate;
    var bullets = item.bullets.join('\n');
    var current = item.isCurrent;

    await showFormSheet(
      context: context,
      title: item.id == 0 ? 'Add job' : 'Edit job',
      primaryLabel: 'Done',
      fields: [
        AppTextField(
          label: 'Role',
          hint: 'Senior designer',
          initialValue: role,
          onChanged: (value) => role = value,
          textCapitalization: TextCapitalization.sentences,
        ),
        AppTextField(
          label: 'Company',
          hint: 'Northwind Labs',
          initialValue: company,
          onChanged: (value) => company = value,
          textCapitalization: TextCapitalization.words,
        ),
        AppTextField(
          label: 'Start',
          hint: 'Jan 2022',
          initialValue: start,
          onChanged: (value) => start = value,
        ),
        StatefulBuilder(
          builder: (context, setState) {
            return Column(
              children: [
                if (!current)
                  AppTextField(
                    label: 'End',
                    hint: 'Mar 2024',
                    initialValue: end,
                    onChanged: (value) => end = value,
                  ),
                AppSwitchField(
                  label: 'I still work here',
                  value: current,
                  onChanged: (value) => setState(() => current = value),
                ),
              ],
            );
          },
        ),
        BulletField(
          initialValue: bullets,
          onChanged: (value) => bullets = value,
        ),
      ],
      onSave: () {
        cubit.save(
          item.copyWith(
            role: role.trim(),
            company: company.trim(),
            startDate: start.trim(),
            endDate: current ? '' : end.trim(),
            isCurrent: current,
            bullets: bulletsFromText(bullets),
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
