import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../core/constants/section_keys.dart';
import '../../export/domain/models/resume_settings.dart';
import '../../profile/domain/models/profile_models.dart';
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
    final look = await PdfLook.fromStyle(style);
    return multiPageDocument(
      look: look,
      build: (_) => [
        identityHeader(data, look),
        pw.SizedBox(height: 6),
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
    final look = await PdfLook.fromStyle(
      TemplateStyle(
        accentColor: 0xFF1A1A1A,
        fontFamily: style.fontFamily,
        fontSize: style.fontSize,
        margin: style.margin,
      ),
    );
    return multiPageDocument(
      look: look,
      build: (_) => [
        pw.Text(data.personal.fullName, style: look.name),
        if (data.personal.title.isNotEmpty) ...[
          pw.SizedBox(height: 3),
          pw.Text(data.personal.title, style: look.bodyBold),
        ],
        pw.SizedBox(height: 5),
        contactLineWidget(data.personal, look),
        pw.SizedBox(height: 8),
        pw.Container(height: 0.6, color: look.ink),
        ...standardSections(data, look, rule: SectionRule.line),
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
    final look = await PdfLook.fromStyle(style);
    return multiPageDocument(
      look: look,
      margin: pw.EdgeInsets.fromLTRB(32, look.margin, look.margin, look.margin),
      background: (_) => pw.FullPage(
        ignoreMargins: true,
        child: pw.Align(
          alignment: pw.Alignment.centerLeft,
          child: pw.Container(width: 10, color: look.accent),
        ),
      ),
      build: (_) => [
        identityHeader(data, look, showRule: false),
        pw.SizedBox(height: 4),
        ...standardSections(data, look, rule: SectionRule.bar),
      ],
    );
  }
}

class MinimalTemplate implements ResumeTemplate {
  @override
  String get id => 'minimal';
  @override
  String get name => 'Minimal';

  @override
  Future<pw.Document> build(ResumeData data, TemplateStyle style) async {
    final look = await PdfLook.fromStyle(
      TemplateStyle(
        accentColor: 0xFF1A1A1A,
        fontFamily: style.fontFamily,
        fontSize: style.fontSize,
        margin: style.margin + 6,
      ),
    );
    return multiPageDocument(
      look: look,
      build: (_) => [
        pw.SizedBox(height: 10),
        identityHeader(data, look, showRule: false),
        pw.SizedBox(height: 14),
        pw.Container(height: 0.5, color: look.hairline),
        ...standardSections(data, look, rule: SectionRule.none),
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
    final look = await PdfLook.fromStyle(style);
    return multiPageDocument(
      look: look,
      margin: pw.EdgeInsets.fromLTRB(look.margin, 0, look.margin, look.margin),
      header: (_) => pw.Container(
        width: double.infinity,
        color: look.accent,
        padding: const pw.EdgeInsets.fromLTRB(0, 26, 0, 20),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              data.personal.fullName.toUpperCase(),
              style: look.name.copyWith(
                color: PdfColors.white,
                fontSize: look.size + 10,
                letterSpacing: 1.6,
              ),
            ),
            if (data.personal.title.isNotEmpty) ...[
              pw.SizedBox(height: 4),
              pw.Text(
                data.personal.title,
                style: look.body.copyWith(color: PdfColors.white),
              ),
            ],
            if (contactLine(data.personal).isNotEmpty) ...[
              pw.SizedBox(height: 8),
              contactLineWidget(data.personal, look, color: PdfColors.white),
            ],
          ],
        ),
      ),
      build: (_) => [pw.SizedBox(height: 16), ...standardSections(data, look)],
    );
  }
}

class CreativeTemplate implements ResumeTemplate {
  @override
  String get id => 'creative';
  @override
  String get name => 'Creative';

  @override
  Future<pw.Document> build(ResumeData data, TemplateStyle style) async {
    final look = await PdfLook.fromStyle(style);
    return multiPageDocument(
      look: look,
      build: (_) => [
        pw.Container(
          width: double.infinity,
          color: look.accent,
          padding: const pw.EdgeInsets.fromLTRB(18, 18, 18, 16),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                data.personal.fullName,
                style: look.name.copyWith(color: PdfColors.white),
              ),
              if (data.personal.title.isNotEmpty) ...[
                pw.SizedBox(height: 3),
                pw.Text(
                  data.personal.title,
                  style: look.body.copyWith(color: PdfColors.white),
                ),
              ],
              if (contactLine(data.personal).isNotEmpty) ...[
                pw.SizedBox(height: 8),
                contactLineWidget(data.personal, look, color: PdfColors.white),
              ],
            ],
          ),
        ),
        pw.SizedBox(height: 8),
        ...standardSections(data, look, rule: SectionRule.bar),
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
    final look = await PdfLook.fromStyle(
      TemplateStyle(
        accentColor: style.accentColor,
        fontFamily: style.fontFamily,
        fontSize: (style.fontSize - 0.6).clamp(8, 12),
        margin: (style.margin - 6).clamp(22, 40),
      ),
    );
    return multiPageDocument(
      look: look,
      build: (_) => [
        identityHeader(data, look),
        pw.SizedBox(height: 4),
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
    final look = await PdfLook.fromStyle(style);
    const techOrder = [
      SectionKeys.summary,
      SectionKeys.skills,
      SectionKeys.projects,
      SectionKeys.experience,
      SectionKeys.education,
      SectionKeys.courses,
      SectionKeys.languages,
      SectionKeys.awards,
      SectionKeys.custom,
    ];
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
        sectionOrder: applySkillsPlacement(
          techOrder,
          data.settings.skillsPlacement,
        ),
      ),
    );
    return multiPageDocument(
      look: look,
      build: (_) => [
        pw.Container(
          width: double.infinity,
          padding: const pw.EdgeInsets.only(bottom: 10),
          decoration: pw.BoxDecoration(
            border: pw.Border(
              bottom: pw.BorderSide(color: look.accent, width: 1.4),
            ),
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(data.personal.fullName, style: look.name),
              if (data.personal.title.isNotEmpty) ...[
                pw.SizedBox(height: 3),
                pw.Text(data.personal.title, style: look.title),
              ],
              pw.SizedBox(height: 6),
              contactLineWidget(data.personal, look),
            ],
          ),
        ),
        ...standardSections(skillsFirst, look, rule: SectionRule.bar),
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
    final look = await PdfLook.fromStyle(style);
    return multiPageDocument(
      look: look,
      build: (_) => [
        identityHeader(data, look),
        pw.SizedBox(height: 6),
        for (final key in orderedKeys(data))
          if (key == SectionKeys.experience) ...[
            pw.NewPage(freeSpace: sectionLeadRoom(look)),
            if (data.experiences.isEmpty)
              sectionTitle('Experience', look)
            else ...[
              keepTogether([
                sectionTitle('Experience', look),
                _timelineJob(data.experiences.first, look),
              ]),
              for (final item in data.experiences.skip(1))
                _timelineJob(item, look),
            ],
          ] else
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
    final look = await PdfLook.fromStyle(style);
    return multiPageDocument(
      look: look,
      build: (_) => [
        pw.Center(
          child: pw.Column(
            children: [
              pw.Text(
                data.personal.fullName,
                style: look.name.copyWith(letterSpacing: 1.1),
              ),
              if (data.personal.title.isNotEmpty) ...[
                pw.SizedBox(height: 4),
                pw.Text(
                  data.personal.title,
                  style: look.bodyItalic.copyWith(color: look.accent),
                ),
              ],
              pw.SizedBox(height: 8),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Container(width: 36, height: 0.6, color: look.accent),
                  pw.SizedBox(width: 8),
                  pw.Container(
                    width: 5,
                    height: 5,
                    decoration: pw.BoxDecoration(
                      color: look.accent,
                      shape: pw.BoxShape.circle,
                    ),
                  ),
                  pw.SizedBox(width: 8),
                  pw.Container(width: 36, height: 0.6, color: look.accent),
                ],
              ),
              pw.SizedBox(height: 8),
              contactLineWidget(data.personal, look, centered: true),
            ],
          ),
        ),
        pw.SizedBox(height: 8),
        ...standardSections(data, look),
      ],
    );
  }
}

pw.Widget _timelineJob(Experience item, PdfLook look) {
  return pw.Padding(
    padding: const pw.EdgeInsets.only(bottom: 8),
    child: pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(
          width: 78,
          child: pw.Text(
            dateRange(item.startDate, item.endDate, current: item.isCurrent),
            style: look.small,
          ),
        ),
        pw.Container(
          width: 8,
          margin: const pw.EdgeInsets.only(right: 10, top: 3),
          child: pw.Column(
            children: [
              pw.Container(
                width: 7,
                height: 7,
                decoration: pw.BoxDecoration(
                  color: look.accent,
                  shape: pw.BoxShape.circle,
                ),
              ),
              pw.Container(width: 1.1, height: 28, color: look.accent),
            ],
          ),
        ),
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                item.role.trim().isNotEmpty ? item.role : item.company,
                style: look.bodyBold,
              ),
              if (item.role.trim().isNotEmpty && item.company.trim().isNotEmpty)
                pw.Text(item.company, style: look.bodyItalic),
              ...bullets(item.bullets, look),
            ],
          ),
        ),
      ],
    ),
  );
}
