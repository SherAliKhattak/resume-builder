import 'dart:math' as math;

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../core/constants/section_keys.dart';
import '../../export/domain/models/resume_settings.dart';
import '../domain/resume_font.dart';
import '../../profile/domain/models/profile_models.dart';
import '../../profile/domain/models/resume_data.dart';
import 'resume_links.dart';

PdfColor pdfAccent(int color) => PdfColor.fromInt(color);

const _ink = PdfColor.fromInt(0xFF111111);
const _muted = PdfColor.fromInt(0xFF3C4043);
const _rule = PdfColor.fromInt(0xFFD8D8D8);

String dateRange(String start, String end, {bool current = false}) {
  final right = current ? 'Present' : end;
  if (start.isEmpty) return right;
  if (right.isEmpty) return start;
  return '$start - $right';
}

enum SectionRule { line, none, bar }

const _additionalKey = 'additional';
const _mergeableKeys = {
  SectionKeys.courses,
  SectionKeys.languages,
  SectionKeys.awards,
};

class PdfLook {
  PdfLook._({
    required this.style,
    required this.base,
    required this.bold,
    required this.italic,
    required this.accentFace,
  });

  static Future<PdfLook> fromStyle(TemplateStyle style) {
    return switch (style.resumeFont) {
      ResumeFont.libreBaskerville => serif(style),
      ResumeFont.sourceCodePro => mono(style),
      ResumeFont.inter => sans(style),
    };
  }

  static Future<PdfLook> sans(TemplateStyle style) async {
    return PdfLook._(
      style: style,
      base: await PdfGoogleFonts.interRegular(),
      bold: await PdfGoogleFonts.interBold(),
      italic: await PdfGoogleFonts.interItalic(),
      accentFace: await PdfGoogleFonts.interBold(),
    );
  }

  static Future<PdfLook> serif(TemplateStyle style) async {
    return PdfLook._(
      style: style,
      base: await PdfGoogleFonts.libreBaskervilleRegular(),
      bold: await PdfGoogleFonts.libreBaskervilleBold(),
      italic: await PdfGoogleFonts.libreBaskervilleItalic(),
      accentFace: await PdfGoogleFonts.libreBaskervilleBold(),
    );
  }

  static Future<PdfLook> mono(TemplateStyle style) async {
    return PdfLook._(
      style: style,
      base: await PdfGoogleFonts.sourceCodeProRegular(),
      bold: await PdfGoogleFonts.sourceCodeProBold(),
      italic: await PdfGoogleFonts.sourceCodeProItalic(),
      accentFace: await PdfGoogleFonts.sourceCodeProBold(),
    );
  }

  final TemplateStyle style;
  final pw.Font base;
  final pw.Font bold;
  final pw.Font italic;
  final pw.Font accentFace;

  PdfColor get accent => pdfAccent(style.accentColor);
  PdfColor get ink => _ink;
  PdfColor get muted => _muted;
  PdfColor get hairline => _rule;
  double get size => style.fontSize;
  double get margin => style.margin;
  double get fitScale => style.fitScale;

  double space(double value) => value * fitScale;

  pw.TextStyle get body => pw.TextStyle(
    font: base,
    fontSize: size,
    lineSpacing: space(2.4),
    color: _ink,
  );
  pw.TextStyle get bodyBold => pw.TextStyle(
    font: bold,
    fontSize: size,
    lineSpacing: space(2.2),
    color: _ink,
  );
  pw.TextStyle get bodyItalic => pw.TextStyle(
    font: italic,
    fontSize: size,
    lineSpacing: space(2.2),
    color: _ink,
  );
  pw.TextStyle get small => pw.TextStyle(
    font: base,
    fontSize: size - 0.8,
    lineSpacing: space(1.8),
    color: _muted,
  );
  pw.TextStyle get name => pw.TextStyle(
    font: bold,
    fontSize: size + 11,
    lineSpacing: 1,
    letterSpacing: 0.3,
    color: _ink,
  );
  pw.TextStyle get title => pw.TextStyle(
    font: bold,
    fontSize: size + 1.4,
    letterSpacing: 0.2,
    color: _ink,
  );
  pw.TextStyle get heading => pw.TextStyle(
    font: bold,
    fontSize: size + 2.2,
    letterSpacing: 0.8,
    color: _ink,
  );
}

List<pw.Widget> bullets(List<String> items, PdfLook look) {
  if (items.isEmpty) return const [];
  return [
    for (final item in items)
      pw.Padding(
        padding: pw.EdgeInsets.only(bottom: look.space(2.2), left: 1),
        child: pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Container(
              width: 2.8,
              height: 2.8,
              margin: pw.EdgeInsets.only(top: look.space(3.8), right: 8),
              decoration: const pw.BoxDecoration(
                color: _ink,
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

pw.Widget sectionTitle(
  String title,
  PdfLook look, {
  SectionRule rule = SectionRule.line,
}) {
  return pw.Padding(
    padding: pw.EdgeInsets.only(top: look.space(12), bottom: look.space(6)),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        if (rule == SectionRule.bar)
          pw.Row(
            children: [
              pw.Container(
                width: 3,
                height: look.size + 6,
                color: look.accent,
                margin: const pw.EdgeInsets.only(right: 8),
              ),
              pw.Text(title.toUpperCase(), style: look.heading),
            ],
          )
        else
          pw.Text(title.toUpperCase(), style: look.heading),
        if (rule == SectionRule.line)
          pw.Container(
            margin: pw.EdgeInsets.only(top: look.space(3)),
            height: 0.7,
            color: look.accent,
          ),
      ],
    ),
  );
}

pw.Widget entryHeader({
  required String title,
  required PdfLook look,
  String subtitle = '',
  String dates = '',
}) {
  return pw.Padding(
    padding: pw.EdgeInsets.only(top: look.space(5), bottom: look.space(2)),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(child: pw.Text(title, style: look.bodyBold)),
            if (dates.isNotEmpty)
              pw.Padding(
                padding: const pw.EdgeInsets.only(left: 10),
                child: pw.Text(dates, style: look.small),
              ),
          ],
        ),
        if (subtitle.isNotEmpty)
          pw.Padding(
            padding: const pw.EdgeInsets.only(top: 1),
            child: pw.Text(subtitle, style: look.bodyItalic),
          ),
      ],
    ),
  );
}

pw.Widget jobHeader(Experience item, PdfLook look) {
  return entryHeader(
    title: item.role.trim().isNotEmpty ? item.role.trim() : item.company.trim(),
    subtitle: item.role.trim().isNotEmpty ? item.company.trim() : '',
    dates: dateRange(item.startDate, item.endDate, current: item.isCurrent),
    look: look,
  );
}

String contactLine(PersonalInfo info) {
  return [
    info.email,
    info.phone,
    info.location,
    if (info.linkedin.trim().isNotEmpty) displayUrl(info.linkedin),
    if (info.github.trim().isNotEmpty) displayUrl(info.github),
    if (info.portfolio.trim().isNotEmpty) displayUrl(info.portfolio),
  ].where((part) => part.trim().isNotEmpty).join('  ·  ');
}

pw.Widget _contactPart(String text, pw.TextStyle style, {String? href}) {
  final label = pw.Text(text, style: style);
  if (href == null) return label;
  return pw.UrlLink(destination: href, child: label);
}

pw.Widget contactLineWidget(
  PersonalInfo info,
  PdfLook look, {
  bool centered = false,
  PdfColor? color,
}) {
  final style = color == null ? look.small : look.small.copyWith(color: color);
  final parts = <pw.Widget>[];
  void addText(String value) {
    if (value.trim().isEmpty) return;
    if (parts.isNotEmpty) parts.add(pw.Text('  ·  ', style: style));
    parts.add(_contactPart(value, style));
  }

  void addLink(String value) {
    if (value.trim().isEmpty) return;
    if (parts.isNotEmpty) parts.add(pw.Text('  ·  ', style: style));
    parts.add(_contactPart(displayUrl(value), style, href: hrefUrl(value)));
  }

  addText(info.email);
  addText(info.phone);
  addText(info.location);
  addLink(info.linkedin);
  addLink(info.github);
  addLink(info.portfolio);
  if (parts.isEmpty) return pw.SizedBox();
  return pw.Wrap(
    alignment: centered ? pw.WrapAlignment.center : pw.WrapAlignment.start,
    children: parts,
  );
}

pw.Widget keepTogether(List<pw.Widget> children) {
  return pw.Container(
    width: double.infinity,
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: children,
    ),
  );
}

double sectionLeadRoom(PdfLook look) {
  return look.space(12 + 6 + 4) + look.size + 2.2 + look.size * 2.8;
}

List<pw.Widget> leadSection(
  PdfLook look,
  pw.Widget title,
  List<pw.Widget> body,
) {
  if (body.isEmpty) {
    return [pw.NewPage(freeSpace: sectionLeadRoom(look)), title];
  }
  return [
    pw.NewPage(freeSpace: sectionLeadRoom(look)),
    keepTogether([title, body.first]),
    ...body.skip(1),
  ];
}

pw.Widget identityHeader(
  ResumeData data,
  PdfLook look, {
  bool centered = false,
  bool showTitle = true,
  bool showRule = true,
}) {
  final name = pw.Text(data.personal.fullName, style: look.name);
  final title = data.personal.title.trim().isEmpty || !showTitle
      ? null
      : pw.Text(data.personal.title, style: look.title);
  final contact = contactLine(data.personal);
  final children = <pw.Widget>[
    name,
    if (title != null) ...[pw.SizedBox(height: look.space(3)), title],
    if (contact.isNotEmpty) ...[
      pw.SizedBox(height: look.space(6)),
      contactLineWidget(data.personal, look, centered: centered),
    ],
    if (showRule) ...[
      pw.SizedBox(height: look.space(10)),
      pw.Container(height: 0.8, color: look.accent),
    ],
  ];
  if (centered) {
    return pw.Column(
      children: [
        for (final child in children)
          child is pw.SizedBox || child is pw.Container
              ? child
              : pw.Center(child: child),
      ],
    );
  }
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: children,
  );
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
    case _additionalKey:
      return true;
    default:
      return false;
  }
}

int _itemCount(ResumeData data, String key) {
  switch (key) {
    case SectionKeys.courses:
      return data.courses.length;
    case SectionKeys.languages:
      return data.languages.length;
    case SectionKeys.awards:
      return data.awards.length;
    default:
      return 0;
  }
}

bool shouldMergeAdditional(ResumeData data, [List<String>? visibleKeys]) {
  final keys =
      visibleKeys ??
      [
        for (final key in _mergeableKeys)
          if (data.settings.isSectionVisible(key) && hasContent(data, key)) key,
      ];
  final present = [
    for (final key in keys)
      if (_mergeableKeys.contains(key)) key,
  ];
  if (present.length < 2) return false;
  return present.every((key) {
    final count = _itemCount(data, key);
    return count >= 1 && count <= 2;
  });
}

List<String> mergeAdditionalKeys(List<String> keys) {
  final first = keys.indexWhere(_mergeableKeys.contains);
  if (first < 0) return keys;
  final next = [
    for (final key in keys)
      if (!_mergeableKeys.contains(key)) key,
  ];
  final insertAt = first > next.length ? next.length : first;
  next.insert(insertAt, _additionalKey);
  return next;
}

List<String> orderedKeys(ResumeData data) {
  final order = data.settings.sectionOrder.isEmpty
      ? SectionKeys.defaultOrder
      : data.settings.sectionOrder;
  var keys = [
    for (final key in order)
      if (key != SectionKeys.personal &&
          data.settings.isSectionVisible(key) &&
          hasContent(data, key))
        key,
  ];
  keys = applySkillsPlacement(keys, data.settings.skillsPlacement);
  if (shouldMergeAdditional(data, keys)) {
    keys = mergeAdditionalKeys(keys);
  }
  return keys;
}

List<pw.Widget> standardSections(
  ResumeData data,
  PdfLook look, {
  bool compact = false,
  SectionRule rule = SectionRule.line,
}) {
  final gap = look.space(compact ? 2.0 : 4.0);
  final widgets = <pw.Widget>[];
  for (final key in orderedKeys(data)) {
    widgets.addAll(
      sectionWidgets(data, look, key, compact: compact, rule: rule),
    );
    widgets.add(pw.SizedBox(height: gap));
  }
  return widgets;
}

List<pw.Widget> sectionWidgets(
  ResumeData data,
  PdfLook look,
  String key, {
  bool compact = false,
  SectionRule rule = SectionRule.line,
}) {
  switch (key) {
    case SectionKeys.summary:
      return [
        pw.NewPage(freeSpace: sectionLeadRoom(look)),
        sectionTitle('Summary', look, rule: rule),
        pw.Text(data.summary, style: look.body),
      ];
    case SectionKeys.experience:
      return leadSection(look, sectionTitle('Experience', look, rule: rule), [
        for (final item in data.experiences) ...[
          jobHeader(item, look),
          ...bullets(item.bullets, look),
          pw.SizedBox(height: look.space(compact ? 3 : 7)),
        ],
      ]);
    case SectionKeys.education:
      return leadSection(look, sectionTitle('Education', look, rule: rule), [
        for (final item in data.educations) ...[
          entryHeader(
            title: item.school.trim().isEmpty
                ? [
                    item.degree,
                    item.field,
                  ].where((part) => part.isNotEmpty).join(', ')
                : item.school,
            subtitle: item.school.trim().isNotEmpty
                ? [
                    item.degree,
                    item.field,
                  ].where((part) => part.isNotEmpty).join(', ')
                : '',
            dates: dateRange(item.startDate, item.endDate),
            look: look,
          ),
          if (item.details.isNotEmpty)
            pw.Padding(
              padding: pw.EdgeInsets.only(bottom: look.space(2)),
              child: pw.Text(item.details, style: look.body),
            ),
          pw.SizedBox(height: look.space(4)),
        ],
      ]);
    case SectionKeys.skills:
      return leadSection(look, sectionTitle('Skills', look, rule: rule), [
        for (final group in data.skillGroups)
          if (group.skills.isNotEmpty)
            pw.Padding(
              padding: pw.EdgeInsets.only(bottom: look.space(3)),
              child: pw.RichText(
                text: pw.TextSpan(
                  children: [
                    if (group.name.isNotEmpty)
                      pw.TextSpan(
                        text: '${group.name}  ',
                        style: look.bodyBold,
                      ),
                    pw.TextSpan(
                      text: group.skills.map((s) => s.name).join('  ·  '),
                      style: look.body,
                    ),
                  ],
                ),
              ),
            ),
      ]);
    case SectionKeys.courses:
      return leadSection(
        look,
        sectionTitle('Courses and certifications', look, rule: rule),
        bullets([
          for (final item in data.courses)
            [
              item.name,
              item.issuer,
              item.date,
            ].where((part) => part.isNotEmpty).join('  ·  '),
        ], look),
      );
    case SectionKeys.projects:
      return leadSection(look, sectionTitle('Projects', look, rule: rule), [
        for (final item in data.projects) ...projectEntry(item, look),
      ]);
    case SectionKeys.languages:
      return leadSection(look, sectionTitle('Languages', look, rule: rule), [
        pw.Text(_languageLine(data), style: look.body),
      ]);
    case SectionKeys.awards:
      return leadSection(
        look,
        sectionTitle('Key achievements', look, rule: rule),
        bullets(_awardLines(data), look),
      );
    case _additionalKey:
      return leadSection(look, sectionTitle('Additional', look, rule: rule), [
        ..._additionalLines(data, look),
      ]);
    case SectionKeys.custom:
      return [
        for (final item in data.customSections)
          if (item.isVisible && item.title.isNotEmpty) ...[
            pw.NewPage(freeSpace: sectionLeadRoom(look)),
            sectionTitle(item.title, look, rule: rule),
            pw.Text(item.body, style: look.body),
          ],
      ];
    default:
      return const [];
  }
}

List<pw.Widget> projectEntry(Project item, PdfLook look) {
  final showLink = !projectLinkAlreadyShown(
    name: item.name,
    link: item.link,
    description: item.description,
    bullets: item.bullets,
  );
  return [
    entryHeader(title: item.name, look: look),
    if (showLink)
      pw.Padding(
        padding: pw.EdgeInsets.only(top: look.space(1)),
        child: pw.UrlLink(
          destination: hrefUrl(item.link),
          child: pw.Text(displayUrl(item.link), style: look.bodyItalic),
        ),
      ),
    if (item.description.isNotEmpty)
      pw.Text(item.description, style: look.body),
    if (item.techStack.isNotEmpty)
      pw.Text('Stack: ${item.techStack}', style: look.bodyItalic),
    ...bullets(item.bullets, look),
    pw.SizedBox(height: look.space(6)),
  ];
}

String _languageLine(ResumeData data) {
  return [
    for (final item in data.languages)
      [
        item.name,
        item.proficiency,
      ].where((part) => part.isNotEmpty).join(' - '),
  ].join('  ·  ');
}

List<String> _awardLines(ResumeData data) {
  return [
    for (final item in data.awards)
      [
        item.title,
        item.issuer,
        item.date,
      ].where((part) => part.isNotEmpty).join('  ·  '),
  ];
}

List<pw.Widget> _additionalLines(ResumeData data, PdfLook look) {
  final lines = <pw.Widget>[];
  void addGroup(String label, String body) {
    if (body.trim().isEmpty) return;
    lines.add(
      pw.Padding(
        padding: pw.EdgeInsets.only(bottom: look.space(3)),
        child: pw.RichText(
          text: pw.TextSpan(
            children: [
              pw.TextSpan(text: '$label  ', style: look.bodyBold),
              pw.TextSpan(text: body, style: look.body),
            ],
          ),
        ),
      ),
    );
  }

  if (data.settings.isSectionVisible(SectionKeys.courses) &&
      data.courses.isNotEmpty) {
    addGroup(
      'Courses',
      [
        for (final item in data.courses)
          [
            item.name,
            item.issuer,
            item.date,
          ].where((part) => part.isNotEmpty).join(' · '),
      ].join('  ·  '),
    );
  }
  if (data.settings.isSectionVisible(SectionKeys.languages) &&
      data.languages.isNotEmpty) {
    addGroup('Languages', _languageLine(data));
  }
  if (data.settings.isSectionVisible(SectionKeys.awards) &&
      data.awards.isNotEmpty) {
    addGroup('Achievements', _awardLines(data).join('  ·  '));
  }
  return lines;
}

pw.ThemeData lookTheme(PdfLook look) {
  return pw.ThemeData.withFont(
    base: look.base,
    bold: look.bold,
    italic: look.italic,
  );
}

Future<pw.Document> fitToOnePage({
  required Future<pw.Document> Function(TemplateStyle style) build,
  required TemplateStyle style,
  double minFontSize = 9,
  double step = 0.5,
}) async {
  final floor = math.min(style.fontSize, minFontSize);
  var size = style.fontSize;
  while (true) {
    final scale = style.fontSize <= 0 ? 1.0 : size / style.fontSize;
    final doc = await build(style.copyWith(fontSize: size, fitScale: scale));
    final pages = doc.document.pdfPageList.pages.length;
    if (pages <= 1 || size <= floor) return doc;
    size = math.max(floor, size - step);
  }
}

pw.Document multiPageDocument({
  required PdfLook look,
  required List<pw.Widget> Function(pw.Context context) build,
  PdfPageFormat? format,
  pw.EdgeInsets? margin,
  pw.Widget Function(pw.Context context)? header,
  pw.Widget Function(pw.Context context)? background,
}) {
  final doc = pw.Document();
  doc.addPage(
    pw.MultiPage(
      maxPages: 16,
      pageTheme: pw.PageTheme(
        pageFormat: format ?? PdfPageFormat.a4,
        margin: margin ?? pw.EdgeInsets.all(look.margin),
        theme: lookTheme(look),
        buildBackground: background,
      ),
      header: header,
      build: build,
    ),
  );
  return doc;
}
