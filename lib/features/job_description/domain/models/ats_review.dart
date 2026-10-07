class AtsReview {
  const AtsReview({
    this.score = 0,
    this.matchedKeywords = const [],
    this.missingKeywords = const [],
    this.strengths = const [],
    this.weaknesses = const [],
    this.alternativeWords = const {},
    this.improvedResume,
    this.profileSummary,
  });

  final int score;
  final List<String> matchedKeywords;
  final List<String> strengths;
  final List<String> weaknesses;
  final List<String> missingKeywords;
  final Map<String, String> alternativeWords;
  final String? improvedResume;
  final String? profileSummary;

  bool get isEmpty =>
      matchedKeywords.isEmpty &&
      strengths.isEmpty &&
      weaknesses.isEmpty &&
      missingKeywords.isEmpty &&
      alternativeWords.isEmpty &&
      (profileSummary == null || profileSummary!.trim().isEmpty);
}
