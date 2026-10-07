import 'dart:convert';

import 'package:drift/drift.dart';

import '../constants/section_keys.dart';
import 'connection.dart';
import 'daos/job_description_dao.dart';
import 'daos/profile_dao.dart';
import 'daos/settings_dao.dart';
import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
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
    JobDescriptions,
    ResumeSettingsTable,
  ],
  daos: [ProfileDao, JobDescriptionDao, SettingsDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection());

  AppDatabase.forTesting() : super(openInMemoryConnection());

  AppDatabase.connect(super.e);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await _seedSingletons();
    },
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.addColumn(resumeSettingsTable, resumeSettingsTable.fontFamily);
      }
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
      await customStatement('PRAGMA busy_timeout = 5000');
      await customStatement('PRAGMA journal_mode = DELETE');
      await customStatement('PRAGMA synchronous = FULL');
      final personal = await (select(personalInfoTable)
            ..where((t) => t.id.equals(1)))
          .getSingleOrNull();
      if (personal == null) {
        await _seedSingletons();
      }
    },
  );

  Future<void> _seedSingletons() async {
    await into(personalInfoTable).insert(
      const PersonalInfoTableCompanion(id: Value(1)),
    );
    await into(summaryTable).insert(
      const SummaryTableCompanion(id: Value(1)),
    );
    await into(resumeSettingsTable).insert(
      ResumeSettingsTableCompanion(
        id: const Value(1),
        templateId: const Value('classic'),
        accentColor: const Value(0xFF1D4ED8),
        fontFamily: const Value('inter'),
        fontSize: const Value(10.0),
        margin: const Value(40.0),
        sectionOrderJson: Value(jsonEncode(SectionKeys.defaultOrder)),
        sectionVisibilityJson: const Value('{}'),
        hasSeenOnboarding: const Value(false),
      ),
    );
  }
}
