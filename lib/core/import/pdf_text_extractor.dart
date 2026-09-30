import 'dart:typed_data';

import 'package:syncfusion_flutter_pdf/pdf.dart' as sf;

/// Pulls readable text out of a PDF with Syncfusion, keeping line breaks.
class PdfTextExtractor {
  static String extract(Uint8List bytes) {
    sf.PdfDocument? document;
    try {
      document = sf.PdfDocument(inputBytes: bytes);
      final extractor = sf.PdfTextExtractor(document);
      var text = '';
      try {
        text = _fromLines(extractor.extractTextLines());
      } catch (_) {}
      if (!_usable(text)) {
        try {
          text = _clean(extractor.extractText(layoutText: true));
        } catch (_) {}
      }
      if (!_usable(text)) {
        text = _clean(extractor.extractText());
      }
      if (!_usable(text)) {
        throw const FormatException('Could not read enough text from that PDF.');
      }
      return text;
    } on FormatException {
      rethrow;
    } catch (_) {
      throw const FormatException('Could not read that PDF.');
    } finally {
      document?.dispose();
    }
  }

  static String _fromLines(List<sf.TextLine> lines) {
    if (lines.isEmpty) return '';
    final sorted = [...lines]..sort((a, b) {
      final page = a.pageIndex.compareTo(b.pageIndex);
      if (page != 0) return page;
      final dy = a.bounds.top - b.bounds.top;
      if (dy.abs() > 4) return dy < 0 ? -1 : 1;
      return a.bounds.left.compareTo(b.bounds.left);
    });

    final buffer = StringBuffer();
    sf.TextLine? previous;
    for (final line in sorted) {
      final text = line.text.trim();
      if (text.isEmpty) continue;
      if (previous == null) {
        buffer.write(text);
      } else if (line.pageIndex != previous.pageIndex) {
        buffer
          ..write('\n\n')
          ..write(text);
      } else if ((line.bounds.top - previous.bounds.top).abs() <= 4) {
        buffer
          ..write(' ')
          ..write(text);
      } else {
        buffer
          ..write('\n')
          ..write(text);
      }
      previous = line;
    }
    return _clean(buffer.toString());
  }

  static bool _usable(String text) {
    return text.replaceAll(RegExp(r'\s+'), ' ').trim().length >= 20;
  }

  static String _clean(String text) {
    return text
        .replaceAll('\r\n', '\n')
        .replaceAll('\r', '\n')
        .replaceAll(RegExp(r'[ \t]+\n'), '\n')
        .replaceAll(RegExp(r'\n{3,}'), '\n\n')
        .trim();
  }
}
