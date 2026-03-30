import 'package:flutter_test/flutter_test.dart';
import 'package:faishal_design/faishal_design.dart';

void main() {
  group('SeoUtils', () {
    test('setMetaTags executes without error on mobile', () {
      expect(
        () => SeoUtils.setMetaTags(
          title: 'Test Title',
          description: 'Test Description',
          ogImage: 'https://example.com/image.png',
          canonical: 'https://example.com/canonical',
        ),
        returnsNormally,
      );
    });

    test('setJsonLd executes without error on mobile', () {
      expect(
        () => SeoUtils.setJsonLd({
          '@context': 'https://schema.org',
          '@type': 'WebSite',
        }),
        returnsNormally,
      );
    });
  });
}
