class TextNormalizer {
  static final _space = RegExp(r'\s+');
  static final _dotKeep = RegExp(r'([a-z0-9])\.([a-z0-9])');
  static final _slashKeep = RegExp(r'([a-z0-9])/([a-z0-9])');
  static final _strip = RegExp(r'[^a-z0-9+#/\s\u0001\u0002]+');

  static String normalize(String input) {
    var lower = input.toLowerCase().replaceAll('\u00a0', ' ');
    lower = lower.replaceAllMapped(_dotKeep, (match) => '${match[1]}\u0001${match[2]}');
    lower = lower.replaceAllMapped(_slashKeep, (match) => '${match[1]}\u0002${match[2]}');
    lower = lower.replaceAll(_strip, ' ');
    lower = lower.replaceAll('\u0001', '.').replaceAll('\u0002', '/');
    return lower.replaceAll(_space, ' ').trim();
  }

  static List<String> tokens(String input) {
    final normalized = normalize(input);
    if (normalized.isEmpty) return const [];
    return normalized.split(' ').where((token) => token.isNotEmpty).toList();
  }
}
