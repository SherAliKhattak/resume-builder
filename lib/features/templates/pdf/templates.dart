import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../export/domain/models/resume_settings.dart';
import '../../profile/domain/models/resume_data.dart';
import '../domain/resume_template.dart';
import 'pdf_helpers.dart';

class ClassicTemplate implements ResumeTemplate {
  @override
  String get id => 'classic';
  @override
  String get name => 'Classic';

  @override
  Future<pw.Document> build(ResumeData data, TemplateStyle style) async {
    final look = PdfLook.sans(style);
    return multiPageDocument(
      data: data,
      look: look,
      build: (_) => [
        pw.Text(data.personal.fullName, style: look.name),
        if (data.personal.title.isNotEmpty)
          pw.Text(data.personal.title, style: look.small),
        pw.SizedBox(height: 4),
        pw.Text(contactLine(data.personal), style: look.small),
        ...standardSections(data, look),
      ],
    );
  }
}

class AtsPlainTemplate implements ResumeTemplate {
  @override
  String get id => 'ats-plain';
  @override
  String get name => 'ATS Plain';

  @override
  Future<pw.Document> build(ResumeData data, TemplateStyle style) async {
    final look = PdfLook.sans(
      TemplateStyle(
        accentColor: 0xFF111111,
        fontSize: style.fontSize,
        margin: style.margin,
      ),
    );
    return multiPageDocument(
      data: data,
      look: look,
      build: (_) => [
        pw.Text(data.personal.fullName, style: look.name),
        pw.Text(data.personal.title, style: look.body),
        pw.Text(contactLine(data.personal), style: look.body),
        ...standardSections(data, look),
      ],
    );
  }
}

class ModernTemplate implements ResumeTemplate {
  @override
  String get id => 'modern';
  @override
  String get name => 'Modern';

  @override
  Future<pw.Document> build(ResumeData data, TemplateStyle style) async {
    final look = PdfLook.sans(style);
    final doc = pw.Document();
    doc.addPage(
      pw.MultiPage(
        maxPages: 16,
        pageTheme: pw.PageTheme(
          pageFormat: PdfPageFormat.a4,
          margin: pw.EdgeInsets.fromLTRB(28, look.margin, look.margin, look.margin),
          theme: pw.ThemeData.withFont(
            base: look.base,
            bold: look.bold,
            italic: look.italic,
          ),
          buildBackground: (_) => pw.FullPage(
            ignoreMargins: true,
            child: pw.Align(
              alignment: pw.Alignment.centerLeft,
              child: pw.Container(width: 14, color: look.accent),
            ),
          ),
        ),
        build: (_) => [
          pw.Text(data.personal.fullName, style: look.name),
          if (data.personal.title.isNotEmpty)
            pw.Text(data.personal.title, style: look.small),
          pw.SizedBox(height: 6),
          pw.Text(contactLine(data.personal), style: look.small),
          ...standardSections(data, look),
        ],
      ),
    );
    return doc;
  }
}

class MinimalTemplate implements ResumeTemplate {
  @override
  String get id => 'minimal';
  @override
  String get name => 'Minimal';

  @override
  Future<pw.Document> build(ResumeData data, TemplateStyle style) async {
    final look = PdfLook.sans(style);
    return multiPageDocument(
      data: data,
      look: look,
      build: (_) => [
        pw.SizedBox(height: 18),
        pw.Text(data.personal.fullName, style: look.name),
        pw.SizedBox(height: 8),
        pw.Text(contactLine(data.personal), style: look.small),
        pw.SizedBox(height: 18),
        ...standardSections(data, look),
      ],
    );
  }
}

class ExecutiveTemplate implements ResumeTemplate {
  @override
  String get id => 'executive';
  @override
  String get name => 'Executive';

  @override
  Future<pw.Document> build(ResumeData data, TemplateStyle style) async {
    final look = PdfLook.sans(style);
    final doc = pw.Document();
    doc.addPage(
      pw.MultiPage(
        maxPages: 16,
        pageTheme: pw.PageTheme(
          pageFormat: PdfPageFormat.a4,
          margin: pw.EdgeInsets.fromLTRB(look.margin, 0, look.margin, look.margin),
          theme: pw.ThemeData.withFont(
            base: look.base,
            bold: look.bold,
            italic: look.italic,
          ),
        ),
        header: (_) => pw.Container(
          color: look.accent,
          width: double.infinity,
          padding: pw.EdgeInsets.fromLTRB(0, 22, 0, 18),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                data.personal.fullName.toUpperCase(),
                style: look.name.copyWith(color: PdfColors.white),
              ),
              pw.Text(
                data.personal.title,
                style: look.body.copyWith(color: PdfColors.white),
              ),
            ],
          ),
        ),
        build: (_) => [
          pw.SizedBox(height: 16),
          pw.Text(contactLine(data.personal), style: look.small),
          ...standardSections(data, look),
        ],
      ),
    );
    return doc;
  }
}

class CreativeTemplate implements ResumeTemplate {
  @override
  String get id => 'creative';
  @override
  String get name => 'Creative';

  @override
  Future<pw.Document> build(ResumeData data, TemplateStyle style) async {
    final look = PdfLook.sans(style);
    return multiPageDocument(
      data: data,
      look: look,
      build: (_) => [
        pw.Container(
          color: look.accent,
          padding: const pw.EdgeInsets.all(16),
          child: pw.Row(
            children: [
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      data.personal.fullName,
                      style: look.name.copyWith(color: PdfColors.white),
                    ),
                    pw.Text(
                      data.personal.title,
                      style: look.body.copyWith(color: PdfColors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        pw.SizedBox(height: 10),
        pw.Text(contactLine(data.personal), style: look.small),
        ...standardSections(data, look),
      ],
    );
  }
}

class CompactTemplate implements ResumeTemplate {
  @override
  String get id => 'compact';
  @override
  String get name => 'Compact';

  @override
  Future<pw.Document> build(ResumeData data, TemplateStyle style) async {
    final look = PdfLook.sans(
      TemplateStyle(
        accentColor: style.accentColor,
        fontSize: (style.fontSize - 1).clamp(8, 12),
        margin: (style.margin - 8).clamp(20, 40),
      ),
    );
    return multiPageDocument(
      data: data,
      look: look,
      build: (_) => [
        pw.Text(data.personal.fullName, style: look.name.copyWith(fontSize: look.size + 6)),
        pw.Text(contactLine(data.personal), style: look.small),
        ...standardSections(data, look, compact: true),
      ],
    );
  }
}

class TechTemplate implements ResumeTemplate {
  @override
  String get id => 'tech';
  @override
  String get name => 'Tech';

  @override
  Future<pw.Document> build(ResumeData data, TemplateStyle style) async {
    final look = PdfLook.mono(style);
    final skillsFirst = ResumeData(
      personal: data.personal,
      summary: data.summary,
      experiences: data.experiences,
      educations: data.educations,
      skillGroups: data.skillGroups,
      courses: data.courses,
      projects: data.projects,
      languages: data.languages,
      awards: data.awards,
      customSections: data.customSections,
      settings: data.settings.copyWith(
        sectionOrder: [
          'skills',
          'projects',
          'experience',
          'education',
          'summary',
          'courses',
          'languages',
          'awards',
          'custom',
        ],
      ),
    );
    return multiPageDocument(
      data: skillsFirst,
      look: look,
      build: (_) => [
        pw.Text('> ${data.personal.fullName}', style: look.name),
        pw.Text(data.personal.title, style: look.small),
        pw.Text(contactLine(data.personal), style: look.small),
        ...standardSections(skillsFirst, look),
      ],
    );
  }
}

class TimelineTemplate implements ResumeTemplate {
  @override
  String get id => 'timeline';
  @override
  String get name => 'Timeline';

  @override
  Future<pw.Document> build(ResumeData data, TemplateStyle style) async {
    final look = PdfLook.sans(style);
    return multiPageDocument(
      data: data,
      look: look,
      build: (_) => [
        pw.Text(data.personal.fullName, style: look.name),
        pw.Text(contactLine(data.personal), style: look.small),
        for (final key in orderedKeys(data))
          if (key == 'experience')
            ...[
              sectionTitle('Experience', look),
              for (final item in data.experiences) ...[
                jobHeader(item, look),
                ...[
                  for (final bullet in bullets(item.bullets, look))
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 2),
                      child: bullet,
                    ),
                ],
                pw.SizedBox(height: 6),
              ],
            ]
          else
            ...sectionWidgets(data, look, key),
      ],
    );
  }
}

class ElegantTemplate implements ResumeTemplate {
  @override
  String get id => 'elegant';
  @override
  String get name => 'Elegant';

  @override
  Future<pw.Document> build(ResumeData data, TemplateStyle style) async {
    final look = PdfLook.serif(style);
    return multiPageDocument(
      data: data,
      look: look,
      build: (_) => [
        pw.Center(
          child: pw.Column(
            children: [
              pw.Text(data.personal.fullName, style: look.name),
              pw.SizedBox(height: 4),
              pw.Text(data.personal.title, style: look.small),
              pw.SizedBox(height: 6),
              pw.Container(height: 0.6, width: 120, color: look.accent),
              pw.SizedBox(height: 6),
              pw.Text(contactLine(data.personal), style: look.small, textAlign: pw.TextAlign.center),
            ],
          ),
        ),
        ...standardSections(data, look),
      ],
    );
  }
}
