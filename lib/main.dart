import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/app.dart';
import 'app/app_bloc_observer.dart';
import 'app/di.dart';
import 'app/router.dart';
import 'app/startup_error_app.dart';
import 'core/errors/error_logger.dart';
import 'features/ads/ads_service.dart';
import 'features/profile/domain/repositories/resume_repository.dart';

Future<void> main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    FlutterError.onError = (details) {
      FlutterError.presentError(details);
      logAppError('Flutter', details.exception, details.stack);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      logAppError('Platform', error, stack);
      return true;
    };
    Bloc.observer = AppBlocObserver();
    await _startApp();
  }, (error, stack) {
    logAppError('Zone', error, stack);
  });
}

Future<void> _startApp() async {
  try {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    final ads = createAdsService();
    await setupDependencies(ads: ads);
    try {
      await ads.initialize();
    } catch (error, stack) {
      logAppError('Ads.initialize', error, stack);
    }
    final settings = await getIt<ResumeRepository>().getSettings();
    runApp(
      ResumeApp(
        router: createRouter(showOnboarding: !settings.hasSeenOnboarding),
      ),
    );
  } catch (error, stack) {
    logAppError('Startup', error, stack);
    runApp(StartupErrorApp(onRetry: _startApp));
  }
}
