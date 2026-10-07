import 'package:flutter_test/flutter_test.dart';
import 'package:resume_builder/core/database/app_database.dart';
import 'package:resume_builder/features/profile/data/repositories/resume_repository_impl.dart';
import 'package:resume_builder/features/profile/domain/models/profile_models.dart';

void main() {
  late AppDatabase db;
  late ResumeRepositoryImpl repo;

  setUp(() {
    db = AppDatabase.forTesting();
    repo = ResumeRepositoryImpl(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('seeds singleton rows', () async {
    final resume = await repo.getResume();
    expect(resume.personal.id, 1);
    expect(resume.settings.templateId, 'classic');
  });

  test('saves personal info and watches it', () async {
    await repo.savePersonalInfo(
      const PersonalInfo(fullName: 'Ada Lovelace', email: 'ada@email.com'),
    );
    final info = await repo.watchPersonalInfo().first;
    expect(info.fullName, 'Ada Lovelace');
    expect(info.email, 'ada@email.com');
  });

  test('inserts, reorders, and deletes experience', () async {
    await repo.addExperience(const Experience(company: 'A', role: 'Eng'));
    await repo.addExperience(const Experience(company: 'B', role: 'Lead'));
    var items = await repo.watchExperiences().first;
    expect(items, hasLength(2));
    await repo.reorderExperiences([items.last.id, items.first.id]);
    items = await repo.watchExperiences().first;
    expect(items.first.company, 'B');
    await repo.deleteExperience(items.first.id);
    items = await repo.watchExperiences().first;
    expect(items, hasLength(1));
    expect(items.first.company, 'A');
  });

  test('exports and imports json', () async {
    await repo.savePersonalInfo(
      const PersonalInfo(fullName: 'Ada Lovelace', email: 'ada@email.com'),
    );
    await repo.addProject(const Project(name: 'Engine'));
    final json = await repo.exportJson();
    await repo.savePersonalInfo(const PersonalInfo(fullName: 'Cleared'));
    await repo.importJson(json);
    final resume = await repo.getResume();
    expect(resume.personal.fullName, 'Ada Lovelace');
    expect(resume.projects.single.name, 'Engine');
  });

  test('saves the selected resume font', () async {
    final current = await repo.getSettings();
    await repo.saveSettings(current.copyWith(fontFamily: 'libreBaskerville'));
    final saved = await repo.getSettings();
    expect(saved.fontFamily, 'libreBaskerville');
  });

  test('moves a skill into another group', () async {
    final flutter = await repo.addSkillGroup('Flutter skills');
    final deploy = await repo.addSkillGroup('Deployment');
    final skillId = await repo.addSkill(deploy, 'CI/CD');
    await repo.moveSkill(skillId, flutter);
    final groups = await repo.watchSkillGroups().first;
    final flutterGroup = groups.firstWhere((group) => group.id == flutter);
    final deployGroup = groups.firstWhere((group) => group.id == deploy);
    expect(flutterGroup.skills.single.name, 'CI/CD');
    expect(deployGroup.skills, isEmpty);
  });
}
