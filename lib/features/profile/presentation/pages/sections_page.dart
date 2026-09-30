import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_spacing.dart';
import '../../../../app/widgets/app_screen.dart';
import '../../../../core/constants/section_keys.dart';
import '../../../export/domain/models/resume_settings.dart';
import '../cubit/sections_cubit.dart';

class SectionsPage extends StatelessWidget {
  const SectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SectionsCubit, ResumeSettings>(
      builder: (context, settings) {
        final cubit = context.read<SectionsCubit>();
        final order = settings.sectionOrder.isEmpty
            ? SectionKeys.defaultOrder
            : settings.sectionOrder;
        return AppScreen(
          title: 'Sections',
          primaryLabel: 'Done',
          onPrimary: () => context.pop(),
          body: ReorderableListView.builder(
            padding: const EdgeInsets.all(AppSpacing.screenPadding),
            itemCount: order.length,
            onReorder: cubit.reorder,
            proxyDecorator: (child, index, animation) {
              return AnimatedBuilder(
                animation: animation,
                builder: (context, child) {
                  final t = AppCurves.standard.transform(animation.value);
                  return Transform.scale(
                    scale: 1 + (0.02 * t),
                    child: Material(
                      elevation: 2 + 6 * t,
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(AppRadii.lg),
                      child: child,
                    ),
                  );
                },
                child: child,
              );
            },
            itemBuilder: (context, index) {
              final key = order[index];
              final visible = settings.isSectionVisible(key);
              return Padding(
                key: ValueKey(key),
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: Card(
                  child: ListTile(
                    title: Text(SectionKeys.label(key)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Switch(
                          value: visible,
                          onChanged: (value) => cubit.toggleVisible(key, value),
                        ),
                        ReorderableDragStartListener(
                          index: index,
                          child: const Padding(
                            padding: EdgeInsets.all(AppSpacing.sm),
                            child: Icon(Icons.drag_handle_rounded),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
