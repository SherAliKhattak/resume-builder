// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_description_dao.dart';

// ignore_for_file: type=lint
mixin _$JobDescriptionDaoMixin on DatabaseAccessor<AppDatabase> {
  $JobDescriptionsTable get jobDescriptions => attachedDatabase.jobDescriptions;
  JobDescriptionDaoManager get managers => JobDescriptionDaoManager(this);
}

class JobDescriptionDaoManager {
  final _$JobDescriptionDaoMixin _db;
  JobDescriptionDaoManager(this._db);
  $$JobDescriptionsTableTableManager get jobDescriptions =>
      $$JobDescriptionsTableTableManager(
        _db.attachedDatabase,
        _db.jobDescriptions,
      );
}
