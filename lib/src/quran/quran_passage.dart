import 'quran_reference.dart';

class QuranAyahSegment {
  final int surahNumber;
  final int ayahNumber;
  final String text;

  const QuranAyahSegment({
    required this.surahNumber,
    required this.ayahNumber,
    required this.text,
  });
}

class QuranPassage {
  final QuranReference reference;
  final String sourceLabel;
  final List<QuranAyahSegment> verses;

  const QuranPassage({
    required this.reference,
    required this.sourceLabel,
    required this.verses,
  });

  bool get isEmpty => verses.isEmpty;
}
