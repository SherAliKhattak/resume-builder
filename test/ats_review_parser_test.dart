import 'package:flutter_test/flutter_test.dart';
import 'package:resume_builder/features/job_description/data/ats_review_parser.dart';

void main() {
  test('parses the Gemini review JSON shape', () {
    const raw = '''
{
  "JD Matched Score": "82%",
  "MatchedKeywords": ["Flutter"],
  "MissingKeywords": ["Kubernetes"],
  "Strengths": ["Clear Flutter experience"],
  "Weaknesses": ["No cloud keywords"],
  "AlternativeWords": {"made": "shipped"},
  "Improved Resume": "Jane Doe\\nFlutter engineer",
  "Profile Summary": "Flutter engineer who ships offline apps."
}
''';
    final review = parseAtsReview(raw);
    expect(review, isNotNull);
    expect(review!.score, 82);
    expect(review.matchedKeywords, ['Flutter']);
    expect(review.missingKeywords, ['Kubernetes']);
    expect(review.strengths, ['Clear Flutter experience']);
    expect(review.weaknesses, ['No cloud keywords']);
    expect(review.alternativeWords, {'made': 'shipped'});
    expect(review.profileSummary, 'Flutter engineer who ships offline apps.');
  });

  test('reads JSON hidden in extra model prose', () {
    const raw = '''
Sure. Here you go:
```json
{"score": 71, "MissingKeywords": ["SQL"], "Strengths": ["iOS"]}
```
''';
    final review = parseAtsReview(raw);
    expect(review?.score, 71);
    expect(review?.missingKeywords, ['SQL']);
  });

  test('returns null for empty noise', () {
    expect(parseAtsReview('could not parse'), isNull);
  });
}
