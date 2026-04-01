import 'package:flutter_test/flutter_test.dart';
import 'package:faishal_design/faishal_design.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('QuranTextRepository', () {
    test('parses ranged source labels', () async {
      final reference = await QuranTextRepository.instance.parseReferenceLabel(
        'QS. Al-Baqarah: 285-286',
      );

      expect(reference, isNotNull);
      expect(reference!.surahNumber, 2);
      expect(reference.startAyah, 285);
      expect(reference.endAyah, 286);
    });

    test('parses full surah source labels with number', () async {
      final reference = await QuranTextRepository.instance.parseReferenceLabel(
        'QS. Al-Ikhlas (112)',
      );

      expect(reference, isNotNull);
      expect(reference!.surahNumber, 112);
      expect(reference.startAyah, 1);
      expect(reference.endAyah, 4);
    });

    test('loads passage text from package asset', () async {
      final passage = await QuranTextRepository.instance.findPassageForSource(
        'QS. Al-Fatihah: 1-7',
      );

      expect(passage, isNotNull);
      expect(passage!.verses, hasLength(7));
      expect(passage.verses.first.text, contains('بِسْمِ'));
      expect(passage.verses.last.ayahNumber, 7);
    });
  });
}
