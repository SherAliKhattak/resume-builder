import 'dart:convert';

import '../domain/models/ats_review.dart';

AtsReview? parseAtsReview(String raw) {
  final object = _extractJson(raw);
  if (object == null) return null;

  final score = _readScore(object['JD Matched Score'] ?? object['score']);
  final matched = _stringList(
    object['MatchedKeywords'] ?? object['matchedKeywords'],
  );
  final missing = _stringList(
    object['MissingKeywords'] ?? object['missingKeywords'],
  );
  final strengths = _stringList(object['Strengths'] ?? object['strengths']);
  final weaknesses = _stringList(object['Weaknesses'] ?? object['weaknesses']);
  final alternatives = _stringMap(
    object['AlternativeWords'] ?? object['alternativeWords'],
  );
  final improved = _readString(
    object['Improved Resume'] ?? object['improvedResume'],
  );
  final summary = _readString(
    object['Profile Summary'] ?? object['profileSummary'],
  );

  final review = AtsReview(
    score: score,
    matchedKeywords: matched,
    missingKeywords: missing,
    strengths: strengths,
    weaknesses: weaknesses,
    alternativeWords: alternatives,
    improvedResume: improved,
    profileSummary: summary,
  );
  if (review.isEmpty && score == 0) return null;
  return review;
}

Map<String, dynamic>? _extractJson(String raw) {
  final trimmed = raw.trim();
  if (trimmed.isEmpty) return null;
  final direct = _tryDecode(trimmed);
  if (direct != null) return direct;

  final fenced = RegExp(r'```(?:json)?\s*([\s\S]*?)```').firstMatch(trimmed);
  if (fenced != null) {
    final decoded = _tryDecode(fenced.group(1)!.trim());
    if (decoded != null) return decoded;
  }

  final start = trimmed.indexOf('{');
  final end = trimmed.lastIndexOf('}');
  if (start >= 0 && end > start) {
    return _tryDecode(trimmed.substring(start, end + 1));
  }
  return null;
}

Map<String, dynamic>? _tryDecode(String raw) {
  try {
    final decoded = jsonDecode(raw);
    if (decoded is Map<String, dynamic>) return decoded;
    if (decoded is Map) {
      return decoded.map((key, value) => MapEntry('$key', value));
    }
  } catch (_) {}
  return null;
}

int _readScore(dynamic raw) {
  if (raw is num) return raw.round().clamp(0, 100);
  final match = RegExp(r'\d+').firstMatch('$raw');
  if (match == null) return 0;
  return (int.tryParse(match.group(0)!) ?? 0).clamp(0, 100);
}

List<String> _stringList(dynamic raw) {
  if (raw is! List) return const [];
  return [
    for (final item in raw)
      if ('$item'.trim().isNotEmpty) '$item'.trim(),
  ];
}

Map<String, String> _stringMap(dynamic raw) {
  if (raw is! Map) return const {};
  return {
    for (final entry in raw.entries)
      if ('${entry.key}'.trim().isNotEmpty && '${entry.value}'.trim().isNotEmpty)
        '${entry.key}'.trim(): '${entry.value}'.trim(),
  };
}

String? _readString(dynamic raw) {
  if (raw == null) return null;
  final value = '$raw'.trim();
  if (value.isEmpty || value.toUpperCase() == 'N/A') return null;
  return value;
}
