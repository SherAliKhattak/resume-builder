import '../../../profile/domain/models/resume_data.dart';
import '../../../../core/analysis/simple_stemmer.dart';
import '../../../../core/analysis/skill_lexicon.dart';
import '../../../../core/analysis/skills_dictionary.dart';
import '../../../../core/analysis/text_normalizer.dart';
import '../models/analyzed_keyword.dart';

class _JdHit {
  _JdHit({
    required this.key,
    required this.entry,
    required this.verified,
  });

  final String key;
  final SkillEntry? entry;
  final bool verified;
  var count = 0;
  var inTitle = false;
  var inRequired = false;
  var inPreferred = false;
}

class AnalyzeJobKeywords {
  AnalyzeJobKeywords([SkillLexicon? lexicon])
    : lexicon = lexicon ?? SkillLexicon.standard();

  final SkillLexicon lexicon;

  KeywordAnalysis call({
    required String jobDescription,
    required ResumeData resume,
  }) {
    final jd = jobDescription.trim();
    if (jd.isEmpty) return const KeywordAnalysis();

    final hits = _extract(jd);
    if (hits.isEmpty) return const KeywordAnalysis();

    final resumeIndex = _ResumeIndex(resume);
    final matched = <AnalyzedKeyword>[];
    final missing = <AnalyzedKeyword>[];
    final weak = <AnalyzedKeyword>[];
    final ranked = hits.values.toList()
      ..sort((a, b) {
        final byWeight = _weight(b).compareTo(_weight(a));
        if (byWeight != 0) return byWeight;
        return a.key.compareTo(b.key);
      });
    for (final hit in ranked) {
      final analyzed = _toKeyword(hit, resumeIndex);
      if (analyzed.locations.isEmpty) {
        missing.add(analyzed);
        continue;
      }
      matched.add(analyzed);
      if (analyzed.strength == MatchStrength.weak) {
        weak.add(analyzed);
      }
    }

    missing.sort((a, b) {
      final byWeight = b.weight.compareTo(a.weight);
      if (byWeight != 0) return byWeight;
      return a.term.compareTo(b.term);
    });

    final score = _atsScore([...matched, ...missing]);
    return KeywordAnalysis(
      score: score,
      matched: [for (final item in matched) item.term],
      missing: [for (final item in missing) item.term],
      matchedKeywords: matched,
      missingKeywords: missing,
      weakKeywords: weak,
    );
  }

  Map<String, _JdHit> _extract(String jd) {
    final sections = _splitSections(jd);
    final hits = <String, _JdHit>{};

    void add(
      String raw, {
      required bool title,
      required bool required,
      required bool preferred,
      required int amount,
    }) {
      final key = TextNormalizer.normalize(raw);
      if (key.isEmpty || fillerPhrases.contains(key)) return;
      if (stopwords.contains(key)) return;
      if (key.length < 2) return;
      final entry = lexicon.find(key);
      final verified = entry != null;
      if (!verified) {
        final tokens = TextNormalizer.tokens(key);
        if (tokens.isEmpty) return;
        if (tokens.every(stopwords.contains)) return;
        if (tokens.length == 1 && (key.length < 3 || _genericUnigrams.contains(key))) {
          return;
        }
      }
      final hit = hits.putIfAbsent(
        entry?.canonical ?? key,
        () => _JdHit(
          key: entry?.canonical ?? key,
          entry: entry,
          verified: verified,
        ),
      );
      hit.count += amount;
      hit.inTitle = hit.inTitle || title;
      hit.inRequired = hit.inRequired || required;
      hit.inPreferred = hit.inPreferred || preferred;
    }

    for (final section in sections) {
      _collectDictionary(section.text, (term, count) {
        add(
          term,
          title: section.isTitle,
          required: section.isRequired,
          preferred: section.isPreferred,
          amount: count,
        );
      });
      if (section.isTitle) {
        for (final token in TextNormalizer.tokens(section.text)) {
          if (lexicon.find(token) != null) {
            add(
              token,
              title: true,
              required: false,
              preferred: false,
              amount: 0,
            );
          }
        }
      }
    }

    _collectCapitalized(jd, (term) {
      add(term, title: false, required: false, preferred: false, amount: 1);
    });
    _collectRepeated(TextNormalizer.normalize(jd), (term, count) {
      add(term, title: false, required: false, preferred: false, amount: 0);
      final key = lexicon.find(term)?.canonical ?? TextNormalizer.normalize(term);
      final hit = hits[key];
      if (hit != null && count > hit.count) {
        hit.count = count;
      }
    });
    _collectRepeatedPhrases(TextNormalizer.normalize(jd), (term, count) {
      add(term, title: false, required: false, preferred: false, amount: 0);
      final key = lexicon.find(term)?.canonical ?? TextNormalizer.normalize(term);
      final hit = hits[key];
      if (hit != null && count > hit.count) {
        hit.count = count;
      }
    });

    hits.removeWhere((_, hit) {
      if (hit.verified) return false;
      if (hit.inRequired || hit.inTitle) return false;
      return hit.count < 2 || hit.key.length < 4;
    });
    return hits;
  }

  void _collectDictionary(String text, void Function(String term, int count) add) {
    final tokens = TextNormalizer.tokens(text);
    final used = List<bool>.filled(tokens.length, false);
    final counts = <String, int>{};
    for (var i = 0; i < tokens.length; i++) {
      if (used[i]) continue;
      String? found;
      var span = 0;
      for (var n = 3; n >= 1; n--) {
        if (i + n > tokens.length) continue;
        var blocked = false;
        for (var k = 0; k < n; k++) {
          if (used[i + k]) {
            blocked = true;
            break;
          }
        }
        if (blocked) continue;
        final phrase = tokens.sublist(i, i + n).join(' ');
        if (lexicon.find(phrase) == null) continue;
        found = phrase;
        span = n;
        break;
      }
      if (found == null) continue;
      counts[found] = (counts[found] ?? 0) + 1;
      for (var k = 0; k < span; k++) {
        used[i + k] = true;
      }
    }
    for (final entry in counts.entries) {
      add(entry.key, entry.value.clamp(1, 3));
    }
  }

  void _collectCapitalized(String original, void Function(String term) add) {
    final pattern = RegExp(r'\b([A-Z][A-Za-z0-9+#./]*(?:\s+[A-Z][A-Za-z0-9+#./]*){0,2})\b');
    final acronym = RegExp(r'\b([A-Z]{2,10})\b');
    for (final match in [...pattern.allMatches(original), ...acronym.allMatches(original)]) {
      final term = match.group(1)!.trim();
      if (term.length < 2) continue;
      if (stopwords.contains(term.toLowerCase())) continue;
      if (_headingWords.contains(term.toLowerCase())) continue;
      add(term);
    }
  }

  void _collectRepeated(String normalized, void Function(String term, int count) add) {
    final counts = <String, int>{};
    for (final token in TextNormalizer.tokens(normalized)) {
      if (token.length < 4) continue;
      if (stopwords.contains(token)) continue;
      if (fillerPhrases.contains(token)) continue;
      counts[token] = (counts[token] ?? 0) + 1;
    }
    for (final entry in counts.entries) {
      if (entry.value >= 2) add(entry.key, entry.value.clamp(2, 3));
    }
  }

  void _collectRepeatedPhrases(
    String normalized,
    void Function(String term, int count) add,
  ) {
    final tokens = TextNormalizer.tokens(normalized);
    final counts = <String, int>{};
    for (var i = 0; i < tokens.length - 1; i++) {
      if (stopwords.contains(tokens[i]) || stopwords.contains(tokens[i + 1])) {
        continue;
      }
      final phrase = '${tokens[i]} ${tokens[i + 1]}';
      if (fillerPhrases.contains(phrase)) continue;
      counts[phrase] = (counts[phrase] ?? 0) + 1;
      if (i < tokens.length - 2 && !stopwords.contains(tokens[i + 2])) {
        final triple = '$phrase ${tokens[i + 2]}';
        if (!fillerPhrases.contains(triple)) {
          counts[triple] = (counts[triple] ?? 0) + 1;
        }
      }
    }
    for (final entry in counts.entries) {
      if (entry.value >= 2) add(entry.key, entry.value.clamp(2, 3));
    }
  }

  AnalyzedKeyword _toKeyword(_JdHit hit, _ResumeIndex resume) {
    final weight = _weight(hit);
    final importance = weight >= 5
        ? KeywordImportance.high
        : weight >= 3
        ? KeywordImportance.medium
        : KeywordImportance.low;
    final category = hit.entry?.category ?? KeywordCategory.other;
    final term = hit.entry?.term ?? _display(hit.key);
    final locations = resume.locationsFor(hit);
    final strength = locations.isEmpty
        ? null
        : (locations.contains(ResumeLocation.experience) ||
              locations.contains(ResumeLocation.projects))
        ? MatchStrength.strong
        : locations.length == 1 && locations.first == ResumeLocation.skills
        ? MatchStrength.weak
        : MatchStrength.strong;
    return AnalyzedKeyword(
      term: term,
      canonical: hit.key,
      category: category,
      weight: weight,
      importance: importance,
      verified: hit.verified,
      locations: locations,
      strength: strength,
      suggestion: locations.isEmpty && importance == KeywordImportance.high
          ? _tip(term, category)
          : null,
    );
  }

  int _weight(_JdHit hit) {
    var weight = 0;
    if (hit.inRequired) weight += 3;
    if (hit.inTitle || hit.count >= 2) weight += 2;
    if (hit.inPreferred) weight += 1;
    if (weight == 0) weight = 1;
    return weight.clamp(1, 6);
  }

  double _atsScore(List<AnalyzedKeyword> keywords) {
    final scored = [
      for (final item in keywords)
        if (item.verified) item,
    ];
    if (scored.isEmpty) return 0;

    final core = [
      for (final item in scored)
        if (_isCore(item)) item,
    ];
    final rest = [
      for (final item in scored)
        if (!_isCore(item)) item,
    ];
    final coreRate = core.isEmpty
        ? _coverage(rest, scored)
        : _coverage(core, scored);
    if (core.isNotEmpty && coreRate < 0.15) {
      return (100 * coreRate).clamp(0, 24);
    }

    final restRate = core.isEmpty || rest.isEmpty
        ? 0.0
        : _coverage(rest, scored);
    var score = 55 + 32 * coreRate + 14 * restRate;
    final backedByWork = scored.any(
      (item) =>
          item.locations.contains(ResumeLocation.experience) ||
          item.locations.contains(ResumeLocation.projects),
    );
    if (backedByWork && coreRate >= 0.35) {
      score += 5;
    }
    if (coreRate >= 0.99 && restRate >= 0.99) score = 96;
    if (rest.isEmpty && coreRate >= 0.99) score = 94;
    return score.clamp(0, 96);
  }

  bool _isCore(AnalyzedKeyword item) {
    if (item.category == KeywordCategory.softSkill) return false;
    if (item.category == KeywordCategory.certification) return false;
    return item.importance != KeywordImportance.low;
  }

  double _coverage(List<AnalyzedKeyword> items, List<AnalyzedKeyword> all) {
    if (items.isEmpty) return 0;
    var earned = 0.0;
    for (final item in items) {
      if (item.locations.isNotEmpty) {
        earned += item.strength == MatchStrength.weak ? 0.97 : 1.0;
      } else {
        earned += _relatedCredit(item, all);
      }
    }
    return (earned / items.length).clamp(0, 1);
  }

  double _relatedCredit(AnalyzedKeyword missing, List<AnalyzedKeyword> all) {
    final present = {
      for (final item in all)
        if (item.locations.isNotEmpty) item.canonical,
    };
    if (present.isEmpty) return 0;
    for (final family in _relatedFamilies) {
      if (family.contains(missing.canonical) &&
          family.any(present.contains)) {
        return 0.70;
      }
    }
    if ((missing.canonical == 'ios' || missing.canonical == 'android') &&
        present.contains('flutter')) {
      return 0.80;
    }
    if (missing.canonical == 'dart' && present.contains('flutter')) {
      return 0.8;
    }
    if (missing.canonical == 'git' &&
        (present.contains('ci/cd') || present.contains('flutter'))) {
      return 0.58;
    }
    if (missing.canonical == 'state management' &&
        (present.contains('flutter') ||
            present.contains('bloc') ||
            present.contains('provider') ||
            present.contains('riverpod'))) {
      return 0.7;
    }
    return 0;
  }

  String _tip(String term, KeywordCategory category) {
    switch (category) {
      case KeywordCategory.certification:
        return 'Add $term under Courses if you hold this credential.';
      case KeywordCategory.softSkill:
        return 'Add $term to Skills if you have this experience.';
      case KeywordCategory.hardSkill:
      case KeywordCategory.tool:
      case KeywordCategory.other:
        return 'Mention $term in an Experience bullet if you have used it.';
    }
  }

  List<_JdSection> _splitSections(String jd) {
    final lines = jd.split(RegExp(r'\r?\n'));
    final sections = <_JdSection>[];
    var current = _SectionKind.body;
    final buffer = StringBuffer();

    void flush() {
      final text = buffer.toString().trim();
      if (text.isNotEmpty) {
        sections.add(_JdSection(current, text));
      }
      buffer.clear();
    }

    String? first;
    for (final line in lines) {
      if (line.trim().isNotEmpty) {
        first = line;
        break;
      }
    }
    if (first != null && first.trim().length <= 80 && !_isHeading(first)) {
      sections.add(_JdSection(_SectionKind.title, first.trim()));
    }

    for (final line in lines) {
      final heading = _headingKind(line);
      if (heading != null) {
        flush();
        current = heading;
        continue;
      }
      if (buffer.isNotEmpty) buffer.writeln();
      buffer.write(line);
    }
    flush();
    if (sections.isEmpty) {
      sections.add(_JdSection(_SectionKind.body, jd));
    }
    return sections;
  }

  bool _isHeading(String line) => _headingKind(line) != null;

  _SectionKind? _headingKind(String line) {
    final trimmed = line.trim().toLowerCase().replaceAll(RegExp(r'[:\s]+$'), '');
    if (trimmed.isEmpty || trimmed.length > 48) return null;
    if (_requiredHeadings.contains(trimmed) ||
        trimmed.startsWith('must have') ||
        trimmed.startsWith('requirement') ||
        trimmed.startsWith('qualification') ||
        trimmed.startsWith('what you') ||
        trimmed.startsWith('you will need')) {
      return _SectionKind.required;
    }
    if (_preferredHeadings.contains(trimmed) ||
        trimmed.startsWith('nice to have') ||
        trimmed.startsWith('preferred') ||
        trimmed.startsWith('bonus') ||
        trimmed.startsWith('plus')) {
      return _SectionKind.preferred;
    }
    if (trimmed.startsWith('job title') || trimmed.startsWith('position')) {
      return _SectionKind.title;
    }
    return null;
  }

  String _display(String keyword) {
    return keyword
        .split(' ')
        .map((part) {
          if (part.contains('.') || part.contains('#') || part.contains('+') || part.contains('/')) {
            return part;
          }
          if (part.length <= 3) return part.toUpperCase();
          return '${part[0].toUpperCase()}${part.substring(1)}';
        })
        .join(' ');
  }
}

enum _SectionKind { title, required, preferred, body }

class _JdSection {
  const _JdSection(this.kind, this.text);

  final _SectionKind kind;
  final String text;

  bool get isTitle => kind == _SectionKind.title;
  bool get isRequired => kind == _SectionKind.required;
  bool get isPreferred => kind == _SectionKind.preferred;
}

class _ResumeIndex {
  _ResumeIndex(ResumeData resume)
    : texts = {
        ResumeLocation.summary: TextNormalizer.normalize(resume.summary),
        ResumeLocation.skills: TextNormalizer.normalize([
          for (final group in resume.skillGroups) ...[
            group.name,
            for (final skill in group.skills) skill.name,
          ],
        ].join(' ')),
        ResumeLocation.experience: TextNormalizer.normalize([
          for (final item in resume.experiences) ...[
            item.role,
            item.company,
            ...item.bullets,
          ],
        ].join(' ')),
        ResumeLocation.projects: TextNormalizer.normalize([
          for (final item in resume.projects) ...[
            item.name,
            item.description,
            item.techStack,
            ...item.bullets,
          ],
        ].join(' ')),
        ResumeLocation.education: TextNormalizer.normalize([
          for (final item in resume.educations) ...[
            item.school,
            item.degree,
            item.field,
            item.details,
          ],
        ].join(' ')),
        ResumeLocation.courses: TextNormalizer.normalize([
          for (final item in resume.courses) ...[item.name, item.issuer],
        ].join(' ')),
      } {
    stems = {
      for (final entry in texts.entries)
        entry.key: {
          for (final token in TextNormalizer.tokens(entry.value))
            ...SimpleStemmer.variants(token),
        },
    };
  }

  final Map<ResumeLocation, String> texts;
  late final Map<ResumeLocation, Set<String>> stems;

  List<ResumeLocation> locationsFor(_JdHit hit) {
    final found = <ResumeLocation>[];
    for (final location in ResumeLocation.values) {
      if (_matches(texts[location]!, stems[location]!, hit)) {
        found.add(location);
      }
    }
    return found;
  }

  bool _matches(String haystack, Set<String> hayStems, _JdHit hit) {
    if (haystack.isEmpty) return false;
    final candidates = <String>{
      hit.key,
      if (hit.entry != null) hit.entry!.canonical,
      if (hit.entry != null)
        for (final synonym in hit.entry!.synonyms)
          TextNormalizer.normalize(synonym),
    };
    for (final candidate in candidates) {
      if (candidate.isEmpty) continue;
      if (_contains(haystack, candidate)) return true;
    }
    final tokens = [
      for (final token in TextNormalizer.tokens(hit.key))
        if (token.length > 2) token,
    ];
    if (tokens.isEmpty) return false;
    return tokens.every((token) {
      return SimpleStemmer.variants(token).any(hayStems.contains);
    });
  }

  bool _contains(String haystack, String needle) {
    if (needle.contains(' ') || needle.contains(RegExp(r'[+#./]'))) {
      return haystack.contains(needle);
    }
    return RegExp('\\b${RegExp.escape(needle)}\\b').hasMatch(haystack);
  }
}

const _requiredHeadings = {
  'requirements',
  'must have',
  'must-have',
  'qualifications',
  'required',
  'required skills',
  'required qualifications',
  'what you need',
  'what we need',
  'minimum qualifications',
};

const _preferredHeadings = {
  'nice to have',
  'nice-to-have',
  'preferred',
  'preferred qualifications',
  'bonus',
  'bonus points',
  'plus',
};

const _headingWords = {
  'requirements',
  'qualifications',
  'responsibilities',
  'about',
  'benefits',
  'preferred',
};

const _relatedFamilies = <Set<String>>[
  {'bloc', 'provider', 'riverpod', 'redux', 'state management'},
  {'flutter', 'ios', 'android', 'react native', 'dart'},
  {'javascript', 'typescript', 'node.js', 'react'},
  {'ci/cd', 'git', 'devops'},
  {'aws', 'gcp', 'azure'},
  {'sql', 'postgresql', 'mysql', 'sqlite'},
  {'tableau', 'power bi', 'looker', 'excel'},
  {'seo', 'content strategy', 'content marketing', 'copywriting'},
  {'google analytics', 'hubspot', 'salesforce', 'crm'},
];

const _genericUnigrams = {
  'data',
  'software',
  'engineer',
  'developer',
  'manager',
  'analyst',
  'designer',
  'senior',
  'junior',
  'staff',
  'principal',
  'application',
  'applications',
  'platform',
  'systems',
  'system',
  'services',
  'service',
  'business',
  'customer',
  'customers',
  'users',
  'user',
  'mobile',
  'web',
};
