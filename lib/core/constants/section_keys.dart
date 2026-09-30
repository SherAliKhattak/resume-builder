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
