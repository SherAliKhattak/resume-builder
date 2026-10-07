class SimpleStemmer {
  static const _irregular = {
    'javascript': 'javascript',
    'typescript': 'typescript',
    'kubernetes': 'kubernetes',
    'business': 'business',
    'analysis': 'analys',
    'analyst': 'analyst',
    'analytics': 'analyt',
    'statistics': 'statistic',
    'management': 'manage',
    'managing': 'manage',
    'managed': 'manage',
    'manager': 'manage',
    'marketing': 'market',
    'writing': 'write',
    'written': 'write',
    'testing': 'test',
    'tested': 'test',
    'communication': 'communicat',
    'collaborating': 'collaborat',
    'collaboration': 'collaborat',
  };

  static String stem(String input) {
    final word = input.toLowerCase();
    if (word.length <= 3) return word;
    if (word.contains(RegExp(r'[+#./]'))) return word;
    final known = _irregular[word];
    if (known != null) return known;

    var current = word;
    if (current.endsWith('ies') && current.length > 5) {
      return '${current.substring(0, current.length - 3)}y';
    }
    if (current.endsWith('ses') && current.length > 5) {
      return current.substring(0, current.length - 2);
    }
    if (current.endsWith('ing') && current.length > 6) {
      current = current.substring(0, current.length - 3);
      if (current.endsWith('at') ||
          current.endsWith('it') ||
          current.endsWith('et') ||
          current.endsWith('ag')) {
        return '${current}e';
      }
      if (current.length >= 2 &&
          current[current.length - 1] == current[current.length - 2]) {
        return current.substring(0, current.length - 1);
      }
      return current;
    }
    if (current.endsWith('ers') && current.length > 5) {
      return current.substring(0, current.length - 1);
    }
    if (current.endsWith('ed') && current.length > 5) {
      current = current.substring(0, current.length - 2);
      if (current.endsWith('at') || current.endsWith('it') || current.endsWith('ag')) {
        return '${current}e';
      }
      return current;
    }
    if (current.endsWith('ly') && current.length > 5) {
      return current.substring(0, current.length - 2);
    }
    if (current.endsWith('es') && current.length > 5) {
      return current.substring(0, current.length - 2);
    }
    if (current.endsWith('s') &&
        !current.endsWith('ss') &&
        !current.endsWith('us') &&
        current.length > 4) {
      return current.substring(0, current.length - 1);
    }
    return current;
  }

  static Set<String> variants(String input) {
    final word = input.toLowerCase();
    final stemmed = stem(word);
    return {
      word,
      stemmed,
      if (!stemmed.endsWith('e')) '${stemmed}e',
    };
  }
}
