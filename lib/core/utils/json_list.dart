import 'dart:convert';

String encodeStringList(List<String> items) => jsonEncode(items);

List<String> decodeStringList(String? raw) {
  if (raw == null || raw.trim().isEmpty) return const [];
  try {
    final decoded = jsonDecode(raw);
    if (decoded is List) {
      return decoded.map((e) => '$e').where((e) => e.trim().isNotEmpty).toList();
    }
  } catch (_) {
    return raw
        .split('\n')
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();
  }
  return const [];
}

List<String> stringListFromJson(dynamic raw) {
  if (raw is List) {
    return raw.map((e) => '$e').where((e) => e.trim().isNotEmpty).toList();
  }
  if (raw is String) return decodeStringList(raw);
  return const [];
}

String readString(Map<String, dynamic> json, String key, [String fallback = '']) {
  final value = json[key];
  if (value == null) return fallback;
  return '$value';
}

int readInt(Map<String, dynamic> json, String key, [int fallback = 0]) {
  final value = json[key];
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse('$value') ?? fallback;
}

double readDouble(Map<String, dynamic> json, String key, [double fallback = 0]) {
  final value = json[key];
  if (value is double) return value;
  if (value is num) return value.toDouble();
  return double.tryParse('$value') ?? fallback;
}

bool readBool(Map<String, dynamic> json, String key, [bool fallback = false]) {
  final value = json[key];
  if (value is bool) return value;
  if (value is num) return value != 0;
  final text = '$value'.toLowerCase();
  if (text == 'true') return true;
  if (text == 'false') return false;
  return fallback;
}
