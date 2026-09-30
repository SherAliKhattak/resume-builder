import 'package:flutter_test/flutter_test.dart';

import 'package:resume_builder/core/analysis/keyword_analyzer.dart';
import 'package:resume_builder/features/profile/domain/models/profile_models.dart';
import 'package:resume_builder/features/profile/domain/models/resume_data.dart';

void main() {
  final analyzer = KeywordAnalyzer();

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

    expect(result.percent, greaterThan(0));
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
}
