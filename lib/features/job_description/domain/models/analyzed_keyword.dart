enum KeywordCategory { hardSkill, tool, softSkill, certification, other }

enum KeywordImportance { high, medium, low }

enum MatchStrength { strong, weak }

enum ResumeLocation { summary, skills, experience, projects, education, courses }

class AnalyzedKeyword {
  const AnalyzedKeyword({
    required this.term,
    required this.canonical,
    required this.category,
    required this.weight,
    required this.importance,
    this.verified = true,
    this.locations = const [],
    this.strength,
    this.suggestion,
  });

  final String term;
  final String canonical;
  final KeywordCategory category;
  final int weight;
  final KeywordImportance importance;
  final bool verified;
  final List<ResumeLocation> locations;
  final MatchStrength? strength;
  final String? suggestion;

  String get displayTerm => term;
}

class KeywordAnalysis {
  const KeywordAnalysis({
    this.score = 0,
    this.matched = const [],
    this.missing = const [],
    this.matchedKeywords = const [],
    this.missingKeywords = const [],
    this.weakKeywords = const [],
  });

  final double score;
  final List<String> matched;
  final List<String> missing;
  final List<AnalyzedKeyword> matchedKeywords;
  final List<AnalyzedKeyword> missingKeywords;
  final List<AnalyzedKeyword> weakKeywords;

  int get percent => score.round().clamp(0, 100);

  double get matchPercentage => score;

  String get guidanceMessage {
    if (missingKeywords.isEmpty && weakKeywords.isEmpty) {
      return 'Nice — your details already cover this job post.';
    }
    final tips = <String>[
      for (final item in missingKeywords)
        if (item.importance == KeywordImportance.high &&
            item.suggestion != null)
          item.suggestion!,
    ];
    if (weakKeywords.isNotEmpty) {
      final names = [
        for (final item in weakKeywords.take(3)) item.term,
      ].join(', ');
      tips.add(
        '$names ${weakKeywords.length == 1 ? 'is' : 'are'} only in Skills. '
        'Mention ${weakKeywords.length == 1 ? 'it' : 'them'} in an Experience '
        'bullet if you have used ${weakKeywords.length == 1 ? 'it' : 'them'}.',
      );
    }
    if (tips.isEmpty) {
      return 'Skills and projects were reordered by relevance.';
    }
    return tips.take(3).join(' ');
  }

  Map<String, dynamic> toJson() => {
    'score': score,
    'matched': matched,
    'missing': missing,
  };

  factory KeywordAnalysis.fromJson(Map<String, dynamic> json) {
    return KeywordAnalysis(
      score: _readDouble(json['score']),
      matched: _stringList(json['matched']),
      missing: _stringList(json['missing']),
    );
  }

  static double _readDouble(dynamic value) {
    if (value is double) return value;
    if (value is num) return value.toDouble();
    return double.tryParse('$value') ?? 0;
  }

  static List<String> _stringList(dynamic raw) {
    if (raw is List) {
      return raw.map((e) => '$e').where((e) => e.trim().isNotEmpty).toList();
    }
    return const [];
  }
}
