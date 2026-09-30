import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';

import 'pdf_text_extractor.dart';

class ResumeFileReader {
  static const maxBytes = 12 * 1024 * 1024;

  static String read(Uint8List bytes, String filename) {
    if (bytes.length > maxBytes) {
      throw const FormatException('That file is too large to read on this device.');
    }
    final name = filename.toLowerCase();
    if (name.endsWith('.pdf') || _looksLikePdf(bytes)) {
      return PdfTextExtractor.extract(bytes);
    }
    if (name.endsWith('.docx') || _looksLikeZip(bytes)) {
      final docx = _fromDocx(bytes);
      if (docx.trim().isNotEmpty) return docx;
    }
    if (name.endsWith('.rtf') || utf8.decode(bytes.take(64).toList(), allowMalformed: true).contains('{\\rtf')) {
      return _fromRtf(utf8.decode(bytes, allowMalformed: true));
    }
    if (name.endsWith('.html') || name.endsWith('.htm')) {
      return _fromHtml(utf8.decode(bytes, allowMalformed: true));
    }
    return utf8.decode(bytes, allowMalformed: true);
  }

  static bool _looksLikePdf(Uint8List bytes) {
    return bytes.length >= 5 &&
        bytes[0] == 0x25 &&
        bytes[1] == 0x50 &&
        bytes[2] == 0x44 &&
        bytes[3] == 0x46;
  }

  static bool _looksLikeZip(Uint8List bytes) {
    return bytes.length >= 4 &&
        bytes[0] == 0x50 &&
        bytes[1] == 0x4b &&
        (bytes[2] == 0x03 || bytes[2] == 0x05 || bytes[2] == 0x07);
  }

  static String _fromDocx(Uint8List bytes) {
    try {
      final zip = ZipDecoder().decodeBytes(bytes);
      ArchiveFile? file;
      for (final item in zip.files) {
        if (item.name == 'word/document.xml' ||
            item.name.endsWith('/word/document.xml')) {
          file = item;
          break;
        }
      }
      if (file == null) return '';
      final xml = utf8.decode(file.content, allowMalformed: true);
      final paragraphs = xml.replaceAll(RegExp(r'</w:p[^>]*>'), '\n');
      final withTabs = paragraphs.replaceAll(RegExp(r'<w:tab[^/]*/>'), ' ');
      final text = withTabs
          .replaceAll(RegExp(r'<w:t[^>]*>'), '')
          .replaceAll(RegExp(r'</w:t>'), '')
          .replaceAll(RegExp(r'<[^>]+>'), ' ');
      return _unescapeXml(text)
          .replaceAll(RegExp(r'[ \t]+\n'), '\n')
          .replaceAll(RegExp(r'\n{3,}'), '\n\n')
          .trim();
    } catch (_) {
      return '';
    }
  }

  static String _unescapeXml(String value) {
    return value
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"')
        .replaceAll('&apos;', "'");
  }

  static String _fromRtf(String raw) {
    var text = raw.replaceAll(RegExp(r"\\'[0-9a-fA-F]{2}"), ' ');
    text = text.replaceAll(RegExp(r'\\[a-zA-Z]+\d* ?'), ' ');
    text = text.replaceAll(RegExp(r'[{}]'), ' ');
    return text.replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  static String _fromHtml(String raw) {
    var text = raw.replaceAll(RegExp(r'<script[^>]*>[\s\S]*?</script>', caseSensitive: false), ' ');
    text = text.replaceAll(RegExp(r'<style[^>]*>[\s\S]*?</style>', caseSensitive: false), ' ');
    text = text.replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n');
    text = text.replaceAll(RegExp(r'</p>', caseSensitive: false), '\n');
    text = text.replaceAll(RegExp(r'<[^>]+>'), ' ');
    return _unescapeXml(text).trim();
  }
}
