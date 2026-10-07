import 'package:get_it/get_it.dart';

import '../core/analysis/keyword_analyzer.dart';
import '../core/backup/backup_service.dart';
import '../core/database/app_database.dart';
import '../core/import/resume_import_service.dart';
import '../features/ads/ads_service.dart';
import '../features/job_description/data/gemini_ats_reviewer.dart';
import '../features/job_description/domain/ats_reviewer.dart';
import '../features/profile/data/repositories/resume_repository_impl.dart';
import '../features/profile/domain/repositories/resume_repository.dart';
import '../features/templates/domain/template_registry.dart';
import '../features/templates/pdf/pdf_raster_service.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies({
  AppDatabase? database,
  AdsService? ads,
}) async {
  if (getIt.isRegistered<AppDatabase>()) {
    await getIt.reset();
  }

  final db = database ?? AppDatabase();
  getIt
    ..registerSingleton<AppDatabase>(
      db,
      dispose: (database) async {
        try {
          await database.close();
        } catch (_) {}
      },
    )
    ..registerSingleton<ResumeRepository>(ResumeRepositoryImpl(db))
    ..registerSingleton<BackupService>(BackupService(getIt()))
    ..registerSingleton<ResumeImportService>(ResumeImportService(getIt()))
    ..registerSingleton<KeywordAnalyzer>(KeywordAnalyzer())
    ..registerSingleton<AtsReviewer>(GeminiAtsReviewer())
    ..registerSingleton<TemplateRegistry>(TemplateRegistry.standard())
    ..registerSingleton<PdfRasterService>(PdfRasterService())
    ..registerSingleton<AdsService>(ads ?? const NoOpAdsService());
}
