import 'dart:async';
import 'dart:developer' as developer;

void logAppError(String name, Object error, [StackTrace? stack]) {
  developer.log(
    '$error',
    name: name,
    error: error,
    stackTrace: stack,
  );
}

StreamSubscription<T> listenLogged<T>(
  Stream<T> stream,
  void Function(T value) onData, {
  required String name,
  bool Function()? isClosed,
}) {
  return stream.listen(
    (value) {
      if (isClosed != null && isClosed()) return;
      onData(value);
    },
    onError: (Object error, StackTrace stack) {
      logAppError(name, error, stack);
    },
  );
}
