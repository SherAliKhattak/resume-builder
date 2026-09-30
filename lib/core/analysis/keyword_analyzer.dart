import '../../features/job_description/domain/models/job_description.dart';
import '../../features/profile/domain/models/resume_data.dart';
import 'skills_dictionary.dart';

class KeywordAnalyzer {
  KeywordAnalyzer({Set<String>? dictionary})
    : dictionary = {
        for (final skill in (dictionary ?? builtInSkills)) skill.toLowerCase(),
      };

  final Set<String> dictionary;

  KeywordAnalysis analyze({
    required String jobDescription,
    required ResumeData resume,
  }) {
    final jdKeywords = _extractRankedKeywords(jobDescription);
    if (jdKeywords.isEmpty) {
      return const KeywordAnalysis();
    }

    final resumeText = resume.allText.toLowerCase();
    final matched = <String>[];
    final missing = <String>[];

    for (final keyword in jdKeywords) {
      if (_resumeContains(resumeText, keyword)) {
        matched.add(_display(keyword));
      } else {
        missing.add(_display(keyword));
      }
    }

    final score = (matched.length / jdKeywords.length) * 100;
    return KeywordAnalysis(
      score: score,
      matched: matched.take(20).toList(),
      missing: missing.take(20).toList(),
    );
  }

  List<String> _extractRankedKeywords(String text) {
    final lower = text.toLowerCase();
    final counts = <String, int>{};

    final phrases = dictionary.toList()
      ..sort((a, b) => b.length.compareTo(a.length));

    var remaining = lower;
    for (final phrase in phrases) {
      if (phrase.length < 2) continue;
      final matches = _countOccurrences(remaining, phrase);
      if (matches > 0) {
        counts[phrase] = (counts[phrase] ?? 0) + matches;
        remaining = remaining.replaceAll(phrase, ' ');
      }
    }

    final tokenPattern = RegExp(r"[a-z0-9][a-z0-9+#.]{1,}");
    for (final match in tokenPattern.allMatches(remaining)) {
      final token = match.group(0)!;
      if (stopwords.contains(token)) continue;
      if (token.length < 3) continue;
      if (dictionary.contains(token)) {
        counts[token] = (counts[token] ?? 0) + 1;
      }
    }

    final ranked = counts.entries.toList()
      ..sort((a, b) {
        final byCount = b.value.compareTo(a.value);
        if (byCount != 0) return byCount;
        return a.key.compareTo(b.key);
      });

    return [for (final entry in ranked) entry.key];
  }

  int _countOccurrences(String haystack, String needle) {
    if (needle.contains(' ') || needle.contains('.') || needle.contains('#')) {
      var count = 0;
      var start = 0;
      while (true) {
        final index = haystack.indexOf(needle, start);
        if (index < 0) break;
        count++;
        start = index + needle.length;
      }
      return count;
    }

    final pattern = RegExp('\\b${RegExp.escape(needle)}\\b');
    return pattern.allMatches(haystack).length;
  }

  bool _resumeContains(String resumeText, String keyword) {
    if (keyword.contains(' ')) {
      return resumeText.contains(keyword);
    }
    return RegExp('\\b${RegExp.escape(keyword)}\\b').hasMatch(resumeText);
  }

  String _display(String keyword) {
    return keyword
        .split(' ')
        .map((part) {
          if (part.contains('.') || part.contains('#') || part.contains('+')) {
            return part;
          }
          if (part.length <= 3) return part.toUpperCase();
          return '${part[0].toUpperCase()}${part.substring(1)}';
        })
        .join(' ');
  }
}
