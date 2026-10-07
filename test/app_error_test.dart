import 'package:flutter_test/flutter_test.dart';
import 'package:resume_builder/core/errors/app_error.dart';

void main() {
  test('keeps an AppException message', () {
    expect(
      userFacingMessage(
        const AppException('Please wait a moment and try again.'),
      ),
      'Please wait a moment and try again.',
    );
  });

  test('maps network and timeout errors', () {
    expect(
      userFacingMessage(Exception('SocketException: Failed host lookup')),
      'Could not reach the network. Check your connection and try again.',
    );
    expect(
      userFacingMessage(Exception('TimeoutException after 0:00:30')),
      'That took too long. Check your connection and try again.',
    );
  });

  test('maps review HTTP statuses to a generic retry', () {
    expect(
      userFacingMessage(Exception('Review request failed 429: RESOURCE_EXHAUSTED')),
      'Please wait a moment and try again.',
    );
    expect(
      userFacingMessage(Exception('The review model is no longer available')),
      'Please wait a moment and try again.',
    );
  });
}
