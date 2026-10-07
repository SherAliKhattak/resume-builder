import '../features/profile/domain/models/profile_models.dart';
import '../features/profile/domain/models/resume_data.dart';

class SampleResume {
  static const data = ResumeData(
    personal: PersonalInfo(
      fullName: 'Alex Rivera',
      title: 'Senior Product Engineer',
      email: 'alex.rivera@email.com',
      phone: '+1 555 010 8899',
      location: 'Austin, TX',
      linkedin: 'linkedin.com/in/alexrivera',
      github: 'github.com/alexrivera',
      portfolio: 'alexrivera.dev',
    ),
    summary:
        'Product-minded engineer who ships reliable mobile and web apps. '
        'Comfortable leading small teams, talking to users, and turning '
        'messy problems into simple software.',
    experiences: [
      Experience(
        id: 1,
        company: 'Northwind Labs',
        role: 'Senior Product Engineer',
        startDate: 'Jan 2022',
        isCurrent: true,
        bullets: [
          'Led a team of 5 to launch an offline-first Flutter app used by 80k people.',
          'Cut crash rate from 2.1% to 0.3% by adding tests and clearer error states.',
          'Worked with design to simplify onboarding; activation rose 18%.',
        ],
        sortOrder: 0,
      ),
      Experience(
        id: 2,
        company: 'Harbor & Co.',
        role: 'Software Engineer',
        startDate: 'Jun 2019',
        endDate: 'Dec 2021',
        bullets: [
          'Built customer dashboards in React and TypeScript.',
          'Moved reports to PostgreSQL views; page loads dropped from 4s to 900ms.',
        ],
        sortOrder: 1,
      ),
    ],
    educations: [
      Education(
        id: 1,
        school: 'University of Texas at Austin',
        degree: 'B.S.',
        field: 'Computer Science',
        startDate: '2015',
        endDate: '2019',
        details: 'Focus on human-computer interaction.',
      ),
    ],
    skillGroups: [
      SkillGroup(
        id: 1,
        name: 'Building',
        skills: [
          Skill(id: 1, groupId: 1, name: 'Flutter'),
          Skill(id: 2, groupId: 1, name: 'Dart'),
          Skill(id: 3, groupId: 1, name: 'React'),
          Skill(id: 4, groupId: 1, name: 'TypeScript'),
        ],
      ),
      SkillGroup(
        id: 2,
        name: 'Shipping',
        sortOrder: 1,
        skills: [
          Skill(id: 5, groupId: 2, name: 'SQLite'),
          Skill(id: 6, groupId: 2, name: 'CI/CD'),
          Skill(id: 7, groupId: 2, name: 'Firebase'),
        ],
      ),
    ],
    courses: [
      Course(
        id: 1,
        name: 'System Design Primer',
        issuer: 'Educative',
        date: '2023',
      ),
    ],
    projects: [
      Project(
        id: 1,
        name: 'Garden Log',
        link: 'github.com/alexrivera/garden-log',
        description: 'A small app for tracking plants, watering, and notes.',
        techStack: 'Flutter, Drift, SQLite',
        bullets: [
          'Works fully offline with local backup and restore.',
        ],
      ),
    ],
    languages: [
      Language(id: 1, name: 'English', proficiency: 'Native'),
      Language(id: 2, name: 'Spanish', proficiency: 'Conversational', sortOrder: 1),
    ],
    awards: [
      Award(
        id: 1,
        title: 'Engineering Excellence',
        issuer: 'Northwind Labs',
        date: '2024',
        description: 'For shipping the offline mobile suite.',
      ),
    ],
  );

  static ResumeData forPreview(ResumeData live) {
    final sample = data;
    return ResumeData(
      personal: PersonalInfo(
        fullName: _filled(live.personal.fullName, sample.personal.fullName),
        title: _filled(live.personal.title, sample.personal.title),
        email: _filled(live.personal.email, sample.personal.email),
        phone: _filled(live.personal.phone, sample.personal.phone),
        location: _filled(live.personal.location, sample.personal.location),
        linkedin: _filled(live.personal.linkedin, sample.personal.linkedin),
        github: _filled(live.personal.github, sample.personal.github),
        portfolio: _filled(live.personal.portfolio, sample.personal.portfolio),
      ),
      summary: _filled(live.summary, sample.summary),
      experiences: live.experiences.isEmpty
          ? sample.experiences
          : live.experiences,
      educations: live.educations.isEmpty ? sample.educations : live.educations,
      skillGroups: live.skillGroups.isEmpty
          ? sample.skillGroups
          : live.skillGroups,
      courses: live.courses.isEmpty ? sample.courses : live.courses,
      projects: live.projects.isEmpty ? sample.projects : live.projects,
      languages: live.languages.isEmpty ? sample.languages : live.languages,
      awards: live.awards.isEmpty ? sample.awards : live.awards,
      customSections: live.customSections,
      jobDescription: live.jobDescription,
      settings: live.settings,
    );
  }

  static String _filled(String live, String fallback) {
    return live.trim().isEmpty ? fallback : live;
  }
}
