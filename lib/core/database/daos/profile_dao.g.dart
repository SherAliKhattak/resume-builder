// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_dao.dart';

// ignore_for_file: type=lint
mixin _$ProfileDaoMixin on DatabaseAccessor<AppDatabase> {
  $PersonalInfoTableTable get personalInfoTable =>
      attachedDatabase.personalInfoTable;
  $SummaryTableTable get summaryTable => attachedDatabase.summaryTable;
  $ExperiencesTable get experiences => attachedDatabase.experiences;
  $EducationsTable get educations => attachedDatabase.educations;
  $SkillGroupsTable get skillGroups => attachedDatabase.skillGroups;
  $SkillsTable get skills => attachedDatabase.skills;
  $CoursesTable get courses => attachedDatabase.courses;
  $ProjectsTable get projects => attachedDatabase.projects;
  $LanguagesTable get languages => attachedDatabase.languages;
  $AwardsTable get awards => attachedDatabase.awards;
  $CustomSectionsTable get customSections => attachedDatabase.customSections;
  ProfileDaoManager get managers => ProfileDaoManager(this);
}

class ProfileDaoManager {
  final _$ProfileDaoMixin _db;
  ProfileDaoManager(this._db);
  $$PersonalInfoTableTableTableManager get personalInfoTable =>
      $$PersonalInfoTableTableTableManager(
        _db.attachedDatabase,
        _db.personalInfoTable,
      );
  $$SummaryTableTableTableManager get summaryTable =>
      $$SummaryTableTableTableManager(_db.attachedDatabase, _db.summaryTable);
  $$ExperiencesTableTableManager get experiences =>
      $$ExperiencesTableTableManager(_db.attachedDatabase, _db.experiences);
  $$EducationsTableTableManager get educations =>
      $$EducationsTableTableManager(_db.attachedDatabase, _db.educations);
  $$SkillGroupsTableTableManager get skillGroups =>
      $$SkillGroupsTableTableManager(_db.attachedDatabase, _db.skillGroups);
  $$SkillsTableTableManager get skills =>
      $$SkillsTableTableManager(_db.attachedDatabase, _db.skills);
  $$CoursesTableTableManager get courses =>
      $$CoursesTableTableManager(_db.attachedDatabase, _db.courses);
  $$ProjectsTableTableManager get projects =>
      $$ProjectsTableTableManager(_db.attachedDatabase, _db.projects);
  $$LanguagesTableTableManager get languages =>
      $$LanguagesTableTableManager(_db.attachedDatabase, _db.languages);
  $$AwardsTableTableManager get awards =>
      $$AwardsTableTableManager(_db.attachedDatabase, _db.awards);
  $$CustomSectionsTableTableManager get customSections =>
      $$CustomSectionsTableTableManager(
        _db.attachedDatabase,
        _db.customSections,
      );
}
