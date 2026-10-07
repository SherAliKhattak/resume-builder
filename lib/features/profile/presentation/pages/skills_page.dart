import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_spacing.dart';
import '../../../../app/widgets/app_screen.dart';
import '../../../../app/widgets/app_text_field.dart';
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
        final scheme = Theme.of(context).colorScheme;
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
                    color: scheme.onSurfaceVariant,
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
              if (groups.length > 1) ...[
                Text(
                  'Hold a skill, then drop it on another group.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
              ],
              for (final group in groups) ...[
                _SkillGroupCard(
                  group: group,
                  onAddSkill: () => _addSkill(context, cubit, group),
                  onRemoveGroup: () {
                    cubit.removeGroup(group);
                    showUndoBar(
                      context: context,
                      message: 'Group removed',
                      onUndo: cubit.undoGroup,
                    );
                  },
                  onRemoveSkill: (skill) {
                    cubit.removeSkill(skill);
                    showUndoBar(
                      context: context,
                      message: 'Removed ${skill.name}',
                      onUndo: cubit.undoSkill,
                    );
                  },
                  onAcceptSkill: (skill) {
                    HapticFeedback.selectionClick();
                    cubit.moveSkill(skill, group.id);
                  },
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
    final name = TextEditingController(text: 'Skills');
    try {
      await showFormSheet(
        context: context,
        title: 'New group',
        primaryLabel: 'Add',
        fields: [
          AppTextField(
            label: 'Group name',
            hint: 'Building, Design, Languages',
            controller: name,
          ),
        ],
        onSave: () => cubit.addGroup(name.text),
      );
    } finally {
      disposeSheetControllers([name]);
    }
  }

  Future<void> _addSkill(
    BuildContext context,
    SkillsCubit cubit,
    SkillGroup group,
  ) async {
    final skill = TextEditingController();
    try {
      await showFormSheet(
        context: context,
        title: 'Add a skill',
        primaryLabel: 'Add',
        fields: [
          AppTextField(
            label: 'Skill',
            hint: 'Flutter',
            controller: skill,
          ),
        ],
        onSave: () => cubit.addSkill(group.id, skill.text),
      );
    } finally {
      disposeSheetControllers([skill]);
    }
  }
}

class _SkillGroupCard extends StatelessWidget {
  const _SkillGroupCard({
    required this.group,
    required this.onAddSkill,
    required this.onRemoveGroup,
    required this.onRemoveSkill,
    required this.onAcceptSkill,
  });

  final SkillGroup group;
  final VoidCallback onAddSkill;
  final VoidCallback onRemoveGroup;
  final ValueChanged<Skill> onRemoveSkill;
  final ValueChanged<Skill> onAcceptSkill;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return DragTarget<Skill>(
      onWillAcceptWithDetails: (details) => details.data.groupId != group.id,
      onAcceptWithDetails: (details) => onAcceptSkill(details.data),
      builder: (context, candidate, rejected) {
        final hovering = candidate.isNotEmpty;
        return Card(
          color: hovering ? scheme.primaryContainer : null,
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
                      onPressed: onRemoveGroup,
                      icon: const Icon(Icons.delete_outline_rounded),
                    ),
                  ],
                ),
                if (group.skills.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: AppSpacing.sm,
                      right: AppSpacing.sm,
                    ),
                    child: Text(
                      hovering
                          ? 'Drop here to move it into ${group.name}'
                          : 'No skills yet',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.sm),
                    child: Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: [
                        for (final skill in group.skills)
                          _DraggableSkillChip(
                            skill: skill,
                            onDeleted: () => onRemoveSkill(skill),
                          ),
                      ],
                    ),
                  ),
                TextButton(
                  onPressed: onAddSkill,
                  child: const Text('Add skill'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _DraggableSkillChip extends StatelessWidget {
  const _DraggableSkillChip({
    required this.skill,
    required this.onDeleted,
  });

  final Skill skill;
  final VoidCallback onDeleted;

  @override
  Widget build(BuildContext context) {
    final chip = Chip(
      label: Text(skill.name),
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onDeleted: onDeleted,
    );
    return LongPressDraggable<Skill>(
      data: skill,
      dragAnchorStrategy: pointerDragAnchorStrategy,
      feedback: Material(
        color: Colors.transparent,
        child: Chip(
          label: Text(skill.name),
          visualDensity: VisualDensity.compact,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
      childWhenDragging: Opacity(opacity: 0.35, child: chip),
      child: chip,
    );
  }
}
