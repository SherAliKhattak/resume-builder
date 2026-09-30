import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_spacing.dart';
import '../../../../app/widgets/app_screen.dart';
import '../../../../app/widgets/app_text_field.dart';
import '../../../../app/widgets/chip_list.dart';
import '../../../../app/widgets/form_sheet.dart';
import '../../domain/models/profile_models.dart';
import '../cubit/skills_cubit.dart';

class SkillsPage extends StatefulWidget {
  const SkillsPage({super.key});

  @override
  State<SkillsPage> createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SkillsCubit, List<SkillGroup>>(
      builder: (context, groups) {
        final cubit = context.read<SkillsCubit>();
        return AppScreen(
          title: 'Skills',
          primaryLabel: groups.isEmpty ? 'Add skill group' : 'Done',
          onPrimary: () {
            if (groups.isEmpty) {
              _addGroup(context, cubit);
            } else {
              context.pop();
            }
          },
          body: ListView(
            padding: const EdgeInsets.all(AppSpacing.screenPadding),
            children: [
              if (groups.isEmpty)
                Text(
                  'Add a group, then type a skill.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                )
              else
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () => _addGroup(context, cubit),
                    child: const Text('Add skill group'),
                  ),
                ),
              for (final group in groups) ...[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.md,
                      AppSpacing.sm,
                      AppSpacing.sm,
                      AppSpacing.sm,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                group.name,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            IconButton(
                              tooltip: 'Remove group',
                              onPressed: () {
                                cubit.removeGroup(group);
                                showUndoBar(
                                  context: context,
                                  message: 'Group removed',
                                  onUndo: cubit.undoGroup,
                                );
                              },
                              icon: const Icon(Icons.delete_outline_rounded),
                            ),
                          ],
                        ),
                        ChipList(
                          items: [
                            for (final skill in group.skills) skill.name,
                          ],
                          onDeleted: (name) {
                            final skill = group.skills.firstWhere(
                              (s) => s.name == name,
                            );
                            cubit.removeSkill(skill);
                            showUndoBar(
                              context: context,
                              message: 'Removed $name',
                              onUndo: cubit.undoSkill,
                            );
                          },
                        ),
                        TextButton(
                          onPressed: () => _addSkill(context, cubit, group),
                          child: const Text('Add skill'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
              ],
            ],
          ),
        );
      },
    );
  }

  Future<void> _addGroup(BuildContext context, SkillsCubit cubit) async {
    var name = 'Skills';
    await showFormSheet(
      context: context,
      title: 'New group',
      primaryLabel: 'Add',
      fields: [
        AppTextField(
          label: 'Group name',
          hint: 'Building, Design, Languages',
          initialValue: name,
          onChanged: (value) => name = value,
        ),
      ],
      onSave: () => cubit.addGroup(name),
    );
  }

  Future<void> _addSkill(
    BuildContext context,
    SkillsCubit cubit,
    SkillGroup group,
  ) async {
    var skill = '';
    await showFormSheet(
      context: context,
      title: 'Add a skill',
      primaryLabel: 'Add',
      fields: [
        AppTextField(
          label: 'Skill',
          hint: 'Flutter',
          initialValue: skill,
          onChanged: (value) => skill = value,
        ),
      ],
      onSave: () => cubit.addSkill(group.id, skill),
    );
  }
}
