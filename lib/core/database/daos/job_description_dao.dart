import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables.dart';

part 'job_description_dao.g.dart';

@DriftAccessor(tables: [JobDescriptions])
class JobDescriptionDao extends DatabaseAccessor<AppDatabase>
    with _$JobDescriptionDaoMixin {
  JobDescriptionDao(super.db);

  Stream<JobDescriptionRow?> watchLatest() {
    return (select(jobDescriptions)
          ..orderBy([
            (t) => OrderingTerm.desc(t.id),
          ])
          ..limit(1))
        .watchSingleOrNull();
  }

  Future<JobDescriptionRow?> getLatest() {
    return (select(jobDescriptions)
          ..orderBy([
            (t) => OrderingTerm.desc(t.id),
          ])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<void> upsertLatest(JobDescriptionsCompanion data) async {
    final existing = await getLatest();
    if (existing == null) {
      await into(jobDescriptions).insert(data);
    } else {
      await (update(jobDescriptions)..where((t) => t.id.equals(existing.id)))
          .write(data);
    }
  }

  Future<void> clear() => delete(jobDescriptions).go();
}
