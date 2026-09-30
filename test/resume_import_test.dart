import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:resume_builder/core/database/app_database.dart';
import 'package:resume_builder/core/import/resume_file_reader.dart';
import 'package:resume_builder/core/import/resume_import_service.dart';
import 'package:resume_builder/core/import/resume_text_parser.dart';
import 'package:resume_builder/features/profile/data/repositories/resume_repository_impl.dart';
import 'package:resume_builder/features/profile/domain/models/profile_models.dart';

const _sampleText = '''
Alex Rivera
Senior Product Engineer
alex.rivera@email.com | +1 555 010 8899 | Austin, TX
linkedin.com/in/alexrivera
github.com/alexrivera
alexrivera.dev

SUMMARY
Product-minded engineer who ships reliable mobile and web apps. Comfortable leading small teams.

EXPERIENCE
Senior Product Engineer
Northwind Labs
Jan 2022 - Present
- Led a team of 5 to launch an offline-first Flutter app.
- Cut crash rate from 2.1% to 0.3%.

Software Engineer
Harbor & Co.
Jun 2019 - Dec 2021
- Built customer dashboards in React and TypeScript.

EDUCATION
B.S. in Computer Science
University of Texas at Austin
2015 - 2019

SKILLS
Flutter, Dart, React, TypeScript

PROJECTS
Garden Log
github.com/alexrivera/garden-log
A small app for tracking plants.
''';

void main() {
  test('parses contact, jobs, school, and skills from resume text', () {
    final data = ResumeTextParser.parse(_sampleText);
    expect(data.personal.fullName, 'Alex Rivera');
    expect(data.personal.title, 'Senior Product Engineer');
    expect(data.personal.email, 'alex.rivera@email.com');
    expect(data.personal.phone, contains('555'));
    expect(data.personal.location, 'Austin, TX');
    expect(data.personal.linkedin, contains('linkedin.com/in/alexrivera'));
    expect(data.summary, contains('Product-minded engineer'));
    expect(data.experiences, hasLength(2));
    expect(data.experiences.first.company, 'Northwind Labs');
    expect(data.experiences.first.isCurrent, isTrue);
    expect(data.educations.single.school, contains('University of Texas'));
    expect(data.skillGroups.single.skills.map((s) => s.name.toLowerCase()), contains('flutter'));
    expect(data.projects.single.name, 'Garden Log');
  });

  test('does not treat LinkedIn or GitHub links as skills', () {
    const text = '''
Alex Rivera
Senior Product Engineer
alex.rivera@email.com
linkedin.com/in/alexrivera
github.com/alexrivera
alexrivera.dev

SUMMARY
Product-minded engineer who ships reliable mobile and web apps.

SKILLS
Flutter, Dart, React, TypeScript
''';
    final data = ResumeTextParser.parse(text);
    final names = [
      for (final group in data.skillGroups)
        for (final skill in group.skills) skill.name.toLowerCase(),
    ];
    expect(names, contains('flutter'));
    expect(names, contains('dart'));
    expect(names, isNot(contains('github')));
    expect(names, isNot(contains('linkedin')));
    expect(
      names.any((name) => name.contains('linkedin') || name.contains('github.com')),
      isFalse,
    );
  });

  test('keeps grouped skills from the skills section', () {
    const text = '''
Alex Rivera
alex.rivera@email.com

SKILLS
Flutter & Architecture: Flutter, Dart, Clean Architecture
State Management: Bloc, Provider, GetX
''';
    final data = ResumeTextParser.parse(text);
    final names = [
      for (final group in data.skillGroups)
        for (final skill in group.skills) skill.name.toLowerCase(),
    ];
    expect(names, containsAll(['flutter', 'dart', 'bloc', 'provider']));
    expect(names, isNot(contains('github')));
    expect(data.skillGroups.map((group) => group.name.toLowerCase()), contains('state management'));
  });

  test('parses a flattened resume with no blank lines', () {
    const flattened =
        'ALEX RIVERA Senior Product Engineer alex.rivera@email.com '
        'SUMMARY Product-minded engineer who ships reliable mobile and web apps. '
        'EXPERIENCE Senior Product Engineer Northwind Labs Jan 2022 - Present '
        'Led a team of 5 to launch an offline-first Flutter app. '
        'Software Engineer Harbor & Co. Jun 2019 - Dec 2021 '
        'Built customer dashboards in React and TypeScript. '
        'EDUCATION B.S. in Computer Science University of Texas at Austin 2015 - 2019 '
        'SKILLS Flutter, Dart, React, TypeScript';
    final data = ResumeTextParser.parse(flattened);
    expect(data.personal.fullName, 'Alex Rivera');
    expect(data.summary, contains('Product-minded engineer'));
    expect(data.experiences, isNotEmpty);
    expect(data.experiences.first.company, contains('Northwind'));
    expect(data.experiences.first.isCurrent, isTrue);
    expect(data.skillGroups, isNotEmpty);
  });

  test('splits stacked jobs when there are no blank lines', () {
    const stacked = '''
EXPERIENCE
Senior Product Engineer
Northwind Labs
Jan 2022 - Present
- Led a team of 5 to launch an offline-first Flutter app.
Software Engineer
Harbor & Co.
Jun 2019 - Dec 2021
- Built customer dashboards in React and TypeScript.
''';
    final data = ResumeTextParser.parse('Alex Rivera\nSenior Product Engineer\n$stacked');
    expect(data.experiences, hasLength(2));
    expect(data.experiences.first.role, contains('Senior Product Engineer'));
    expect(data.experiences.last.company, contains('Harbor'));
  });

  test('fills only empty profile fields', () async {
    final db = AppDatabase.forTesting();
    addTearDown(db.close);
    final repo = ResumeRepositoryImpl(db);
    await repo.savePersonalInfo(
      const PersonalInfo(fullName: 'Keep Me', email: ''),
    );
    final service = ResumeImportService(repo);
    final result = await service.merge(ResumeTextParser.parse(_sampleText));
    final resume = await repo.getResume();
    expect(resume.personal.fullName, 'Keep Me');
    expect(resume.personal.email, 'alex.rivera@email.com');
    expect(resume.experiences, isNotEmpty);
    expect(result.filled, isNotEmpty);
    expect(result.filled, isNot(contains('name')));
    expect(result.filled, contains('email'));
  });

  test('reads text from a generated PDF', () async {
    final doc = pw.Document();
    doc.addPage(
      pw.Page(
        build: (_) => pw.Text(_sampleText),
      ),
    );
    final bytes = Uint8List.fromList(await doc.save());
    final text = ResumeFileReader.read(bytes, 'resume.pdf');
    final collapsed = text.toLowerCase().replaceAll(RegExp(r'\s+'), ' ');
    expect(collapsed, contains('alex rivera'));
    expect(collapsed, contains('flutter'));
    final data = ResumeTextParser.parse(text);
    expect(data.personal.fullName.toLowerCase(), contains('alex'));
    expect(data.summary.toLowerCase(), contains('product-minded'));
    expect(data.experiences, isNotEmpty);
  });

  test('reads text from a docx zip', () {
    final xml = '''
<?xml version="1.0"?>
<w:document xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">
  <w:body>
    <w:p><w:r><w:t>Alex Rivera</w:t></w:r></w:p>
    <w:p><w:r><w:t>alex.rivera@email.com</w:t></w:r></w:p>
    <w:p><w:r><w:t>SUMMARY</w:t></w:r></w:p>
    <w:p><w:r><w:t>Product-minded engineer who ships reliable apps.</w:t></w:r></w:p>
  </w:body>
</w:document>
''';
    final archive = Archive()
      ..addFile(ArchiveFile.string('word/document.xml', xml));
    final bytes = ZipEncoder().encodeBytes(archive);
    final text = ResumeFileReader.read(bytes, 'resume.docx');
    expect(text, contains('Alex Rivera'));
    expect(text, contains('alex.rivera@email.com'));
  });

  test('imports structured json without wiping filled fields', () async {
    final db = AppDatabase.forTesting();
    addTearDown(db.close);
    final repo = ResumeRepositoryImpl(db);
    await repo.savePersonalInfo(
      const PersonalInfo(fullName: 'Ada', email: 'ada@email.com'),
    );
    final service = ResumeImportService(repo);
    final payload = jsonEncode({
      'personal': {
        'fullName': 'Alex Rivera',
        'email': 'alex.rivera@email.com',
        'title': 'Engineer',
      },
      'summary': 'A short intro.',
    });
    await service.importBytes(
      bytes: Uint8List.fromList(utf8.encode(payload)),
      filename: 'resume.json',
    );
    final resume = await repo.getResume();
    expect(resume.personal.fullName, 'Ada');
    expect(resume.personal.email, 'ada@email.com');
    expect(resume.personal.title, 'Engineer');
    expect(resume.summary, 'A short intro.');
  });
}
