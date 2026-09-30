// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_dao.dart';

// ignore_for_file: type=lint
mixin _$SettingsDaoMixin on DatabaseAccessor<AppDatabase> {
  $ResumeSettingsTableTable get resumeSettingsTable =>
      attachedDatabase.resumeSettingsTable;
  SettingsDaoManager get managers => SettingsDaoManager(this);
}

class SettingsDaoManager {
  final _$SettingsDaoMixin _db;
  SettingsDaoManager(this._db);
  $$ResumeSettingsTableTableTableManager get resumeSettingsTable =>
      $$ResumeSettingsTableTableTableManager(
        _db.attachedDatabase,
        _db.resumeSettingsTable,
      );
}
