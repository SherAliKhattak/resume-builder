import 'package:flutter/widgets.dart';

mixin LifecycleFlush {
  late final _observer = _FlushObserver(flushPending);

  void attachLifecycleFlush() {
    WidgetsBinding.instance.addObserver(_observer);
  }

  void detachLifecycleFlush() {
    WidgetsBinding.instance.removeObserver(_observer);
  }

  Future<void> flushPending();
}

class _FlushObserver with WidgetsBindingObserver {
  _FlushObserver(this._flush);

  final Future<void> Function() _flush;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        _flush();
      case AppLifecycleState.resumed:
        break;
    }
  }
}
