import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../core/constants/section_keys.dart';
import '../../export/domain/models/resume_settings.dart';
import '../../profile/domain/models/profile_models.dart';
import '../../profile/domain/models/resume_data.dart';

PdfColor pdfAccent(int color) => PdfColor.fromInt(color);

String dateRange(String start, String end, {bool current = false}) {
  final right = current ? 'Present' : end;
  if (start.isEmpty) return right;
  if (right.isEmpty) return start;
  return '$start - $right';
}

class PdfLook {
  PdfLook.sans(this.style)
    : base = pw.Font.helvetica(),
      bold = pw.Font.helveticaBold(),
      italic = pw.Font.helveticaOblique(),
      accentFace = pw.Font.helveticaBold();

  PdfLook.serif(this.style)
    : base = pw.Font.times(),
      bold = pw.Font.timesBold(),
      italic = pw.Font.timesItalic(),
      accentFace = pw.Font.timesBold();

  PdfLook.mono(this.style)
    : base = pw.Font.helvetica(),
      bold = pw.Font.helveticaBold(),
      italic = pw.Font.helveticaOblique(),
      accentFace = pw.Font.courierBold();

  final TemplateStyle style;
  final pw.Font base;
  final pw.Font bold;
  final pw.Font italic;
  final pw.Font accentFace;

  PdfColor get accent => pdfAccent(style.accentColor);
  double get size => style.fontSize;
  double get margin => style.margin;

  pw.TextStyle get body => pw.TextStyle(
        font: base,
        fontSize: size,
        lineSpacing: 1.25,
        color: PdfColors.black,
      );
  pw.TextStyle get bodyBold => pw.TextStyle(
        font: bold,
        fontSize: size,
        lineSpacing: 1.25,
        color: PdfColors.black,
      );
  pw.TextStyle get bodyItalic => pw.TextStyle(
        font: italic,
        fontSize: size - 0.5,
        lineSpacing: 1.2,
        color: PdfColors.black,
      );
  pw.TextStyle get small => pw.TextStyle(
        font: base,
        fontSize: size - 1,
        color: PdfColors.black,
      );
  pw.TextStyle get name =>
      pw.TextStyle(font: bold, fontSize: size + 10, lineSpacing: 1, color: PdfColors.black);
  pw.TextStyle get heading => pw.TextStyle(
        font: bold,
        fontSize: size + 1.5,
        color: accent,
        letterSpacing: 0.2,
      );
}

List<pw.Widget> bullets(List<String> items, PdfLook look) {
  if (items.isEmpty) return const [];
  return [
    for (final item in items)
      pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 1.5),
        child: pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Container(
              width: 3.2,
              height: 3.2,
              margin: const pw.EdgeInsets.only(top: 3.6, right: 7),
              decoration: const pw.BoxDecoration(
                color: PdfColors.black,
                shape: pw.BoxShape.circle,
              ),
            ),
            pw.Expanded(
              child: pw.Text(
                item,
                style: item.trim().toLowerCase().startsWith('stack:')
                    ? look.bodyItalic
                    : look.body,
              ),
            ),
          ],
        ),
      ),
  ];
}

pw.Widget sectionTitle(String title, PdfLook look, {bool rule = true}) {
  return pw.Padding(
    padding: const pw.EdgeInsets.only(top: 10, bottom: 5),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(title.toUpperCase(), style: look.heading),
        if (rule)
          pw.Container(
            margin: const pw.EdgeInsets.only(top: 2),
            height: 1,
            color: look.accent,
          ),
      ],
    ),
  );
}

pw.Widget jobHeader(Experience item, PdfLook look) {
  final dates = dateRange(
    item.startDate,
    item.endDate,
    current: item.isCurrent,
  );
  return pw.Padding(
    padding: const pw.EdgeInsets.only(top: 4, bottom: 2),
    child: pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          child: pw.RichText(
            text: pw.TextSpan(
              children: [
                if (item.role.trim().isNotEmpty)
                  pw.TextSpan(text: item.role.trim(), style: look.bodyBold),
                if (item.role.trim().isNotEmpty && item.company.trim().isNotEmpty)
                  pw.TextSpan(text: ' | ', style: look.bodyBold),
                if (item.company.trim().isNotEmpty)
                  pw.TextSpan(text: item.company.trim(), style: look.bodyBold),
              ],
            ),
          ),
        ),
        if (dates.isNotEmpty)
          pw.Padding(
            padding: const pw.EdgeInsets.only(left: 8),
            child: pw.Text(dates, style: look.small),
          ),
      ],
    ),
  );
}

String contactLine(PersonalInfo info) {
  return [
    info.email,
    info.phone,
    info.location,
    info.linkedin,
    info.github,
    info.portfolio,
  ].where((part) => part.trim().isNotEmpty).join('  |  ');
}

bool hasContent(ResumeData data, String key) {
  switch (key) {
    case SectionKeys.summary:
      return data.summary.trim().isNotEmpty;
    case SectionKeys.experience:
      return data.experiences.isNotEmpty;
    case SectionKeys.education:
      return data.educations.isNotEmpty;
    case SectionKeys.skills:
      return data.skillGroups.any((g) => g.skills.isNotEmpty);
    case SectionKeys.courses:
      return data.courses.isNotEmpty;
    case SectionKeys.projects:
      return data.projects.isNotEmpty;
    case SectionKeys.languages:
      return data.languages.isNotEmpty;
    case SectionKeys.awards:
      return data.awards.isNotEmpty;
    case SectionKeys.custom:
      return data.customSections.any((s) => s.isVisible && s.title.isNotEmpty);
    default:
      return false;
  }
}

List<String> orderedKeys(ResumeData data) {
  final order = data.settings.sectionOrder.isEmpty
      ? SectionKeys.defaultOrder
      : data.settings.sectionOrder;
  return [
    for (final key in order)
      if (key != SectionKeys.personal &&
          data.settings.isSectionVisible(key) &&
          hasContent(data, key))
        key,
  ];
}

List<pw.Widget> standardSections(
  ResumeData data,
  PdfLook look, {
  bool compact = false,
}) {
  final gap = compact ? 4.0 : 8.0;
  final widgets = <pw.Widget>[];
  for (final key in orderedKeys(data)) {
    widgets.addAll(sectionWidgets(data, look, key, compact: compact));
    widgets.add(pw.SizedBox(height: gap));
  }
  return widgets;
}

List<pw.Widget> sectionWidgets(
  ResumeData data,
  PdfLook look,
  String key, {
  bool compact = false,
}) {
  switch (key) {
    case SectionKeys.summary:
      return [
        sectionTitle('Summary', look),
        pw.Text(data.summary, style: look.body),
      ];
    case SectionKeys.experience:
      return [
        sectionTitle('Experience', look),
        for (final item in data.experiences) ...[
          jobHeader(item, look),
          ...bullets(item.bullets, look),
          pw.SizedBox(height: compact ? 3 : 6),
        ],
      ];
    case SectionKeys.education:
      return [
        sectionTitle('Education', look),
        for (final item in data.educations) ...[
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                child: pw.Text(
                  item.school.trim().isEmpty
                      ? [item.degree, item.field].where((p) => p.isNotEmpty).join(', ')
                      : item.school,
                  style: look.bodyBold,
                ),
              ),
              pw.Text(
                dateRange(item.startDate, item.endDate),
                style: look.small,
              ),
            ],
          ),
          if (item.school.trim().isNotEmpty &&
              (item.degree.isNotEmpty || item.field.isNotEmpty))
            pw.Text(
              [item.degree, item.field].where((p) => p.isNotEmpty).join(', '),
              style: look.body,
            ),
          if (item.details.isNotEmpty) pw.Text(item.details, style: look.body),
          pw.SizedBox(height: 4),
        ],
      ];
    case SectionKeys.skills:
      return [
        sectionTitle('Skills', look),
        for (final group in data.skillGroups)
          if (group.skills.isNotEmpty)
            pw.Padding(
              padding: const pw.EdgeInsets.only(bottom: 2),
              child: pw.RichText(
                text: pw.TextSpan(
                  children: [
                    if (group.name.isNotEmpty)
                      pw.TextSpan(text: '${group.name}: ', style: look.bodyBold),
                    pw.TextSpan(
                      text: group.skills.map((s) => s.name).join(', '),
                      style: look.body,
                    ),
                  ],
                ),
              ),
            ),
      ];
    case SectionKeys.courses:
      return [
        sectionTitle('Courses and certifications', look),
        ...bullets(
          [
            for (final item in data.courses)
              [item.name, item.issuer, item.date].where((p) => p.isNotEmpty).join(' - '),
          ],
          look,
        ),
      ];
    case SectionKeys.projects:
      return [
        sectionTitle('Projects', look),
        for (final item in data.projects) ...[
          pw.Text(
            item.link.isEmpty ? item.name : '${item.name}  |  ${item.link}',
            style: look.bodyBold,
          ),
          if (item.description.isNotEmpty)
            pw.Text(item.description, style: look.body),
          if (item.techStack.isNotEmpty)
            pw.Text('Stack: ${item.techStack}', style: look.bodyItalic),
          ...bullets(item.bullets, look),
          pw.SizedBox(height: 4),
        ],
      ];
    case SectionKeys.languages:
      return [
        sectionTitle('Languages', look),
        pw.Text(
          [
            for (final item in data.languages)
              [item.name, item.proficiency].where((p) => p.isNotEmpty).join(' - '),
          ].join('  |  '),
          style: look.body,
        ),
      ];
    case SectionKeys.awards:
      return [
        sectionTitle('Key Achievements', look),
        ...bullets(
          [
            for (final item in data.awards)
              [
                item.title,
                item.issuer,
                item.date,
              ].where((p) => p.isNotEmpty).join(' - '),
          ],
          look,
        ),
      ];
    case SectionKeys.custom:
      return [
        for (final item in data.customSections)
          if (item.isVisible && item.title.isNotEmpty) ...[
            sectionTitle(item.title, look),
            pw.Text(item.body, style: look.body),
          ],
      ];
    default:
      return const [];
  }
}

pw.Document multiPageDocument({
  required ResumeData data,
  required PdfLook look,
  required List<pw.Widget> Function(pw.Context context) build,
  PdfPageFormat? format,
}) {
  final doc = pw.Document();
  doc.addPage(
    pw.MultiPage(
      maxPages: 16,
      pageTheme: pw.PageTheme(
        pageFormat: format ?? PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(look.margin),
        theme: pw.ThemeData.withFont(
          base: look.base,
          bold: look.bold,
          italic: look.italic,
        ),
      ),
      build: build,
    ),
  );
  return doc;
}
