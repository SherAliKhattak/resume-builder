import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:resume_builder/app/app.dart';
import 'package:resume_builder/app/di.dart';
import 'package:resume_builder/app/router.dart';
import 'package:resume_builder/app/widgets/app_text_field.dart';
import 'package:resume_builder/core/database/app_database.dart';
import 'package:resume_builder/features/profile/domain/repositories/resume_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('saving education after the sheet closes does not assert', (
    tester,
  ) async {
    await setupDependencies(database: AppDatabase.forTesting());
    final repo = getIt<ResumeRepository>();
    final settings = await repo.getSettings();
    await repo.saveSettings(settings.copyWith(hasSeenOnboarding: true));

    final router = createRouter(showOnboarding: false);
    await tester.pumpWidget(ResumeApp(router: router));
    await tester.pump();
    router.go('/profile/education');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('Add school'), findsOneWidget);
    await tester.tap(find.text('Add school'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    await tester.enterText(
      find.descendant(
        of: find.widgetWithText(AppTextField, 'School'),
        matching: find.byType(TextFormField),
      ),
      'University of Texas',
    );
    await tester.tap(find.text('Done'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('University of Texas'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 1));
    await getIt<AppDatabase>().close();
    await tester.pump(const Duration(milliseconds: 1));
    await getIt.reset();
  });
}
