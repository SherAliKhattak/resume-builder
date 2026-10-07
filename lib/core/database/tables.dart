import 'package:drift/drift.dart';

@DataClassName('PersonalInfoRow')
class PersonalInfoTable extends Table {
  @override
  String get tableName => 'personal_info';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get fullName => text().withDefault(const Constant(''))();
  TextColumn get title => text().withDefault(const Constant(''))();
  TextColumn get email => text().withDefault(const Constant(''))();
  TextColumn get phone => text().withDefault(const Constant(''))();
  TextColumn get location => text().withDefault(const Constant(''))();
  TextColumn get linkedin => text().withDefault(const Constant(''))();
  TextColumn get github => text().withDefault(const Constant(''))();
  TextColumn get portfolio => text().withDefault(const Constant(''))();
}

@DataClassName('SummaryRow')
class SummaryTable extends Table {
  @override
  String get tableName => 'summary';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get body => text().withDefault(const Constant(''))();
}

@DataClassName('ExperienceRow')
class Experiences extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get company => text().withDefault(const Constant(''))();
  TextColumn get role => text().withDefault(const Constant(''))();
  TextColumn get startDate => text().withDefault(const Constant(''))();
  TextColumn get endDate => text().withDefault(const Constant(''))();
  BoolColumn get isCurrent => boolean().withDefault(const Constant(false))();
  TextColumn get bulletsJson => text().withDefault(const Constant('[]'))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
}

@DataClassName('EducationRow')
class Educations extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get school => text().withDefault(const Constant(''))();
  TextColumn get degree => text().withDefault(const Constant(''))();
  TextColumn get field => text().withDefault(const Constant(''))();
  TextColumn get startDate => text().withDefault(const Constant(''))();
  TextColumn get endDate => text().withDefault(const Constant(''))();
  TextColumn get details => text().withDefault(const Constant(''))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
}

@DataClassName('SkillGroupRow')
class SkillGroups extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withDefault(const Constant(''))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
}

@DataClassName('SkillRow')
class Skills extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get groupId => integer().references(
    SkillGroups,
    #id,
    onDelete: KeyAction.cascade,
  )();
  TextColumn get name => text().withDefault(const Constant(''))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
}

@DataClassName('CourseRow')
class Courses extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withDefault(const Constant(''))();
  TextColumn get issuer => text().withDefault(const Constant(''))();
  TextColumn get date => text().withDefault(const Constant(''))();
  TextColumn get url => text().withDefault(const Constant(''))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
}

@DataClassName('ProjectRow')
class Projects extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withDefault(const Constant(''))();
  TextColumn get link => text().withDefault(const Constant(''))();
  TextColumn get description => text().withDefault(const Constant(''))();
  TextColumn get techStack => text().withDefault(const Constant(''))();
  TextColumn get bulletsJson => text().withDefault(const Constant('[]'))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
}

@DataClassName('LanguageRow')
class Languages extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withDefault(const Constant(''))();
  TextColumn get proficiency => text().withDefault(const Constant(''))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
}

@DataClassName('AwardRow')
class Awards extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withDefault(const Constant(''))();
  TextColumn get issuer => text().withDefault(const Constant(''))();
  TextColumn get date => text().withDefault(const Constant(''))();
  TextColumn get description => text().withDefault(const Constant(''))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
}

@DataClassName('CustomSectionRow')
class CustomSections extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withDefault(const Constant(''))();
  TextColumn get body => text().withDefault(const Constant(''))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  BoolColumn get isVisible => boolean().withDefault(const Constant(true))();
}

@DataClassName('JobDescriptionRow')
class JobDescriptions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get rawText => text().withDefault(const Constant(''))();
  DateTimeColumn get analyzedAt => dateTime().nullable()();
  RealColumn get matchScore => real().nullable()();
  TextColumn get matchedJson => text().withDefault(const Constant('[]'))();
  TextColumn get missingJson => text().withDefault(const Constant('[]'))();
}

@DataClassName('ResumeSettingsRow')
class ResumeSettingsTable extends Table {
  @override
  String get tableName => 'resume_settings';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get templateId => text().withDefault(const Constant('classic'))();
  IntColumn get accentColor => integer().withDefault(const Constant(0xFF0F766E))();
  TextColumn get fontFamily => text().withDefault(const Constant('inter'))();
  RealColumn get fontSize => real().withDefault(const Constant(10.0))();
  RealColumn get margin => real().withDefault(const Constant(40.0))();
  TextColumn get sectionOrderJson => text().withDefault(const Constant('[]'))();
  TextColumn get sectionVisibilityJson =>
      text().withDefault(const Constant('{}'))();
  BoolColumn get hasSeenOnboarding =>
      boolean().withDefault(const Constant(false))();
}
