import 'dart:convert';

import '../../../../core/constants/section_keys.dart';
import '../../../../core/utils/json_list.dart';
import '../../../templates/domain/resume_font.dart';

class ResumeSettings {
  const ResumeSettings({
    this.id = 1,
    this.templateId = 'classic',
    this.accentColor = 0xFF1D4ED8,
    this.fontFamily = 'inter',
    this.fontSize = 10,
    this.margin = 40,
    this.sectionOrder = SectionKeys.defaultOrder,
    this.sectionVisibility = const {},
    this.hasSeenOnboarding = false,
  });

  final int id;
  final String templateId;
  final int accentColor;
  final String fontFamily;
  final double fontSize;
  final double margin;
  final List<String> sectionOrder;
  final Map<String, bool> sectionVisibility;
  final bool hasSeenOnboarding;

  ResumeFont get resumeFont => ResumeFont.fromId(fontFamily);

  bool isSectionVisible(String key) => sectionVisibility[key] ?? true;

  SkillsPlacement get skillsPlacement {
    final order = sectionOrder.isEmpty
        ? SectionKeys.defaultOrder
        : sectionOrder;
    final skillsAt = order.indexOf(SectionKeys.skills);
    final experienceAt = order.indexOf(SectionKeys.experience);
    if (skillsAt < 0 || experienceAt < 0) {
      return SkillsPlacement.afterExperience;
    }
    return skillsAt < experienceAt
        ? SkillsPlacement.beforeExperience
        : SkillsPlacement.afterExperience;
  }

  ResumeSettings withSkillsPlacement(SkillsPlacement placement) {
    final order = sectionOrder.isEmpty
        ? SectionKeys.defaultOrder
        : sectionOrder;
    return copyWith(sectionOrder: applySkillsPlacement(order, placement));
  }

  ResumeSettings copyWith({
    int? id,
    String? templateId,
    int? accentColor,
    String? fontFamily,
    double? fontSize,
    double? margin,
    List<String>? sectionOrder,
    Map<String, bool>? sectionVisibility,
    bool? hasSeenOnboarding,
  }) {
    return ResumeSettings(
      id: id ?? this.id,
      templateId: templateId ?? this.templateId,
      accentColor: accentColor ?? this.accentColor,
      fontFamily: fontFamily ?? this.fontFamily,
      fontSize: fontSize ?? this.fontSize,
      margin: margin ?? this.margin,
      sectionOrder: sectionOrder ?? this.sectionOrder,
      sectionVisibility: sectionVisibility ?? this.sectionVisibility,
      hasSeenOnboarding: hasSeenOnboarding ?? this.hasSeenOnboarding,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'templateId': templateId,
    'accentColor': accentColor,
    'fontFamily': fontFamily,
    'fontSize': fontSize,
    'margin': margin,
    'sectionOrder': sectionOrder,
    'sectionVisibility': sectionVisibility,
    'hasSeenOnboarding': hasSeenOnboarding,
  };

  factory ResumeSettings.fromJson(Map<String, dynamic> json) {
    final visibilityRaw = json['sectionVisibility'];
    final visibility = <String, bool>{};
    if (visibilityRaw is Map) {
      visibilityRaw.forEach((key, value) {
        visibility['$key'] = value == true;
      });
    }

    var order = stringListFromJson(json['sectionOrder']);
    if (order.isEmpty) order = SectionKeys.defaultOrder;

    return ResumeSettings(
      id: readInt(json, 'id', 1),
      templateId: readString(json, 'templateId', 'classic'),
      accentColor: readInt(json, 'accentColor', 0xFF1D4ED8),
      fontFamily: ResumeFont.fromId(readString(json, 'fontFamily', 'inter')).id,
      fontSize: readDouble(json, 'fontSize', 10),
      margin: readDouble(json, 'margin', 40),
      sectionOrder: order,
      sectionVisibility: visibility,
      hasSeenOnboarding: readBool(json, 'hasSeenOnboarding'),
    );
  }

  static Map<String, bool> visibilityFromJson(String raw) {
    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map) {
        return {
          for (final entry in decoded.entries)
            '${entry.key}': entry.value == true,
        };
      }
    } catch (_) {}
    return {};
  }
}

class TemplateStyle {
  const TemplateStyle({
    required this.accentColor,
    this.fontFamily = 'inter',
    this.fontSize = 10,
    this.margin = 40,
    this.fitScale = 1,
  });

  final int accentColor;
  final String fontFamily;
  final double fontSize;
  final double margin;
  final double fitScale;

  ResumeFont get resumeFont => ResumeFont.fromId(fontFamily);

  factory TemplateStyle.fromSettings(ResumeSettings settings) {
    return TemplateStyle(
      accentColor: settings.accentColor,
      fontFamily: settings.fontFamily,
      fontSize: settings.fontSize,
      margin: settings.margin,
    );
  }

  TemplateStyle copyWith({
    int? accentColor,
    String? fontFamily,
    double? fontSize,
    double? margin,
    double? fitScale,
  }) {
    return TemplateStyle(
      accentColor: accentColor ?? this.accentColor,
      fontFamily: fontFamily ?? this.fontFamily,
      fontSize: fontSize ?? this.fontSize,
      margin: margin ?? this.margin,
      fitScale: fitScale ?? this.fitScale,
    );
  }
}
