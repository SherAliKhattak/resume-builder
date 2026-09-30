import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app/app.dart';
import 'app/di.dart';
import 'app/router.dart';
import 'features/profile/domain/repositories/resume_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await setupDependencies();
  final settings = await getIt<ResumeRepository>().getSettings();
  runApp(
    ResumeApp(
      router: createRouter(showOnboarding: !settings.hasSeenOnboarding),
    ),
  );
}
