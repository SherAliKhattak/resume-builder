import 'dart:convert';
import 'dart:developer' as developer;

import 'package:http/http.dart' as http;

import '../../../core/config/gemini_config.dart';
import '../../../core/errors/app_error.dart';
import '../domain/ats_reviewer.dart';
import '../domain/models/ats_review.dart';
import 'ats_review_parser.dart';

class GeminiAtsReviewer implements AtsReviewer {
  GeminiAtsReviewer({http.Client? client, String? apiKey})
    : _client = client ?? http.Client(),
      _apiKey = (apiKey ?? kGeminiApiKey).trim();

  static const _endpoint =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-3.8-flash:generateContent';

  final http.Client _client;
  final String _apiKey;

  @override
  Future<AtsReview?> review({
    required String jobDescription,
    required String resumeText,
  }) async {
    if (_apiKey.isEmpty) {
      _log('fail: API key is empty');
      throw const AppException(
        'Please wait a moment and try again.',
      );
    }
    _log(
      'request: model=gemini-3.8-flash '
      'keyLength=${_apiKey.length} '
      'jobChars=${jobDescription.length} '
      'resumeChars=${resumeText.length}',
    );
    final uri = Uri.parse(_endpoint).replace(queryParameters: {'key': _apiKey});
    late final http.Response response;
    try {
      response = await _client
          .post(
            uri,
            headers: const {'Content-Type': 'application/json'},
            body: jsonEncode({
              'contents': [
                {
                  'parts': [
                    {'text': _prompt(jobDescription, resumeText)},
                  ],
                },
              ],
              'generationConfig': {
                'temperature': 0.2,
                'responseMimeType': 'application/json',
              },
            }),
          )
          .timeout(const Duration(seconds: 30));
    } catch (error, stack) {
      _log('fail: request did not complete: $error', stack);
      throw AppException(userFacingMessage(error), cause: error);
    }
    if (response.statusCode < 200 || response.statusCode >= 300) {
      final apiError = _apiError(response.body);
      _log(
        'fail: HTTP ${response.statusCode} '
        '$apiError '
        'body=${_clip(response.body)}',
      );
      throw AppException(
        userFacingMessage(
          'Review request failed ${response.statusCode}: $apiError',
        ),
      );
    }
    final body = jsonDecode(response.body);
    if (body is! Map) {
      _log('fail: response was not a JSON object: ${_clip(response.body)}');
      throw const AppException(
        'Please wait a moment and try again.',
      );
    }
    final text = _responseText(body);
    if (text == null) {
      _log(
        'fail: no review text in candidates. '
        'body=${_clip(response.body)}',
      );
      throw const AppException(
        'Please wait a moment and try again.',
      );
    }
    final review = parseAtsReview(text);
    if (review == null) {
      _log('fail: could not parse review JSON: ${_clip(text)}');
      throw const AppException(
        'Please wait a moment and try again.',
      );
    }
    _log(
      'ok: score=${review.score} '
      'matched=${review.matchedKeywords.length} '
      'missing=${review.missingKeywords.length}',
    );
    return review;
  }

  static void _log(String message, [StackTrace? stack]) {
    developer.log(message, name: 'GeminiAts', stackTrace: stack);
  }

  static String _apiError(String raw) {
    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map) {
        final error = decoded['error'];
        if (error is Map) {
          final status = error['status'];
          final message = error['message'];
          return [status, message].whereType<String>().join(' — ');
        }
      }
    } catch (_) {}
    return raw.trim().isEmpty ? '(empty body)' : _clip(raw);
  }

  static String _clip(String raw, [int max = 800]) {
    final trimmed = raw.trim();
    if (trimmed.length <= max) return trimmed;
    return '${trimmed.substring(0, max)}…';
  }

  String _prompt(String jobDescription, String resumeText) {
    return '''
You are a professional resume reviewer for ATS systems.
Analyze the resume against the job description.
Return JSON only, with this shape:
{
  "JD Matched Score": "X%",
  "MatchedKeywords": ["keyword already in the resume"],
  "MissingKeywords": ["keyword1"],
  "Strengths": ["strength1"],
  "Weaknesses": ["weakness1"],
  "AlternativeWords": {"old": "better"},
  "Improved Resume": "optional rewritten resume",
  "Profile Summary": "optional short summary"
}
Do not invent jobs, employers, or skills that are not in the resume.
Keep lists short and specific.

resume = $resumeText
description = $jobDescription
''';
  }

  String? _responseText(Map<dynamic, dynamic> body) {
    final candidates = body['candidates'];
    if (candidates is! List || candidates.isEmpty) return null;
    final first = candidates.first;
    if (first is! Map) return null;
    final content = first['content'];
    if (content is! Map) return null;
    final parts = content['parts'];
    if (parts is! List) return null;
    final buffer = StringBuffer();
    for (final part in parts) {
      if (part is Map && part['text'] is String) {
        buffer.write(part['text']);
      }
    }
    final text = buffer.toString().trim();
    return text.isEmpty ? null : text;
  }
}
