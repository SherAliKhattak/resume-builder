String displayUrl(String raw) {
  var text = raw.trim();
  if (text.isEmpty) return text;
  text = text.replaceFirst(RegExp(r'^https?://', caseSensitive: false), '');
  text = text.replaceFirst(RegExp(r'^www\.', caseSensitive: false), '');
  while (text.endsWith('/')) {
    text = text.substring(0, text.length - 1);
  }
  return text;
}

String hrefUrl(String raw) {
  final text = raw.trim();
  if (text.isEmpty) return text;
  if (RegExp(r'^[a-zA-Z][a-zA-Z0-9+.-]*:').hasMatch(text)) {
    return text;
  }
  return 'https://$text';
}

bool sameDisplayedUrl(String left, String right) {
  final a = displayUrl(left).toLowerCase();
  final b = displayUrl(right).toLowerCase();
  return a.isNotEmpty && a == b;
}

bool textContainsUrl(String text, String url) {
  final raw = url.trim();
  if (raw.isEmpty) return false;
  final haystack = text.toLowerCase();
  if (haystack.contains(raw.toLowerCase())) return true;
  final shown = displayUrl(raw).toLowerCase();
  return shown.isNotEmpty && haystack.contains(shown);
}

/// True when the project link is already visible on the name, description,
/// or bullets so the subtitle should be omitted.
bool projectLinkAlreadyShown({
  required String name,
  required String link,
  String description = '',
  List<String> bullets = const [],
}) {
  if (link.trim().isEmpty) return true;
  if (textContainsUrl(name, link) || sameDisplayedUrl(name, link)) {
    return true;
  }
  if (textContainsUrl(description, link)) return true;
  return bullets.any((bullet) => textContainsUrl(bullet, link));
}
