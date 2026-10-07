import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables.dart';

part 'profile_dao.g.dart';

@DriftAccessor(
  tables: [
    PersonalInfoTable,
    SummaryTable,
    Experiences,
    Educations,
    SkillGroups,
    Skills,
    Courses,
    Projects,
    Languages,
    Awards,
    CustomSections,
  ],
)
class ProfileDao extends DatabaseAccessor<AppDatabase> with _$ProfileDaoMixin {
  ProfileDao(super.db);

  Stream<PersonalInfoRow> watchPersonalInfo() {
    return (select(personalInfoTable)
          ..where((t) => t.id.equals(1)))
        .watchSingle();
  }

  Future<PersonalInfoRow> getPersonalInfo() {
    return (select(personalInfoTable)
          ..where((t) => t.id.equals(1)))
        .getSingle();
  }

  Future<void> upsertPersonalInfo(PersonalInfoTableCompanion data) {
    return into(personalInfoTable).insertOnConflictUpdate(data);
  }

  Stream<SummaryRow> watchSummary() {
    return (select(summaryTable)..where((t) => t.id.equals(1))).watchSingle();
  }

  Future<SummaryRow> getSummary() {
    return (select(summaryTable)..where((t) => t.id.equals(1))).getSingle();
  }

  Future<void> upsertSummary(SummaryTableCompanion data) {
    return into(summaryTable).insertOnConflictUpdate(data);
  }

  Stream<List<ExperienceRow>> watchExperiences() {
    return (select(experiences)
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .watch();
  }

  Future<List<ExperienceRow>> getExperiences() {
    return (select(experiences)
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .get();
  }

  Future<int> insertExperience(ExperiencesCompanion data) {
    return into(experiences).insert(data);
  }

  Future<void> updateExperience(int id, ExperiencesCompanion data) {
    return (update(experiences)..where((t) => t.id.equals(id))).write(data);
  }

  Future<void> deleteExperience(int id) {
    return (delete(experiences)..where((t) => t.id.equals(id))).go();
  }

  Future<void> reorderExperiences(List<int> ids) async {
    await transaction(() async {
      for (var i = 0; i < ids.length; i++) {
        await (update(experiences)..where((t) => t.id.equals(ids[i]))).write(
          ExperiencesCompanion(sortOrder: Value(i)),
        );
      }
    });
  }

  Stream<List<EducationRow>> watchEducations() {
    return (select(educations)
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .watch();
  }

  Future<List<EducationRow>> getEducations() {
    return (select(educations)
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .get();
  }

  Future<int> insertEducation(EducationsCompanion data) {
    return into(educations).insert(data);
  }

  Future<void> updateEducation(int id, EducationsCompanion data) {
    return (update(educations)..where((t) => t.id.equals(id))).write(data);
  }

  Future<void> deleteEducation(int id) {
    return (delete(educations)..where((t) => t.id.equals(id))).go();
  }

  Future<void> reorderEducations(List<int> ids) async {
    await transaction(() async {
      for (var i = 0; i < ids.length; i++) {
        await (update(educations)..where((t) => t.id.equals(ids[i]))).write(
          EducationsCompanion(sortOrder: Value(i)),
        );
      }
    });
  }

  Stream<List<SkillGroupRow>> watchSkillGroups() {
    return (select(skillGroups)
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .watch();
  }

  Future<List<SkillGroupRow>> getSkillGroups() {
    return (select(skillGroups)
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .get();
  }

  Stream<List<SkillRow>> watchSkills() {
    return (select(skills)..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .watch();
  }

  Future<List<SkillRow>> getSkills() {
    return (select(skills)..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .get();
  }

  Future<int> insertSkillGroup(SkillGroupsCompanion data) {
    return into(skillGroups).insert(data);
  }

  Future<void> updateSkillGroup(int id, SkillGroupsCompanion data) {
    return (update(skillGroups)..where((t) => t.id.equals(id))).write(data);
  }

  Future<void> deleteSkillGroup(int id) {
    return (delete(skillGroups)..where((t) => t.id.equals(id))).go();
  }

  Future<int> insertSkill(SkillsCompanion data) {
    return into(skills).insert(data);
  }

  Future<void> deleteSkill(int id) {
    return (delete(skills)..where((t) => t.id.equals(id))).go();
  }

  Future<void> moveSkill(int id, int groupId, int sortOrder) {
    return (update(skills)..where((t) => t.id.equals(id))).write(
      SkillsCompanion(
        groupId: Value(groupId),
        sortOrder: Value(sortOrder),
      ),
    );
  }

  Future<void> reorderSkillGroups(List<int> ids) async {
    await transaction(() async {
      for (var i = 0; i < ids.length; i++) {
        await (update(skillGroups)..where((t) => t.id.equals(ids[i]))).write(
          SkillGroupsCompanion(sortOrder: Value(i)),
        );
      }
    });
  }

  Future<void> reorderSkills(List<int> ids) async {
    await transaction(() async {
      for (var i = 0; i < ids.length; i++) {
        await (update(skills)..where((t) => t.id.equals(ids[i]))).write(
          SkillsCompanion(sortOrder: Value(i)),
        );
      }
    });
  }

  Stream<List<CourseRow>> watchCourses() {
    return (select(courses)..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .watch();
  }

  Future<List<CourseRow>> getCourses() {
    return (select(courses)..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .get();
  }

  Future<int> insertCourse(CoursesCompanion data) {
    return into(courses).insert(data);
  }

  Future<void> updateCourse(int id, CoursesCompanion data) {
    return (update(courses)..where((t) => t.id.equals(id))).write(data);
  }

  Future<void> deleteCourse(int id) {
    return (delete(courses)..where((t) => t.id.equals(id))).go();
  }

  Future<void> reorderCourses(List<int> ids) async {
    await transaction(() async {
      for (var i = 0; i < ids.length; i++) {
        await (update(courses)..where((t) => t.id.equals(ids[i]))).write(
          CoursesCompanion(sortOrder: Value(i)),
        );
      }
    });
  }

  Stream<List<ProjectRow>> watchProjects() {
    return (select(projects)..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .watch();
  }

  Future<List<ProjectRow>> getProjects() {
    return (select(projects)..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .get();
  }

  Future<int> insertProject(ProjectsCompanion data) {
    return into(projects).insert(data);
  }

  Future<void> updateProject(int id, ProjectsCompanion data) {
    return (update(projects)..where((t) => t.id.equals(id))).write(data);
  }

  Future<void> deleteProject(int id) {
    return (delete(projects)..where((t) => t.id.equals(id))).go();
  }

  Future<void> reorderProjects(List<int> ids) async {
    await transaction(() async {
      for (var i = 0; i < ids.length; i++) {
        await (update(projects)..where((t) => t.id.equals(ids[i]))).write(
          ProjectsCompanion(sortOrder: Value(i)),
        );
      }
    });
  }

  Stream<List<LanguageRow>> watchLanguages() {
    return (select(languages)..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .watch();
  }

  Future<List<LanguageRow>> getLanguages() {
    return (select(languages)..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .get();
  }

  Future<int> insertLanguage(LanguagesCompanion data) {
    return into(languages).insert(data);
  }

  Future<void> updateLanguage(int id, LanguagesCompanion data) {
    return (update(languages)..where((t) => t.id.equals(id))).write(data);
  }

  Future<void> deleteLanguage(int id) {
    return (delete(languages)..where((t) => t.id.equals(id))).go();
  }

  Future<void> reorderLanguages(List<int> ids) async {
    await transaction(() async {
      for (var i = 0; i < ids.length; i++) {
        await (update(languages)..where((t) => t.id.equals(ids[i]))).write(
          LanguagesCompanion(sortOrder: Value(i)),
        );
      }
    });
  }

  Stream<List<AwardRow>> watchAwards() {
    return (select(awards)..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .watch();
  }

  Future<List<AwardRow>> getAwards() {
    return (select(awards)..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .get();
  }

  Future<int> insertAward(AwardsCompanion data) {
    return into(awards).insert(data);
  }

  Future<void> updateAward(int id, AwardsCompanion data) {
    return (update(awards)..where((t) => t.id.equals(id))).write(data);
  }

  Future<void> deleteAward(int id) {
    return (delete(awards)..where((t) => t.id.equals(id))).go();
  }

  Future<void> reorderAwards(List<int> ids) async {
    await transaction(() async {
      for (var i = 0; i < ids.length; i++) {
        await (update(awards)..where((t) => t.id.equals(ids[i]))).write(
          AwardsCompanion(sortOrder: Value(i)),
        );
      }
    });
  }

  Stream<List<CustomSectionRow>> watchCustomSections() {
    return (select(customSections)
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .watch();
  }

  Future<List<CustomSectionRow>> getCustomSections() {
    return (select(customSections)
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .get();
  }

  Future<int> insertCustomSection(CustomSectionsCompanion data) {
    return into(customSections).insert(data);
  }

  Future<void> updateCustomSection(int id, CustomSectionsCompanion data) {
    return (update(customSections)..where((t) => t.id.equals(id))).write(data);
  }

  Future<void> deleteCustomSection(int id) {
    return (delete(customSections)..where((t) => t.id.equals(id))).go();
  }

  Future<void> reorderCustomSections(List<int> ids) async {
    await transaction(() async {
      for (var i = 0; i < ids.length; i++) {
        await (update(customSections)..where((t) => t.id.equals(ids[i]))).write(
          CustomSectionsCompanion(sortOrder: Value(i)),
        );
      }
    });
  }

  Future<void> clearAll() async {
    await delete(skills).go();
    await delete(skillGroups).go();
    await delete(experiences).go();
    await delete(educations).go();
    await delete(courses).go();
    await delete(projects).go();
    await delete(languages).go();
    await delete(awards).go();
    await delete(customSections).go();
  }
}
