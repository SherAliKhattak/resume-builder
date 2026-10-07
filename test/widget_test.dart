import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:resume_builder/app/app.dart';
import 'package:resume_builder/app/di.dart';
import 'package:resume_builder/app/router.dart';
import 'package:resume_builder/core/database/app_database.dart';
import 'package:resume_builder/features/profile/domain/repositories/resume_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Home shows Build Resume', (tester) async {
    await setupDependencies(database: AppDatabase.forTesting());
    final repo = getIt<ResumeRepository>();
    final settings = await repo.getSettings();
    await repo.saveSettings(settings.copyWith(hasSeenOnboarding: true));

    await tester.pumpWidget(
      ResumeApp(router: createRouter(showOnboarding: false)),
    );
    await tester.pump();
    expect(find.text('Build Resume'), findsOneWidget);
    expect(find.text('Create resume'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 1));
    await getIt<AppDatabase>().close();
    await tester.pump(const Duration(milliseconds: 1));
    await getIt.reset();
  });
}
