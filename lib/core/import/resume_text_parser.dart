import '../../features/profile/domain/models/profile_models.dart';
import '../../features/profile/domain/models/resume_data.dart';
import '../analysis/skills_dictionary.dart';

class ResumeTextParser {
  static ResumeData parse(String raw) {
    final text = _normalize(raw);
    if (text.trim().length < 20) {
      throw const FormatException('Could not read enough text from that file.');
    }

    final sections = _splitSections(text);
    final header = sections['header'] ?? text;
    final personal = _personal(header, text);
    final summary = _summary(sections, header);
    final experiences = _experiences(sections['experience'] ?? '');
    final educations = _educations(sections['education'] ?? '');
    final skills = _skills(sections['skills'] ?? '', text);
    final projects = _projects(sections['projects'] ?? '');
    final languages = _languages(sections['languages'] ?? '');
    final awards = _awards(sections['awards'] ?? '');
    final courses = _courses(sections['courses'] ?? '');

    return ResumeData(
      personal: personal,
      summary: summary,
      experiences: experiences,
      educations: educations,
      skillGroups: skills,
      projects: projects,
      languages: languages,
      awards: awards,
      courses: courses,
    );
  }

  static String _normalize(String raw) {
    var text = raw
        .replaceAll('\r\n', '\n')
        .replaceAll('\r', '\n')
        .replaceAll('\u00b7', '|')
        .replaceAll('\u2022', '-')
        .replaceAll('\u2013', '-')
        .replaceAll('\u2014', '-')
        .replaceAll('\u00a0', ' ')
        .replaceAll(RegExp(r'[ \t]+\n'), '\n')
        .replaceAll(RegExp(r'\n{3,}'), '\n\n')
        .trim();
    text = _insertSectionBreaks(text);
    text = _insertDateBreaks(text);
    text = _insertJobBreaks(text);
    return text.replaceAll(RegExp(r'\n{3,}'), '\n\n').trim();
  }

  static const _headerNames = [
    'courses and certifications',
    'professional experience',
    'employment history',
    'professional summary',
    'academic background',
    'personal projects',
    'technical skills',
    'work experience',
    'career summary',
    'work history',
    'core skills',
    'about me',
    'certifications',
    'certificates',
    'competencies',
    'achievements',
    'experience',
    'education',
    'objective',
    'languages',
    'projects',
    'summary',
    'profile',
    'contact',
    'courses',
    'awards',
    'honors',
    'skills',
  ];

  static final _headerPattern = RegExp(
    '^(${_headerNames.join('|')})\\s*:?\\s*\$',
    caseSensitive: false,
  );

  static final _headerPrefix = RegExp(
    '^(${_headerNames.join('|')})\\s*:?\\s+',
    caseSensitive: false,
  );

  static String _insertSectionBreaks(String text) {
    final pattern = RegExp(
      '(${_headerNames.join('|')})\\s*:?',
      caseSensitive: false,
    );
    final buffer = StringBuffer();
    var cursor = 0;
    for (final match in pattern.allMatches(text)) {
      if (_isFalsePositiveHeader(text, match)) {
        continue;
      }
      buffer.write(text.substring(cursor, match.start).trimRight());
      buffer.write('\n${match.group(1)!.toUpperCase()}\n');
      cursor = match.end;
      while (cursor < text.length && (text[cursor] == ' ' || text[cursor] == '\t')) {
        cursor++;
      }
    }
    buffer.write(text.substring(cursor));
    return buffer.toString();
  }

  static bool _isFalsePositiveHeader(String text, RegExpMatch match) {
    final raw = match.group(1)!;
    final header = raw.toLowerCase();
    final before = text.substring((match.start - 24).clamp(0, match.start), match.start).toLowerCase();
    final after = text
        .substring(match.end, (match.end + 32).clamp(match.end, text.length))
        .trimLeft()
        .toLowerCase();
    final shouted = raw.toUpperCase() == raw && raw.length >= 5;
    final atLineStart = match.start == 0 || text[match.start - 1] == '\n';

    if (header == 'experience') {
      if (RegExp(r'\b(of|years?|yrs?)\s*$').hasMatch(before.trimRight())) return true;
      if (RegExp(r'^(in|with|as|for|working|using|across)\b').hasMatch(after)) return true;
    }
    if (header == 'summary' && RegExp(r'^(of|and)\b').hasMatch(after)) return true;
    if (header == 'education' && RegExp(r'^(in|and)\b').hasMatch(after)) return true;
    if (header == 'skills' && RegExp(r'^(in|and|to|for|with)\b').hasMatch(after)) return true;
    if (header == 'contact' && RegExp(r'^(me|us)\b').hasMatch(after)) return true;
    if (header == 'profile' && RegExp(r'^(of|and|picture|photo)\b').hasMatch(after)) {
      return true;
    }
    if (header == 'projects' && RegExp(r'^(and|to|for|with)\b').hasMatch(after)) return true;
    if (shouted || atLineStart || _looksLikeBoundary(before)) return false;
    return !RegExp(r'^[A-Z]').hasMatch(raw);
  }

  static bool _looksLikeBoundary(String before) {
    final trimmed = before.trimRight();
    return trimmed.endsWith('.') ||
        trimmed.endsWith('!') ||
        trimmed.endsWith('?') ||
        trimmed.endsWith(':') ||
        trimmed.endsWith('|') ||
        trimmed.endsWith('\n');
  }

  static String _insertDateBreaks(String text) {
    final month =
        r'(?:Jan(?:uary)?|Feb(?:ruary)?|Mar(?:ch)?|Apr(?:il)?|May|Jun(?:e)?|Jul(?:y)?|Aug(?:ust)?|Sep(?:tember)?|Oct(?:ober)?|Nov(?:ember)?|Dec(?:ember)?)';
    text = text.replaceAllMapped(
      RegExp('($month)\\.? ((?:19|20)\\d{2})', caseSensitive: false),
      (match) => '${match.group(1)}\u0001${match.group(2)}',
    );
    final beforeMonth = RegExp(
      '(?<=\\S)\\s+(?=($month)\u0001(?:19|20)\\d{2}\\b)',
      caseSensitive: false,
    );
    text = text.replaceAll(beforeMonth, '\n');
    final yearRange = RegExp(
      r'(?<=\S)\s+(?=(?:19|20)\d{2}\s*-\s*(?:(?:19|20)\d{2}|Present|Current|Now)\b)',
      caseSensitive: false,
    );
    text = text.replaceAll(yearRange, '\n');
    final slash = RegExp(
      r'(?<=\S)\s+(?=\d{1,2}/(?:19|20)\d{2}\s*-)',
    );
    text = text.replaceAll(slash, '\n');
    text = text.replaceAll('\u0001', ' ');
    final after = RegExp(
      '($month\\.?\\s+(?:19|20)\\d{2}\\s*-\\s*(?:$month\\.?\\s+)?(?:(?:19|20)\\d{2}|Present|Current|Now))\\s+',
      caseSensitive: false,
    );
    return text.replaceAllMapped(after, (match) => '${match.group(1)}\n');
  }

  static String _insertJobBreaks(String text) {
    const titles =
        r'(?:Senior|Junior|Staff|Lead|Principal|Software|Product|Frontend|Backend|Full[ -]?Stack|Marketing|Data|Mobile)\s+'
        r'(?:Product\s+)?(?:Engineer|Developer|Manager|Designer|Analyst|Scientist|Consultant|Specialist|Architect)';
    return text.replaceAll(
      RegExp('(?<=[.!?])\\s+(?=$titles)', caseSensitive: false),
      '\n',
    );
  }

  static Map<String, String> _splitSections(String text) {
    final lines = text.split('\n');
    final buckets = <String, StringBuffer>{
      'header': StringBuffer(),
    };
    var current = 'header';
    for (final rawLine in lines) {
      final line = rawLine.trim();
      final prefix = _headerPrefix.firstMatch(line);
      if (prefix != null && line.length > prefix.group(1)!.length + 2) {
        current = _keyFromHeader(prefix.group(1)!);
        buckets.putIfAbsent(current, StringBuffer.new);
        buckets[current]!.writeln(line.substring(prefix.end).trim());
        continue;
      }
      final key = _sectionKey(line);
      if (key != null) {
        current = key;
        buckets.putIfAbsent(current, StringBuffer.new);
        continue;
      }
      buckets.putIfAbsent(current, StringBuffer.new);
      buckets[current]!.writeln(rawLine);
    }
    return {
      for (final entry in buckets.entries) entry.key: entry.value.toString().trim(),
    };
  }

  static String? _sectionKey(String line) {
    if (!_headerPattern.hasMatch(line)) return null;
    return _keyFromHeader(line);
  }

  static String _keyFromHeader(String line) {
    final lower = line.toLowerCase();
    if (lower.contains('summary') ||
        lower.contains('profile') ||
        lower.contains('objective') ||
        lower.contains('about')) {
      return 'summary';
    }
    if (lower.contains('experience') || lower.contains('employment')) return 'experience';
    if (lower.contains('education') || lower.contains('academic')) return 'education';
    if (lower.contains('skill') || lower.contains('competen')) return 'skills';
    if (lower.contains('project')) return 'projects';
    if (lower.contains('language')) return 'languages';
    if (lower.contains('award') || lower.contains('honor') || lower.contains('achieve')) {
      return 'awards';
    }
    if (lower.contains('course') || lower.contains('certif')) return 'courses';
    if (lower.contains('contact')) return 'contact';
    return 'header';
  }

  static PersonalInfo _personal(String header, String whole) {
    final email = _firstMatch(whole, RegExp(r'[A-Z0-9._%+\-]+@[A-Z0-9.\-]+\.[A-Z]{2,}', caseSensitive: false));
    final phone = _phone(whole);
    final linkedin = _url(whole, RegExp(r'(?:https?:\/\/)?(?:www\.)?linkedin\.com\/in\/[A-Za-z0-9\-_%/]+', caseSensitive: false));
    final github = _url(whole, RegExp(r'(?:https?:\/\/)?(?:www\.)?github\.com\/[A-Za-z0-9\-]+', caseSensitive: false));
    final portfolio = _portfolio(whole, linkedin, github);
    final location = _location(header.isEmpty ? whole : header);
    final nameAndTitle = _nameAndTitle(header, email, phone);

    return PersonalInfo(
      fullName: nameAndTitle.$1,
      title: nameAndTitle.$2,
      email: email,
      phone: phone,
      location: location,
      linkedin: linkedin,
      github: github,
      portfolio: portfolio,
    );
  }

  static (String, String) _nameAndTitle(String header, String email, String phone) {
    final pieces = [
      for (final line in header.split('\n'))
        ...line.split('|').map((part) => part.trim()).where((part) => part.isNotEmpty),
    ];

    String name = '';
    String title = '';
    final pendingName = <String>[];

    bool skip(String line) {
      if (line.contains('@')) return true;
      if (phone.isNotEmpty && line.replaceAll(RegExp(r'\s'), '').contains(phone.replaceAll(RegExp(r'\s'), ''))) {
        return true;
      }
      if (_looksLikeUrl(line)) return true;
      if (_headerPattern.hasMatch(line)) return true;
      if (_dates(line) != null) return true;
      return false;
    }

    for (final line in pieces.take(12)) {
      if (skip(line)) {
        if (pendingName.length >= 2 && name.isEmpty) {
          name = _titleCaseName(pendingName.join(' '));
        }
        pendingName.clear();
        continue;
      }
      if (name.isEmpty && _looksLikeName(line)) {
        name = _titleCaseName(line);
        pendingName.clear();
        continue;
      }
      if (name.isEmpty && _isNameToken(line) && !_titleWords.contains(line.toLowerCase())) {
        pendingName.add(line);
        if (pendingName.length >= 2) {
          name = _titleCaseName(pendingName.join(' '));
          pendingName.clear();
        }
        continue;
      }
      if (name.isNotEmpty && title.isEmpty && _looksLikeTitle(line)) {
        title = line;
        break;
      }
    }
    if (name.isEmpty && pendingName.length >= 2) {
      name = _titleCaseName(pendingName.join(' '));
    }
    if (name.isEmpty) {
      name = _nameFromStart(header);
    }
    return (name, title);
  }

  static const _titleWords = {
    'senior',
    'junior',
    'staff',
    'lead',
    'principal',
    'product',
    'software',
    'engineer',
    'developer',
    'manager',
    'director',
    'designer',
    'analyst',
    'consultant',
    'specialist',
    'officer',
    'intern',
    'associate',
  };

  static String _nameFromStart(String text) {
    final first = text.split(RegExp(r'\n| \| ')).first.trim();
    final beforeContact = first.split(RegExp(r'\s+(?=[A-Z0-9._%+\-]+@)|(?=\+\d)')).first.trim();
    final words = beforeContact.split(RegExp(r'\s+'));
    final nameWords = <String>[];
    for (final word in words.take(5)) {
      if (_titleWords.contains(word.toLowerCase())) break;
      if (!_isNameToken(word)) break;
      nameWords.add(word);
    }
    if (nameWords.length >= 2) return _titleCaseName(nameWords.join(' '));
    return '';
  }

  static bool _looksLikeName(String line) {
    if (line.length < 3 || line.length > 70) return false;
    if (RegExp(r'\d').hasMatch(line)) return false;
    final words = line.split(RegExp(r'\s+'));
    if (words.length < 2 || words.length > 5) return false;
    if (words.any((word) => _titleWords.contains(word.toLowerCase()))) return false;
    return words.every(_isNameToken);
  }

  static bool _isNameToken(String word) {
    if (RegExp(r"^[A-Za-z]\.$").hasMatch(word)) return true;
    return RegExp(r"^[A-Za-z][A-Za-z'\-]*$").hasMatch(word) && word.length <= 24;
  }

  static String _titleCaseName(String line) {
    return line.split(RegExp(r'\s+')).map((word) {
      if (word.isEmpty) return word;
      if (RegExp(r"^[A-Za-z]\.$").hasMatch(word)) return word.toUpperCase();
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  static bool _looksLikeTitle(String line) {
    if (line.length > 80) return false;
    if (line.contains('@')) return false;
    if (_looksLikeUrl(line)) return false;
    if (_isBullet(line)) return false;
    return !RegExp(r'^\d').hasMatch(line);
  }

  static bool _looksLikeUrl(String line) {
    final lower = line.toLowerCase();
    return lower.contains('http') || lower.contains('www.') || lower.contains('.com') || lower.contains('.dev');
  }

  static String _phone(String text) {
    final match = RegExp(
      r'(\+\d{1,3}[\s.-]?)?(\(?\d{3}\)?[\s.-]?)\d{3}[\s.-]?\d{4}',
    ).firstMatch(text);
    return match?.group(0)?.trim() ?? '';
  }

  static String _url(String text, RegExp pattern) {
    final match = pattern.firstMatch(text);
    if (match == null) return '';
    return match.group(0)!.replaceAll(RegExp(r'/$'), '');
  }

  static String _portfolio(String text, String linkedin, String github) {
    final matches = RegExp(
      r'(?:https?:\/\/)?(?:www\.)?[A-Za-z0-9.-]+\.(?:com|dev|io|me|co|net|org)(?:\/[A-Za-z0-9_./-]*)?',
      caseSensitive: false,
    ).allMatches(text);
    for (final match in matches) {
      final value = match.group(0)!;
      final lower = value.toLowerCase();
      if (lower.contains('linkedin.com') || lower.contains('github.com') || lower.contains('mailto:')) {
        continue;
      }
      if (linkedin.contains(value) || github.contains(value)) continue;
      return value;
    }
    return '';
  }

  static String _location(String text) {
    final match = RegExp(
      r'\b([A-Za-z][a-zA-Z.]+(?:\s[A-Za-z][a-zA-Z.]+)*),\s*([A-Z]{2}|[A-Za-z][a-zA-Z.]+)\b',
    ).firstMatch(text);
    return match?.group(0) ?? '';
  }

  static String _summary(Map<String, String> sections, String header) {
    var body = sections['summary'] ?? '';
    if (body.trim().isEmpty) {
      body = [
        for (final line in header.split('\n'))
          if (line.trim().length > 40 && !line.contains('@') && !_looksLikeUrl(line) && _dates(line) == null)
            line.trim(),
      ].take(4).join(' ');
    }
    if (body.trim().isEmpty) return '';
    final snippet = body.split('\n').where((line) => line.trim().isNotEmpty).take(8).join(' ').trim();
    if (snippet.length < 40) return snippet;
    return snippet.length > 800 ? snippet.substring(0, 800).trim() : snippet;
  }

  static List<Experience> _experiences(String body) {
    if (body.trim().isEmpty) return const [];
    final blocks = _jobBlocks(body);
    final items = <Experience>[];
    for (var i = 0; i < blocks.length && items.length < 8; i++) {
      final item = _experience(blocks[i]);
      if (item != null) items.add(item.copyWith(sortOrder: items.length));
    }
    return items;
  }

  static Experience? _experience(String block) {
    final lines = _nonEmpty(block);
    if (lines.isEmpty) return null;
    var role = '';
    var company = '';
    var start = '';
    var end = '';
    var current = false;
    final bullets = <String>[];

    for (final line in lines) {
      final dates = _dates(line);
      if (dates != null && (line.length < 48 || !_isBullet(line))) {
        start = dates.$1;
        end = dates.$2;
        current = dates.$3;
        final leftover = line
            .replaceAll(
              RegExp(
                r'(Jan(?:uary)?|Feb(?:ruary)?|Mar(?:ch)?|Apr(?:il)?|May|Jun(?:e)?|Jul(?:y)?|Aug(?:ust)?|Sep(?:tember)?|Oct(?:ober)?|Nov(?:ember)?|Dec(?:ember)?)\.?\s+(?:19|20)\d{2}|\b(?:19|20)\d{2}\b|\b(?:present|current|now)\b|\d{1,2}/(?:19|20)\d{2}|[-–—|]',
                caseSensitive: false,
              ),
              ' ',
            )
            .replaceAll(RegExp(r'\s+'), ' ')
            .trim();
        if (leftover.isNotEmpty &&
            leftover.length < 80 &&
            !_isBullet(leftover) &&
            !_actionVerb.hasMatch(leftover)) {
          if (role.isEmpty) {
            final split = _roleCompany(leftover);
            role = split.$1;
            if (company.isEmpty) company = split.$2;
          } else if (company.isEmpty) {
            company = leftover;
          }
        }
        continue;
      }
      if (_isBullet(line) || (role.isNotEmpty && line.length > 40)) {
        bullets.add(_stripBullet(line));
        continue;
      }
      if (role.isEmpty) {
        final split = _roleCompany(line);
        role = split.$1;
        company = split.$2;
        continue;
      }
      if (company.isEmpty && !_looksLikeUrl(line) && line.length < 80) {
        company = line;
        continue;
      }
      if (line.length > 40) bullets.add(line);
    }

    if (role.isEmpty && company.isEmpty) return null;
    return Experience(
      role: role,
      company: company,
      startDate: start,
      endDate: current ? '' : end,
      isCurrent: current,
      bullets: bullets.take(8).toList(),
    );
  }

  static (String, String) _roleCompany(String line) {
    for (final sep in [' at ', ' | ', ' - ', ' – ', ' — ']) {
      final index = line.toLowerCase().indexOf(sep);
      if (index > 0) {
        return (line.substring(0, index).trim(), line.substring(index + sep.length).trim());
      }
    }
    return _splitCompanySuffix(line);
  }

  static final _companySuffix = RegExp(
    r'(Labs|Inc\.?|LLC|Ltd\.?|Limited|Co\.?|Corp\.?|Corporation|Company|Group|Technologies|Solutions|Systems|Studio|Partners)\.?$',
    caseSensitive: false,
  );

  static (String, String) _splitCompanySuffix(String line) {
    if (!_companySuffix.hasMatch(line)) return (line, '');
    final words = line.split(RegExp(r'\s+'));
    if (words.length < 4) return (line, '');
    var take = 2;
    if (words.length >= 3 &&
        (words[words.length - 2] == '&' || words[words.length - 2].toLowerCase() == 'and')) {
      take = 3;
    }
    if (words.length - take < 2) return (line, '');
    return (
      words.sublist(0, words.length - take).join(' '),
      words.sublist(words.length - take).join(' '),
    );
  }

  static List<Education> _educations(String body) {
    if (body.trim().isEmpty) return const [];
    final items = <Education>[];
    for (final block in _jobBlocks(body, education: true)) {
      final lines = _nonEmpty(block);
      if (lines.isEmpty) continue;
      var school = '';
      var degree = '';
      var field = '';
      var start = '';
      var end = '';
      var details = '';
      for (final line in lines) {
        final dates = _dates(line);
        if (dates != null && line.length < 60) {
          start = dates.$1;
          end = dates.$2;
          continue;
        }
        if (school.isEmpty && _looksLikeSchool(line)) {
          school = line;
          continue;
        }
        if (degree.isEmpty && _looksLikeDegree(line)) {
          final parts = line.split(RegExp(r'\s+in\s+|\s+,\s+'));
          degree = parts.first.trim();
          if (parts.length > 1) field = parts.sublist(1).join(' ').trim();
          continue;
        }
        if (school.isEmpty) {
          school = line;
        } else if (details.isEmpty) {
          details = line;
        }
      }
      if (school.isEmpty && degree.isEmpty) continue;
      items.add(
        Education(
          school: school,
          degree: degree,
          field: field,
          startDate: start,
          endDate: end,
          details: details,
          sortOrder: items.length,
        ),
      );
      if (items.length >= 4) break;
    }
    return items;
  }

  static bool _looksLikeSchool(String line) {
    final lower = line.toLowerCase();
    return lower.contains('university') ||
        lower.contains('college') ||
        lower.contains('institute') ||
        lower.contains('school');
  }

  static bool _looksLikeDegree(String line) {
    return RegExp(
      r'\b(b\.?s\.?|b\.?a\.?|m\.?s\.?|m\.?a\.?|mba|ph\.?d\.?|bachelor|master|associate|diploma)\b',
      caseSensitive: false,
    ).hasMatch(line);
  }

  static List<SkillGroup> _skills(String section, String whole) {
    final grouped = _skillGroupsFromSection(section);
    final count = [
      for (final group in grouped)
        for (final skill in group.skills) skill,
    ].length;
    if (count >= 2) return grouped;

    final names = <String>[];
    final seen = <String>{};
    void add(String raw) {
      final name = _cleanSkillName(raw);
      if (!_isRealSkill(name)) return;
      final key = name.toLowerCase();
      if (seen.contains(key)) return;
      seen.add(key);
      names.add(_displaySkill(name));
    }

    for (final group in grouped) {
      for (final skill in group.skills) {
        add(skill.name);
      }
    }
    for (final piece in section.split(RegExp(r'[,|\n•;/]| and '))) {
      add(piece);
    }

    if (names.length < 3) {
      final haystack = _stripContactNoise(section.trim().isNotEmpty ? section : whole);
      final phrases = builtInSkills.toList()
        ..sort((a, b) => b.length.compareTo(a.length));
      for (final skill in phrases) {
        if (skill.length < 3) continue;
        if (!RegExp('\\b${RegExp.escape(skill)}\\b').hasMatch(haystack)) continue;
        add(skill);
        if (names.length >= 16) break;
      }
    }
    if (names.isEmpty) return const [];
    return [
      SkillGroup(
        name: 'Skills',
        skills: [
          for (var i = 0; i < names.length && i < 24; i++)
            Skill(name: names[i], sortOrder: i),
        ],
      ),
    ];
  }

  static List<SkillGroup> _skillGroupsFromSection(String section) {
    if (section.trim().isEmpty) return const [];
    final groups = <SkillGroup>[];
    for (final rawLine in section.split('\n')) {
      final line = rawLine.trim();
      if (line.isEmpty || _headerPattern.hasMatch(line)) continue;
      if (_looksLikeUrl(line) || line.contains('@')) continue;
      final colon = line.indexOf(':');
      if (colon > 1 && colon < line.length - 2 && !_looksLikeUrl(line.substring(0, colon))) {
        final label = _cleanSkillName(line.substring(0, colon));
        final pieces = line.substring(colon + 1).split(RegExp(r'[,|;•/]'));
        final skills = _uniqueSkills(pieces);
        if (skills.isEmpty) continue;
        groups.add(
          SkillGroup(
            name: label.isEmpty ? 'Skills' : label,
            skills: skills,
            sortOrder: groups.length,
          ),
        );
        continue;
      }
      final skills = _uniqueSkills(line.split(RegExp(r'[,|;•/]| and ')));
      if (skills.isEmpty) continue;
      groups.add(
        SkillGroup(
          name: 'Skills',
          skills: skills,
          sortOrder: groups.length,
        ),
      );
    }
    return groups;
  }

  static List<Skill> _uniqueSkills(Iterable<String> pieces) {
    final skills = <Skill>[];
    final seen = <String>{};
    for (final piece in pieces) {
      final name = _cleanSkillName(piece);
      if (!_isRealSkill(name)) continue;
      final key = name.toLowerCase();
      if (seen.contains(key)) continue;
      seen.add(key);
      skills.add(Skill(name: _displaySkill(name), sortOrder: skills.length));
    }
    return skills;
  }

  static String _cleanSkillName(String raw) {
    return raw
        .trim()
        .replaceAll(RegExp(r'^[-*•]+'), '')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  static bool _isRealSkill(String name) {
    if (name.length < 2 || name.length > 40) return false;
    final key = name.toLowerCase();
    if (stopwords.contains(key)) return false;
    if (_looksLikeUrl(name) || name.contains('@')) return false;
    if (_contactTokens.contains(key)) return false;
    if (key.contains('linkedin') || key.contains('github.com') || key.contains('gitlab.com')) {
      return false;
    }
    if (RegExp(r'\.(com|dev|io|me|net|org)\b').hasMatch(key)) return false;
    if (RegExp(r'^\+?\d[\d\s().-]{6,}$').hasMatch(name)) return false;
    return true;
  }

  static const _contactTokens = {
    'linkedin',
    'github',
    'gitlab',
    'bitbucket',
    'email',
    'phone',
    'mobile',
    'tel',
    'portfolio',
    'website',
    'www',
    'http',
    'https',
    'mailto',
    'contact',
    'location',
    'address',
    'instagram',
    'twitter',
    'facebook',
    'youtube',
    'medium',
    'skype',
    'whatsapp',
    'telegram',
    'leetcode',
    'hackerrank',
    'stackoverflow',
  };

  static String _stripContactNoise(String text) {
    return text
        .replaceAll(
          RegExp(
            r'(?:https?:\/\/)?(?:www\.)?(linkedin|github|gitlab|bitbucket|twitter|instagram|facebook|medium|leetcode|hackerrank|stackoverflow)\.com\S*',
            caseSensitive: false,
          ),
          ' ',
        )
        .replaceAll(
          RegExp(r'[A-Z0-9._%+\-]+@[A-Z0-9.\-]+\.[A-Z]{2,}', caseSensitive: false),
          ' ',
        )
        .toLowerCase();
  }

  static String _displaySkill(String name) {
    final lower = name.toLowerCase();
    if (lower == 'ios' || lower == 'aws' || lower == 'sql' || lower == 'css' || lower == 'html' || lower == 'ux' || lower == 'ui') {
      return lower.toUpperCase();
    }
    if (lower == 'javascript') return 'JavaScript';
    if (lower == 'typescript') return 'TypeScript';
    if (lower == 'node.js') return 'Node.js';
    if (name == name.toLowerCase() && name.length > 2) {
      return name[0].toUpperCase() + name.substring(1);
    }
    return name;
  }

  static List<Project> _projects(String body) {
    if (body.trim().isEmpty) return const [];
    final items = <Project>[];
    for (final block in _blocks(body)) {
      final lines = _nonEmpty(block);
      if (lines.isEmpty) continue;
      final name = lines.first;
      var link = '';
      var description = '';
      final bullets = <String>[];
      for (final line in lines.skip(1)) {
        if (_looksLikeUrl(line) && link.isEmpty) {
          link = line;
        } else if (_isBullet(line)) {
          bullets.add(_stripBullet(line));
        } else if (description.isEmpty) {
          description = line;
        } else {
          bullets.add(line);
        }
      }
      items.add(
        Project(
          name: name,
          link: link,
          description: description,
          bullets: bullets,
          sortOrder: items.length,
        ),
      );
      if (items.length >= 6) break;
    }
    return items;
  }

  static List<Language> _languages(String body) {
    if (body.trim().isEmpty) return const [];
    final items = <Language>[];
    for (final piece in body.split(RegExp(r'[,|\n•;]'))) {
      final line = piece.trim();
      if (line.isEmpty) continue;
      final parts = line.split(RegExp(r'\s+-\s+|\s+\(|\)'));
      items.add(
        Language(
          name: parts.first.trim(),
          proficiency: parts.length > 1 ? parts[1].trim() : '',
          sortOrder: items.length,
        ),
      );
      if (items.length >= 8) break;
    }
    return items;
  }

  static List<Award> _awards(String body) {
    if (body.trim().isEmpty) return const [];
    final items = <Award>[];
    for (final line in _nonEmpty(body)) {
      items.add(Award(title: _stripBullet(line), sortOrder: items.length));
      if (items.length >= 6) break;
    }
    return items;
  }

  static List<Course> _courses(String body) {
    if (body.trim().isEmpty) return const [];
    final items = <Course>[];
    for (final line in _nonEmpty(body)) {
      items.add(Course(name: _stripBullet(line), sortOrder: items.length));
      if (items.length >= 8) break;
    }
    return items;
  }

  static List<String> _blocks(String body) {
    final parts = body.split(RegExp(r'\n\s*\n'));
    if (parts.length > 1) {
      return [
        for (final part in parts)
          if (part.trim().isNotEmpty) part.trim(),
      ];
    }
    return [body.trim()];
  }

  static List<String> _jobBlocks(String body, {bool education = false}) {
    final blank = _blocks(body);
    if (blank.length > 1) return blank;

    final lines = _nonEmpty(body);
    final dateIndexes = <int>[];
    for (var i = 0; i < lines.length; i++) {
      final line = lines[i];
      final dates = _dates(line);
      if (dates == null) continue;
      if (_isBullet(line) && line.length > 48) continue;
      dateIndexes.add(i);
    }
    if (dateIndexes.isEmpty) return blank;

    final starts = <int>[];
    for (final dateIndex in dateIndexes) {
      var start = dateIndex;
      var taken = 0;
      var look = dateIndex - 1;
      while (look >= 0 && taken < (education ? 2 : 2)) {
        if (starts.contains(look)) break;
        if (_dates(lines[look]) != null) break;
        if (_isBullet(lines[look])) break;
        if (lines[look].length > 100) break;
        start = look;
        taken++;
        look--;
      }
      if (starts.isEmpty || start >= starts.last) starts.add(start);
    }

    final blocks = <String>[];
    for (var i = 0; i < starts.length; i++) {
      final end = i + 1 < starts.length ? starts[i + 1] : lines.length;
      if (end <= starts[i]) continue;
      blocks.add(lines.sublist(starts[i], end).join('\n'));
    }
    return blocks.isEmpty ? blank : blocks;
  }

  static List<String> _nonEmpty(String body) {
    return [
      for (final line in body.split('\n'))
        if (line.trim().isNotEmpty) line.trim(),
    ];
  }

  static final _actionVerb = RegExp(
    r'^(Led|Lead|Built|Cut|Developed|Created|Managed|Implemented|Designed|Improved|Reduced|Increased|Launched|Owned|Wrote|Shipped|Architected|Delivered|Established|Introduced|Optimized|Collaborated|Worked|Moved)\b',
  );

  static bool _isBullet(String line) {
    return RegExp(r'^[-*•]').hasMatch(line) || _actionVerb.hasMatch(line);
  }

  static String _stripBullet(String line) {
    return line.replaceFirst(RegExp(r'^[-*•]+\s*'), '').trim();
  }

  static (String, String, bool)? _dates(String line) {
    if (_isBullet(line) && line.length > 48) return null;
    final present = RegExp(r'\bpresent\b|\bcurrent\b|\bnow\b', caseSensitive: false).hasMatch(line);
    final slash = RegExp(
      r'\b(\d{1,2}/(?:19|20)\d{2})\s*-\s*(\d{1,2}/(?:19|20)\d{2}|Present|Current)\b',
      caseSensitive: false,
    ).firstMatch(line);
    final years = RegExp(r'\b((?:19|20)\d{2})\b').allMatches(line).map((m) => m.group(1)!).toList();
    final months = RegExp(
      r'\b(Jan(?:uary)?|Feb(?:ruary)?|Mar(?:ch)?|Apr(?:il)?|May|Jun(?:e)?|Jul(?:y)?|Aug(?:ust)?|Sep(?:tember)?|Oct(?:ober)?|Nov(?:ember)?|Dec(?:ember)?)\.?\s+((?:19|20)\d{2})\b',
      caseSensitive: false,
    ).allMatches(line).map((m) => '${m.group(1)} ${m.group(2)}').toList();
    if (slash != null) {
      final end = slash.group(2)!;
      final isPresent = end.toLowerCase().contains('present') || end.toLowerCase().contains('current');
      return (slash.group(1)!, isPresent ? 'Present' : end, isPresent);
    }
    if (!present && years.isEmpty && months.isEmpty) return null;
    if (months.length >= 2) return (months.first, months[1], present);
    if (months.length == 1) {
      return (months.first, present ? 'Present' : (years.length > 1 ? years.last : ''), present);
    }
    if (years.length >= 2) return (years.first, years[1], present);
    if (years.length == 1) return (years.first, present ? 'Present' : '', present);
    if (present) return ('', 'Present', true);
    return null;
  }

  static String _firstMatch(String text, RegExp pattern) {
    return pattern.firstMatch(text)?.group(0) ?? '';
  }
}
