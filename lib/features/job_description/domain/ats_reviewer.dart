import 'models/ats_review.dart';

abstract class AtsReviewer {
  Future<AtsReview?> review({
    required String jobDescription,
    required String resumeText,
  });
}

class NoOpAtsReviewer implements AtsReviewer {
  const NoOpAtsReviewer();

  @override
  Future<AtsReview?> review({
    required String jobDescription,
    required String resumeText,
  }) async {
    return null;
  }
}
