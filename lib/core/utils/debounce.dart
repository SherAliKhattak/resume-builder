import 'dart:async';

class Debouncer {
  Debouncer({this.delay = const Duration(milliseconds: 500)});

  final Duration delay;
  Timer? _timer;
  Future<void> Function()? _pending;
  Future<void>? _inFlight;

  bool get hasPending => _pending != null || _inFlight != null;

  void call(FutureOr<void> Function() action) {
    _timer?.cancel();
    _pending = () async => action();
    _timer = Timer(delay, () {
      final run = _pending;
      _pending = null;
      _timer = null;
      if (run == null) return;
      final write = run();
      _inFlight = write;
      write.whenComplete(() {
        if (identical(_inFlight, write)) {
          _inFlight = null;
        }
      });
    });
  }

  Future<void> flush() async {
    _timer?.cancel();
    _timer = null;
    final run = _pending;
    _pending = null;
    if (run != null) {
      await run();
    }
    final inFlight = _inFlight;
    if (inFlight != null) {
      await inFlight;
    }
  }

  void dispose() {
    _timer?.cancel();
    _timer = null;
    _pending = null;
  }
}
