import 'package:flutter_test/flutter_test.dart';
import 'package:resume_builder/features/templates/pdf/resume_links.dart';

void main() {
  group('displayUrl', () {
    test('strips scheme, www, and trailing slashes', () {
      expect(
        displayUrl('https://www.linkedin.com/in/sher-ali-khattak/'),
        'linkedin.com/in/sher-ali-khattak',
      );
      expect(
        displayUrl('http://github.com/alexrivera/garden-log/'),
        'github.com/alexrivera/garden-log',
      );
    });

    test('leaves already-short links alone', () {
      expect(
        displayUrl('linkedin.com/in/sher-ali-khattak'),
        'linkedin.com/in/sher-ali-khattak',
      );
    });

    test('is case-insensitive for the prefix', () {
      expect(displayUrl('HTTPS://WWW.Example.com/path/'), 'Example.com/path');
    });
  });

  group('hrefUrl', () {
    test('adds https when the scheme is missing', () {
      expect(
        hrefUrl('linkedin.com/in/sher-ali-khattak'),
        'https://linkedin.com/in/sher-ali-khattak',
      );
    });

    test('keeps an existing scheme as the click target', () {
      expect(
        hrefUrl('https://www.linkedin.com/in/sher-ali-khattak/'),
        'https://www.linkedin.com/in/sher-ali-khattak/',
      );
    });
  });

  group('projectLinkAlreadyShown', () {
    test('hides a link that is already in the project name', () {
      expect(
        projectLinkAlreadyShown(
          name: 'github.com/alexrivera/garden-log',
          link: 'https://github.com/alexrivera/garden-log/',
        ),
        isTrue,
      );
    });

    test('hides a link repeated in the description or bullets', () {
      expect(
        projectLinkAlreadyShown(
          name: 'Garden Log',
          link: 'https://github.com/alexrivera/garden-log',
          description: 'See github.com/alexrivera/garden-log for source.',
        ),
        isTrue,
      );
      expect(
        projectLinkAlreadyShown(
          name: 'Garden Log',
          link: 'https://alexrivera.dev/garden',
          bullets: ['Live at https://alexrivera.dev/garden/'],
        ),
        isTrue,
      );
    });

    test('keeps a link that has not been shown yet', () {
      expect(
        projectLinkAlreadyShown(
          name: 'Garden Log',
          link: 'https://github.com/alexrivera/garden-log',
          description: 'Tracks plants offline.',
          bullets: ['Works without a network.'],
        ),
        isFalse,
      );
    });
  });
}
