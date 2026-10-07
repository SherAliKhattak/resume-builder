import 'package:flutter_test/flutter_test.dart';
import 'package:resume_builder/core/database/app_database.dart';
import 'package:resume_builder/features/job_description/domain/models/job_description.dart';
import 'package:resume_builder/features/job_description/presentation/cubit/job_description_cubit.dart';
import 'package:resume_builder/features/profile/data/repositories/resume_repository_impl.dart';
import 'support/fake_ats_reviewer.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;
  late ResumeRepositoryImpl repo;
  late FakeAtsReviewer reviewer;
  late JobDescriptionCubit cubit;

  setUp(() {
    db = AppDatabase.forTesting();
    repo = ResumeRepositoryImpl(db);
    reviewer = FakeAtsReviewer();
    cubit = JobDescriptionCubit(repo, reviewer: reviewer);
  });

  tearDown(() async {
    if (!cubit.isClosed) {
      await cubit.close();
    }
    await db.close();
  });

  test('Gemini match results update after a skill is added', () async {
    await repo.saveJobDescription(
      const JobDescription(
        rawText: 'Looking for a Flutter engineer who knows Dart and SQLite.',
      ),
    );
    cubit.start();
    await cubit.stream.firstWhere((state) => state.ready);
    await cubit.analyze();
    expect(cubit.state.aiReview, isNotNull);
    expect(cubit.state.busy, isFalse);
    expect(
      cubit.state.aiReview!.matchedKeywords
          .map((item) => item.toLowerCase())
          .contains('flutter'),
      isFalse,
    );

    final updated = cubit.stream.firstWhere(
      (state) =>
          state.aiReview != null &&
          state.aiReview!.matchedKeywords.any(
            (item) => item.toLowerCase() == 'flutter',
          ),
    );
    final groupId = await repo.addSkillGroup('Skills');
    await repo.addSkill(groupId, 'Flutter');
    await updated;
  });

  test('loads a Gemini review after an explicit analyze', () async {
    reviewer.reviewToReturn = const AtsReview(
      score: 80,
      strengths: ['Ships Flutter apps'],
      matchedKeywords: ['Flutter'],
      missingKeywords: ['Kubernetes'],
      profileSummary: 'Flutter engineer.',
    );
    await repo.saveJobDescription(
      const JobDescription(rawText: 'Need a Flutter engineer.'),
    );
    cubit.start();
    await cubit.stream.firstWhere((state) => state.ready);
    await cubit.analyze();
    expect(cubit.state.aiReview, isNotNull);
    expect(reviewer.reviewCalls, 1);
    expect(cubit.state.aiReview!.score, 80);
    expect(cubit.state.aiReview!.missingKeywords, ['Kubernetes']);
    expect(cubit.state.aiReview!.matchedKeywords, ['Flutter']);
  });
}
