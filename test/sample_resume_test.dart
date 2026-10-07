import 'package:flutter_test/flutter_test.dart';
import 'package:resume_builder/features/profile/domain/models/profile_models.dart';
import 'package:resume_builder/features/profile/domain/models/resume_data.dart';
import 'package:resume_builder/seed/sample_resume.dart';

void main() {
  test('name and job role keep the rest of the sample resume', () {
    const live = ResumeData(
      personal: PersonalInfo(
        fullName: 'Ada Lovelace',
        title: 'Product designer',
      ),
    );

    final preview = SampleResume.forPreview(live);

    expect(preview.personal.fullName, 'Ada Lovelace');
    expect(preview.personal.title, 'Product designer');
    expect(preview.personal.email, SampleResume.data.personal.email);
    expect(preview.summary, SampleResume.data.summary);
    expect(preview.experiences, isNotEmpty);
    expect(preview.educations, isNotEmpty);
    expect(preview.skillGroups, isNotEmpty);
  });

  test('a filled section replaces only that sample section', () {
    const live = ResumeData(
      personal: PersonalInfo(fullName: 'Ada Lovelace'),
      experiences: [
        Experience(company: 'Analytical Engines', role: 'Mathematician'),
      ],
    );

    final preview = SampleResume.forPreview(live);

    expect(preview.experiences.single.company, 'Analytical Engines');
    expect(preview.educations.first.school, SampleResume.data.educations.first.school);
  });
}
