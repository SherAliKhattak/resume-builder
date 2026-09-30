import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_spacing.dart';
import '../../../../app/widgets/app_screen.dart';
import '../../../../app/widgets/app_text_field.dart';
import '../cubit/summary_cubit.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({super.key});

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  final _body = TextEditingController();
  bool _seeded = false;

  @override
  void dispose() {
    _body.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SummaryCubit, SummaryState>(
      listener: (context, state) {
        if (_seeded) return;
        _seeded = true;
        _body.text = state.body;
      },
      builder: (context, state) {
        if (!_seeded && state.body.isNotEmpty) {
          _seeded = true;
          _body.text = state.body;
        }
        return AppScreen(
          title: 'Summary',
          showSaved: state.saved,
          primaryLabel: 'Done',
          onPrimary: () async {
            await context.read<SummaryCubit>().flushPending();
            if (context.mounted) context.pop();
          },
          body: Padding(
            padding: const EdgeInsets.all(AppSpacing.screenPadding),
            child: AppTextField(
              label: 'A short introduction',
              hint:
                  'Product-minded engineer who ships simple, reliable apps.',
              controller: _body,
              maxLines: 8,
              minLines: 6,
              keyboardType: TextInputType.multiline,
              onChanged: context.read<SummaryCubit>().onChanged,
            ),
          ),
        );
      },
    );
  }
}
