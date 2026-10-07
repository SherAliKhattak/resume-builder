enum SkillsPlacement { beforeExperience, afterExperience }

List<String> applySkillsPlacement(
  List<String> order,
  SkillsPlacement placement,
) {
  if (!order.contains(SectionKeys.skills) ||
      !order.contains(SectionKeys.experience)) {
    return List<String>.from(order);
  }
  final next = [
    for (final key in order)
      if (key != SectionKeys.skills) key,
  ];
  final experienceAt = next.indexOf(SectionKeys.experience);
  final insertAt = placement == SkillsPlacement.beforeExperience
      ? experienceAt
      : experienceAt + 1;
  next.insert(insertAt, SectionKeys.skills);
  return next;
}

class SectionKeys {
  static const personal = 'personal';
  static const summary = 'summary';
  static const experience = 'experience';
  static const education = 'education';
  static const skills = 'skills';
  static const courses = 'courses';
  static const projects = 'projects';
  static const languages = 'languages';
  static const awards = 'awards';
  static const custom = 'custom';

  static const defaultOrder = [
    personal,
    summary,
    experience,
    education,
    skills,
    courses,
    projects,
    languages,
    awards,
    custom,
  ];

  static const labels = {
    personal: 'Personal info',
    summary: 'Summary',
    experience: 'Work experience',
    education: 'Education',
    skills: 'Skills',
    courses: 'Courses and certifications',
    projects: 'Projects',
    languages: 'Languages',
    awards: 'Awards',
    custom: 'Custom sections',
  };

  static String label(String key) => labels[key] ?? key;
}
