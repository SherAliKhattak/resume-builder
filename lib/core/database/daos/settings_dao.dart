import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables.dart';

part 'settings_dao.g.dart';

@DriftAccessor(tables: [ResumeSettingsTable])
class SettingsDao extends DatabaseAccessor<AppDatabase>
    with _$SettingsDaoMixin {
  SettingsDao(super.db);

  Stream<ResumeSettingsRow> watch() {
    return (select(resumeSettingsTable)
          ..where((t) => t.id.equals(1)))
        .watchSingle();
  }

  Future<ResumeSettingsRow> get() {
    return (select(resumeSettingsTable)
          ..where((t) => t.id.equals(1)))
        .getSingle();
  }

  Future<void> upsert(ResumeSettingsTableCompanion data) {
    return into(resumeSettingsTable).insertOnConflictUpdate(data);
  }
}
