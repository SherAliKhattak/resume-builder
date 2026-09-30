import 'package:flutter_test/flutter_test.dart';
import 'package:resume_builder/core/database/app_database.dart';
import 'package:resume_builder/features/profile/data/repositories/resume_repository_impl.dart';
import 'package:resume_builder/features/profile/presentation/cubit/personal_info_cubit.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;
  late PersonalInfoCubit cubit;

  setUp(() {
    db = AppDatabase.forTesting();
    cubit = PersonalInfoCubit(ResumeRepositoryImpl(db))..start();
  });

  tearDown(() async {
    if (!cubit.isClosed) {
      await cubit.close();
    }
    await db.close();
  });

  test('validates name and email inline', () async {
    cubit.onChanged(cubit.state.info.copyWith(fullName: '', email: 'nope'));
    expect(cubit.state.nameError, isNotNull);
    expect(cubit.state.emailError, isNotNull);

    cubit.onChanged(
      cubit.state.info.copyWith(fullName: 'Ada', email: 'ada@email.com'),
    );
    expect(cubit.state.nameError, isNull);
    expect(cubit.state.emailError, isNull);
  });

  test('autosaves after debounce', () async {
    cubit.onChanged(
      cubit.state.info.copyWith(fullName: 'Ada', email: 'ada@email.com'),
    );
    await Future<void>.delayed(const Duration(milliseconds: 700));
    final saved = await ResumeRepositoryImpl(db).getResume();
    expect(saved.personal.fullName, 'Ada');
    expect(cubit.state.saved, isTrue);
  });

  test('keeps edits when closed before debounce fires', () async {
    cubit.onChanged(
      cubit.state.info.copyWith(fullName: 'Grace', email: 'grace@email.com'),
    );
    await cubit.close();
    final saved = await ResumeRepositoryImpl(db).getResume();
    expect(saved.personal.fullName, 'Grace');
  });
}
