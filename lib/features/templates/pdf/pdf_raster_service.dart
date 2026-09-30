import 'dart:async';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:printing/printing.dart';

class _RasterJob {
  _RasterJob(this.run, {required this.urgent, required this.abort});

  final Future<void> Function() run;
  final bool urgent;
  final void Function(Object error) abort;
}

Uint8List _copyBytes(Uint8List input) {
  return Uint8List.fromList(
    input.buffer.asUint8List(input.offsetInBytes, input.lengthInBytes),
  );
}

PdfRaster _copyRaster(PdfRaster page) {
  return PdfRaster(page.width, page.height, _copyBytes(page.pixels));
}

/// Runs PDF raster work one job at a time so the printing plugin can finish
/// each document before the next starts. Preview jobs jump the queue and
/// pause gallery thumbnails while a preview is on screen.
class PdfRasterService {
  final _jobs = <_RasterJob>[];
  var _running = false;
  var _previewDepth = 0;
  Completer<void>? _previewIdle;

  bool get isPreviewing => _previewDepth > 0;

  void beginPreview() {
    _previewDepth++;
    _previewIdle ??= Completer<void>();
    _abortNonUrgent();
  }

  void endPreview() {
    _previewDepth = math.max(0, _previewDepth - 1);
    if (_previewDepth == 0) {
      _previewIdle?.complete();
      _previewIdle = null;
    }
  }

  Future<void> waitWhilePreviewing() {
    return _previewIdle?.future ?? Future<void>.value();
  }

  void _abortNonUrgent() {
    final skipped = _jobs.where((item) => !item.urgent).toList();
    _jobs.removeWhere((item) => !item.urgent);
    for (final item in skipped) {
      item.abort(StateError('preview took priority'));
    }
  }

  Future<T> _enqueue<T>(
    Future<T> Function() job, {
    bool urgent = false,
  }) {
    final completer = Completer<T>();
    void completeError(Object error, [StackTrace? stack]) {
      if (!completer.isCompleted) {
        completer.completeError(error, stack);
      }
    }

    final wrapped = _RasterJob(
      () async {
        try {
          if (!completer.isCompleted) {
            completer.complete(await job());
          }
        } catch (error, stack) {
          completeError(error, stack);
        }
      },
      urgent: urgent,
      abort: completeError,
    );
    if (urgent) {
      _abortNonUrgent();
      _jobs.insert(0, wrapped);
    } else {
      _jobs.add(wrapped);
    }
    _pump();
    return completer.future;
  }

  Future<void> _pump() async {
    if (_running) return;
    _running = true;
    try {
      while (_jobs.isNotEmpty) {
        await _jobs.removeAt(0).run();
      }
    } finally {
      _running = false;
      if (_jobs.isNotEmpty) {
        unawaited(_pump());
      }
    }
  }

  Future<Uint8List> rasterFirstPage(Uint8List pdf, {double dpi = 36}) {
    return _enqueue(() async {
      PdfRaster? first;
      await for (final page in Printing.raster(pdf, dpi: dpi)) {
        first ??= _copyRaster(page);
      }
      if (first == null) {
        throw StateError('PDF raster returned no pages');
      }
      final png = await first.toPng();
      return _copyBytes(png);
    });
  }

  Stream<PdfRaster> rasterPages(
    Uint8List pdf, {
    double dpi = 72,
    int maxPages = 4,
  }) {
    final controller = StreamController<PdfRaster>();
    _enqueue(
      () async {
        try {
          var count = 0;
          await for (final page in Printing.raster(pdf, dpi: dpi)) {
            if (controller.isClosed) continue;
            if (count < maxPages) {
              controller.add(_copyRaster(page));
            }
            count++;
          }
          if (count == 0) {
            throw StateError('PDF raster returned no pages');
          }
        } catch (error, stack) {
          if (!controller.isClosed) {
            controller.addError(error, stack);
          }
        } finally {
          if (!controller.isClosed) {
            await controller.close();
          }
        }
      },
      urgent: true,
    );
    return controller.stream;
  }
}
