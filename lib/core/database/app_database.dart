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
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await _seedSingletons();
    },
    onUpgrade: (m, from, to) async {
      // schemaVersion 1 — no upgrades yet.
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
      await customStatement('PRAGMA journal_mode = WAL');
      await customStatement('PRAGMA synchronous = NORMAL');
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
        fontSize: const Value(10.0),
        margin: const Value(40.0),
        sectionOrderJson: Value(jsonEncode(SectionKeys.defaultOrder)),
        sectionVisibilityJson: const Value('{}'),
        hasSeenOnboarding: const Value(false),
      ),
    );
  }
}
