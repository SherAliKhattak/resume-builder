import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:resume_builder/core/analysis/keyword_analyzer.dart';
import 'package:resume_builder/core/analysis/simple_stemmer.dart';
import 'package:resume_builder/core/analysis/skill_lexicon.dart';
import 'package:resume_builder/core/analysis/text_normalizer.dart';
import 'package:resume_builder/features/job_description/domain/usecases/analyze_job_keywords.dart';
import 'package:resume_builder/features/profile/domain/models/profile_models.dart';
import 'package:resume_builder/features/profile/domain/models/resume_data.dart';
import 'package:resume_builder/seed/sample_resume.dart';

void main() {
  final analyzer = KeywordAnalyzer();

  const flutterResume = ResumeData(
    personal: PersonalInfo(fullName: 'Ada', email: 'ada@email.com'),
    summary: 'Flutter engineer who ships offline-first mobile apps.',
    skillGroups: [
      SkillGroup(
        name: 'Building',
        skills: [
          Skill(name: 'Flutter'),
          Skill(name: 'Dart'),
          Skill(name: 'SQLite'),
          Skill(name: 'REST API'),
        ],
      ),
    ],
    experiences: [
      Experience(
        role: 'Mobile Engineer',
        company: 'Northwind',
        bullets: [
          'Shipped a Flutter app with Dart and SQLite for 80k users.',
          'Built REST API integrations and state management with BLoC.',
        ],
      ),
    ],
    projects: [
      Project(
        name: 'Resume builder',
        techStack: 'Flutter, Dart',
        bullets: ['Used BLoC for state management.'],
      ),
    ],
  );

  const analystResume = ResumeData(
    skillGroups: [
      SkillGroup(
        skills: [
          Skill(name: 'SQL'),
          Skill(name: 'Python'),
          Skill(name: 'Excel'),
        ],
      ),
    ],
    experiences: [
      Experience(
        role: 'Data Analyst',
        bullets: [
          'Wrote SQL and Python scripts to clean datasets.',
          'Built Excel models for weekly reporting.',
        ],
      ),
    ],
  );

  const marketerResume = ResumeData(
    skillGroups: [
      SkillGroup(
        skills: [
          Skill(name: 'SEO'),
          Skill(name: 'Copywriting'),
        ],
      ),
    ],
  );

  test('scores a matching job post', () {
    const resume = ResumeData(
      personal: PersonalInfo(fullName: 'Ada', email: 'ada@email.com'),
      skillGroups: [
        SkillGroup(
          name: 'Building',
          skills: [
            Skill(name: 'Flutter'),
            Skill(name: 'Dart'),
            Skill(name: 'SQLite'),
          ],
        ),
      ],
    );

    final result = analyzer.analyze(
      jobDescription:
          'We need a Flutter and Dart engineer with SQLite and Kubernetes experience.',
      resume: resume,
    );

    expect(result.percent, inInclusiveRange(75, 78));
    expect(result.matched.map((e) => e.toLowerCase()), contains('flutter'));
    expect(result.missing.map((e) => e.toLowerCase()), contains('kubernetes'));
  });

  test('returns zero when the job post has no known skills', () {
    final result = analyzer.analyze(
      jobDescription: 'The the and of with a job at our company.',
      resume: const ResumeData(),
    );
    expect(result.percent, 0);
    expect(result.matched, isEmpty);
    expect(result.missing, isEmpty);
  });

  test('treats phrases such as machine learning as one keyword', () {
    const resume = ResumeData(
      skillGroups: [
        SkillGroup(skills: [Skill(name: 'Machine Learning')]),
      ],
    );
    final result = analyzer.analyze(
      jobDescription: 'Looking for machine learning and pandas skills.',
      resume: resume,
    );
    expect(
      result.matched.any((item) => item.toLowerCase().contains('machine')),
      isTrue,
    );
    expect(
      result.missing.any((item) => item.toLowerCase() == 'pandas'),
      isTrue,
    );
  });

  test('handles an empty job post and empty resume', () {
    expect(
      analyzer.analyze(jobDescription: '', resume: const ResumeData()).percent,
      0,
    );
    expect(
      analyzer.analyze(jobDescription: '   ', resume: const ResumeData()).missing,
      isEmpty,
    );
    final emptyResume = analyzer.analyze(
      jobDescription: 'Requirements:\n- Flutter\n- Dart',
      resume: const ResumeData(),
    );
    expect(emptyResume.matched, isEmpty);
    expect(emptyResume.missing.map((e) => e.toLowerCase()), containsAll(['flutter', 'dart']));
    expect(emptyResume.percent, 0);
  });

  test('Flutter developer JD ranks missing tools and matches synonyms', () {
    const jd = '''
Senior Flutter Developer

Requirements:
- Must have Flutter, Dart, and BLoC or Provider for state management
- REST API, Firebase, Git, and CI/CD
- Clean Architecture on iOS and Android

Nice to have:
- Kubernetes and K8s experience
- JavaScript or JS
''';
    final result = analyzer.analyze(jobDescription: jd, resume: flutterResume);
    expect(result.matched.map((e) => e.toLowerCase()), contains('flutter'));
    expect(result.matched.map((e) => e.toLowerCase()), contains('dart'));
    expect(
      result.matchedKeywords.any((item) => item.canonical.contains('state management')),
      isTrue,
    );
    expect(result.missing.map((e) => e.toLowerCase()), contains('kubernetes'));
    expect(
      result.missingKeywords.firstWhere((item) => item.canonical == 'kubernetes').importance,
      isNot(KeywordImportance.low),
    );
    expect(result.matchPercentage, result.score);
    expect(result.guidanceMessage.toLowerCase(), contains('if you have'));
    expect(result.percent, inInclusiveRange(75, 80));
  });

  test('sample resume vs a Flutter JD lands in the mid 70s', () {
    const jd = '''
Senior Flutter Developer

Requirements:
- Must have Flutter, Dart, and BLoC or Provider for state management
- REST API, Firebase, Git, and CI/CD
- Clean Architecture on iOS and Android

Nice to have:
- Kubernetes and K8s experience
- JavaScript or JS
''';
    final result = analyzer.analyze(
      jobDescription: jd,
      resume: SampleResume.data,
    );
    expect(result.percent, inInclusiveRange(75, 78));
  });

  test('data analyst JD matches SQL and flags Tableau as missing', () {
    const jd = '''
Data Analyst

Qualifications:
- SQL, Python, and statistics
- Tableau or Power BI
- Excel and data analysis

Preferred:
- dbt and Looker
''';
    final result = analyzer.analyze(jobDescription: jd, resume: analystResume);
    expect(result.matched.map((e) => e.toLowerCase()), contains('sql'));
    expect(result.matched.map((e) => e.toLowerCase()), contains('python'));
    expect(result.missing.map((e) => e.toLowerCase()), contains('tableau'));
    expect(
      result.missingKeywords.any((item) => item.category == KeywordCategory.tool),
      isTrue,
    );
    expect(
      result.matchedKeywords.any((item) => item.strength == MatchStrength.strong),
      isTrue,
    );
  });

  test('marketing JD keeps SEO and reports HubSpot as missing', () {
    const jd = '''
Digital Marketing Manager

Requirements:
- SEO, content strategy, and copywriting
- Google Analytics and HubSpot
- Email marketing and paid ads

Preferred:
- Salesforce
''';
    final result = analyzer.analyze(jobDescription: jd, resume: marketerResume);
    expect(result.matched.map((e) => e.toLowerCase()), contains('seo'));
    expect(result.missing.map((e) => e.toLowerCase()), contains('hubspot'));
    expect(
      result.weakKeywords.map((e) => e.canonical),
      contains('seo'),
    );
    expect(result.percent, lessThan(100));
    expect(result.percent, lessThan(70));
  });

  test('weights requirements higher than preferred and caps stuffing', () {
    const jd = '''
Flutter Engineer

Requirements:
- Flutter Flutter Flutter Flutter Flutter

Preferred:
- Figma
''';
    final result = AnalyzeJobKeywords().call(
      jobDescription: jd,
      resume: flutterResume,
    );
    final flutter = result.matchedKeywords.firstWhere(
      (item) => item.canonical == 'flutter',
    );
    final figma = result.missingKeywords.firstWhere(
      (item) => item.canonical == 'figma',
    );
    expect(flutter.weight, greaterThan(figma.weight));
    expect(flutter.weight, lessThanOrEqualTo(6));
  });

  test('stems managing and stakeholders to the same roots', () {
    expect(SimpleStemmer.stem('managing'), 'manage');
    expect(SimpleStemmer.stem('management'), 'manage');
    expect(SimpleStemmer.stem('stakeholders'), 'stakeholder');
    final hay = {
      for (final token in TextNormalizer.tokens(
        'used javascript daily while managing stakeholders',
      ))
        ...SimpleStemmer.variants(token),
    };
    expect(
      ['stakeholder', 'management'].every(
        (token) => SimpleStemmer.variants(token).any(hay.contains),
      ),
      isTrue,
    );
  });

  test('maps JS to JavaScript and managing to manage', () {
    const resume = ResumeData(
      experiences: [
        Experience(
          bullets: [
            'Used JavaScript daily while managing stakeholders.',
          ],
        ),
      ],
    );
    final result = analyzer.analyze(
      jobDescription: 'Requirements:\n- JS\n- stakeholder management',
      resume: resume,
    );
    expect(
      result.matched.any((item) => item.toLowerCase().contains('javascript')),
      isTrue,
    );
    expect(
      result.matched.any((item) => item.toLowerCase().contains('management')),
      isTrue,
    );
  });

  test('parses the skills dictionary JSON', () {
    const raw = '''
    [
      {"term": "JavaScript", "category": "hardSkill", "synonyms": ["js"]},
      {"term": "HubSpot", "category": "tool", "synonyms": []}
    ]
    ''';
    final lexicon = SkillLexicon.fromJson(jsonDecode(raw) as List);
    expect(lexicon.find('js')?.term, 'JavaScript');
    expect(lexicon.find('hubspot')?.category, KeywordCategory.tool);
  });

  test('finishes a 1000-word JD quickly', () {
    final buffer = StringBuffer('Senior Flutter Developer\nRequirements:\n');
    for (var i = 0; i < 200; i++) {
      buffer.writeln(
        'Flutter Dart REST API Firebase Git CI/CD Kubernetes SQL Python SEO Tableau',
      );
    }
    final jd = buffer.toString();
    analyzer.analyze(jobDescription: jd, resume: flutterResume);
    final watch = Stopwatch()..start();
    final result = analyzer.analyze(jobDescription: jd, resume: flutterResume);
    watch.stop();
    expect(result.matched, isNotEmpty);
    expect(watch.elapsedMilliseconds, lessThan(200));
  });
}
