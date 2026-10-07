import 'package:resume_builder/features/job_description/domain/ats_reviewer.dart';
import 'package:resume_builder/features/job_description/domain/models/ats_review.dart';

class FakeAtsReviewer implements AtsReviewer {
  FakeAtsReviewer({this.reviewToReturn});

  AtsReview? reviewToReturn;
  var reviewCalls = 0;

  @override
  Future<AtsReview?> review({
    required String jobDescription,
    required String resumeText,
  }) async {
    reviewCalls += 1;
    if (reviewToReturn != null) return reviewToReturn;
    final hasFlutter = resumeText.toLowerCase().contains('flutter');
    return AtsReview(
      score: hasFlutter ? 82 : 60,
      matchedKeywords: [if (hasFlutter) 'Flutter'],
      missingKeywords: [
        if (!hasFlutter) 'Flutter',
        'Kubernetes',
      ],
      strengths: ['Clear written review'],
    );
  }
}
