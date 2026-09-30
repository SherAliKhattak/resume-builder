import 'dart:async';

class Debouncer {
  Debouncer({this.delay = const Duration(milliseconds: 500)});

  final Duration delay;
  Timer? _timer;
  Future<void> Function()? _pending;

  bool get hasPending => _pending != null;

  void call(FutureOr<void> Function() action) {
    _timer?.cancel();
    _pending = () async => action();
    _timer = Timer(delay, () {
      final run = _pending;
      _pending = null;
      _timer = null;
      run?.call();
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
  }

  void dispose() {
    _timer?.cancel();
    _timer = null;
    _pending = null;
  }
}
