import '../../../export/domain/models/resume_settings.dart';
import '../../../job_description/domain/models/job_description.dart';
import 'profile_models.dart';

class ResumeData {
  const ResumeData({
    this.personal = const PersonalInfo(),
    this.summary = '',
    this.experiences = const [],
    this.educations = const [],
    this.skillGroups = const [],
    this.courses = const [],
    this.projects = const [],
    this.languages = const [],
    this.awards = const [],
    this.customSections = const [],
    this.jobDescription = const JobDescription(),
    this.settings = const ResumeSettings(),
  });

  final PersonalInfo personal;
  final String summary;
  final List<Experience> experiences;
  final List<Education> educations;
  final List<SkillGroup> skillGroups;
  final List<Course> courses;
  final List<Project> projects;
  final List<Language> languages;
  final List<Award> awards;
  final List<CustomSection> customSections;
  final JobDescription jobDescription;
  final ResumeSettings settings;

  bool get hasStarted => personal.fullName.trim().isNotEmpty;

  String get allText {
    final buffer = StringBuffer()
      ..writeln(personal.fullName)
      ..writeln(personal.title)
      ..writeln(summary);
    for (final group in skillGroups) {
      buffer.writeln(group.name);
      for (final skill in group.skills) {
        buffer.writeln(skill.name);
      }
    }
    for (final item in experiences) {
      buffer
        ..writeln(item.company)
        ..writeln(item.role)
        ..writeln(item.bullets.join(' '));
    }
    for (final item in projects) {
      buffer
        ..writeln(item.name)
        ..writeln(item.description)
        ..writeln(item.techStack)
        ..writeln(item.bullets.join(' '));
    }
    for (final item in courses) {
      buffer.writeln(item.name);
    }
    for (final item in educations) {
      buffer
        ..writeln(item.school)
        ..writeln(item.degree)
        ..writeln(item.field);
    }
    for (final item in languages) {
      buffer.writeln(item.name);
    }
    for (final item in awards) {
      buffer.writeln(item.title);
    }
    for (final item in customSections) {
      buffer
        ..writeln(item.title)
        ..writeln(item.body);
    }
    return buffer.toString();
  }

  ResumeData copyWith({
    PersonalInfo? personal,
    String? summary,
    List<Experience>? experiences,
    List<Education>? educations,
    List<SkillGroup>? skillGroups,
    List<Course>? courses,
    List<Project>? projects,
    List<Language>? languages,
    List<Award>? awards,
    List<CustomSection>? customSections,
    JobDescription? jobDescription,
    ResumeSettings? settings,
  }) {
    return ResumeData(
      personal: personal ?? this.personal,
      summary: summary ?? this.summary,
      experiences: experiences ?? this.experiences,
      educations: educations ?? this.educations,
      skillGroups: skillGroups ?? this.skillGroups,
      courses: courses ?? this.courses,
      projects: projects ?? this.projects,
      languages: languages ?? this.languages,
      awards: awards ?? this.awards,
      customSections: customSections ?? this.customSections,
      jobDescription: jobDescription ?? this.jobDescription,
      settings: settings ?? this.settings,
    );
  }

  Map<String, dynamic> toJson() => {
    'personal': personal.toJson(),
    'summary': summary,
    'experiences': experiences.map((e) => e.toJson()).toList(),
    'educations': educations.map((e) => e.toJson()).toList(),
    'skillGroups': skillGroups.map((e) => e.toJson()).toList(),
    'courses': courses.map((e) => e.toJson()).toList(),
    'projects': projects.map((e) => e.toJson()).toList(),
    'languages': languages.map((e) => e.toJson()).toList(),
    'awards': awards.map((e) => e.toJson()).toList(),
    'customSections': customSections.map((e) => e.toJson()).toList(),
    'jobDescription': jobDescription.toJson(),
    'settings': settings.toJson(),
  };

  factory ResumeData.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> asMap(dynamic value) {
      if (value is Map<String, dynamic>) return value;
      if (value is Map) return value.cast<String, dynamic>();
      return {};
    }

    List<Map<String, dynamic>> asMaps(dynamic value) {
      if (value is! List) return const [];
      return [
        for (final item in value)
          if (item is Map) asMap(item),
      ];
    }

    return ResumeData(
      personal: PersonalInfo.fromJson(asMap(json['personal'])),
      summary: json['summary']?.toString() ?? '',
      experiences: [
        for (final item in asMaps(json['experiences']))
          Experience.fromJson(item),
      ],
      educations: [
        for (final item in asMaps(json['educations'])) Education.fromJson(item),
      ],
      skillGroups: [
        for (final item in asMaps(json['skillGroups']))
          SkillGroup.fromJson(item),
      ],
      courses: [
        for (final item in asMaps(json['courses'])) Course.fromJson(item),
      ],
      projects: [
        for (final item in asMaps(json['projects'])) Project.fromJson(item),
      ],
      languages: [
        for (final item in asMaps(json['languages'])) Language.fromJson(item),
      ],
      awards: [
        for (final item in asMaps(json['awards'])) Award.fromJson(item),
      ],
      customSections: [
        for (final item in asMaps(json['customSections']))
          CustomSection.fromJson(item),
      ],
      jobDescription: JobDescription.fromJson(asMap(json['jobDescription'])),
      settings: ResumeSettings.fromJson(asMap(json['settings'])),
    );
  }
}
