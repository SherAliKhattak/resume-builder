class AppException implements Exception {
  const AppException(this.message, {this.cause});

  final String message;
  final Object? cause;

  @override
  String toString() => message;
}

String userFacingMessage(
  Object error, {
  String fallback = 'Something went wrong. Try again.',
}) {
  if (error is AppException) return error.message;
  final text = error.toString().toLowerCase();
  if (text.contains('timeout') || text.contains('timed out')) {
    return 'That took too long. Check your connection and try again.';
  }
  if (text.contains('socket') ||
      text.contains('failed host') ||
      text.contains('network') ||
      text.contains('connection refused') ||
      text.contains('connection reset') ||
      text.contains('clientexception')) {
    return 'Could not reach the network. Check your connection and try again.';
  }
  if (text.contains('401') ||
      text.contains('403') ||
      text.contains('api key') ||
      text.contains('permission_denied') ||
      text.contains('unauthenticated') ||
      text.contains('not configured')) {
    return 'Please wait a moment and try again.';
  }
  if (text.contains('404') ||
      text.contains('not found') ||
      text.contains('no longer available')) {
    return 'Please wait a moment and try again.';
  }
  if (text.contains('429') || text.contains('resource_exhausted')) {
    return 'Please wait a moment and try again.';
  }
  if (text.contains('500') ||
      text.contains('503') ||
      text.contains('unavailable') ||
      text.contains('internal') ||
      text.contains('empty review') ||
      text.contains('could not read')) {
    return 'Please wait a moment and try again.';
  }
  return fallback;
}
