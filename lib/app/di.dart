import 'package:get_it/get_it.dart';

import '../core/analysis/keyword_analyzer.dart';
import '../core/backup/backup_service.dart';
import '../core/database/app_database.dart';
import '../core/import/resume_import_service.dart';
import '../features/profile/data/repositories/resume_repository_impl.dart';
import '../features/profile/domain/repositories/resume_repository.dart';
import '../features/templates/domain/template_registry.dart';
import '../features/templates/pdf/pdf_raster_service.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies({AppDatabase? database}) async {
  if (getIt.isRegistered<AppDatabase>()) {
    await getIt.reset();
  }

  final db = database ?? AppDatabase();
  getIt
    ..registerSingleton<AppDatabase>(db)
    ..registerSingleton<ResumeRepository>(ResumeRepositoryImpl(db))
    ..registerSingleton<BackupService>(BackupService(getIt()))
    ..registerSingleton<ResumeImportService>(ResumeImportService(getIt()))
    ..registerSingleton<KeywordAnalyzer>(KeywordAnalyzer())
    ..registerSingleton<TemplateRegistry>(TemplateRegistry.standard())
    ..registerSingleton<PdfRasterService>(PdfRasterService());
}
