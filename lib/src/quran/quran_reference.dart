class QuranReference {
  final int surahNumber;
  final int startAyah;
  final int endAyah;

  const QuranReference({
    required this.surahNumber,
    required this.startAyah,
    required this.endAyah,
  }) : assert(startAyah > 0),
       assert(endAyah >= startAyah);

  const QuranReference.single({
    required int surahNumber,
    required int ayahNumber,
  }) : this(
         surahNumber: surahNumber,
         startAyah: ayahNumber,
         endAyah: ayahNumber,
       );

  bool get isSingleAyah => startAyah == endAyah;

  @override
  String toString() => '$surahNumber:$startAyah-$endAyah';
}
