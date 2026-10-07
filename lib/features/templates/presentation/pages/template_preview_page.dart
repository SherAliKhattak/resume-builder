import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di.dart';
import '../../../../app/widgets/app_screen.dart';
import '../../../export/domain/models/resume_settings.dart';
import '../../../profile/domain/models/resume_data.dart';
import '../../../profile/domain/repositories/resume_repository.dart';
import '../../../../seed/sample_resume.dart';
import '../../domain/resume_template.dart';
import '../../domain/template_registry.dart';
import '../../pdf/pdf_helpers.dart';
import '../../pdf/pdf_safe.dart';
import '../widgets/pdf_raster_view.dart';
import '../widgets/resume_paper_view.dart';

class TemplatePreviewPage extends StatelessWidget {
  const TemplatePreviewPage({super.key, required this.templateId});

  final String templateId;

  @override
  Widget build(BuildContext context) {
    final template = getIt<TemplateRegistry>().byId(templateId);
    return AppScreen(
      title: template.name,
      leading: BackButton(
        onPressed: () {
          if (context.canPop()) {
            context.pop();
            return;
          }
          context.go('/templates');
        },
      ),
      primaryLabel: 'Close',
      onPrimary: () {
        if (context.canPop()) {
          context.pop();
          return;
        }
        context.go('/templates');
      },
      body: _TemplatePreviewBody(template: template),
    );
  }
}

class _TemplatePreviewBody extends StatefulWidget {
  const _TemplatePreviewBody({required this.template});

  final ResumeTemplate template;

  @override
  State<_TemplatePreviewBody> createState() => _TemplatePreviewBodyState();
}

class _TemplatePreviewBodyState extends State<_TemplatePreviewBody> {
  late final Future<ResumeData> _resume;

  @override
  void initState() {
    super.initState();
    _resume = getIt<ResumeRepository>().getResume();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ResumeData>(
      future: _resume,
      builder: (context, snapshot) {
        final live = snapshot.data;
        final preview = live == null
            ? null
            : pdfSafeResume(SampleResume.forPreview(live));
        return PdfRasterView(
          fallback: preview == null ? null : ResumePaperView(data: preview),
          buildPdf: () async {
            final data =
                preview ??
                pdfSafeResume(
                  SampleResume.forPreview(
                    await getIt<ResumeRepository>().getResume(),
                  ),
                );
            final settings = data.settings;
            final doc = await fitToOnePage(
              style: TemplateStyle.fromSettings(settings),
              build: (style) => widget.template.build(data, style),
            );
            return doc.save();
          },
        );
      },
    );
  }
}
