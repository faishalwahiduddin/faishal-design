import 'package:faishal_design/faishal_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders quran passage in rtl with ayah markers', (tester) async {
    const passage = QuranPassage(
      reference: QuranReference(surahNumber: 1, startAyah: 1, endAyah: 2),
      sourceLabel: 'QS. Al-Fatihah: 1-2',
      verses: [
        QuranAyahSegment(surahNumber: 1, ayahNumber: 1, text: 'بِسْمِ اللَّهِ'),
        QuranAyahSegment(
          surahNumber: 1,
          ayahNumber: 2,
          text: 'الْحَمْدُ لِلَّهِ',
        ),
      ],
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: QuranMushafText(passage: passage)),
      ),
    );

    final directionality = tester.widget<Directionality>(
      find.descendant(
        of: find.byType(QuranMushafText),
        matching: find.byType(Directionality),
      ),
    );

    expect(directionality.textDirection, TextDirection.rtl);
    expect(find.textContaining('بِسْمِ اللَّهِ'), findsOneWidget);
    expect(find.textContaining(AyahEndMarker.buildLabel(1)), findsOneWidget);
    expect(find.textContaining(AyahEndMarker.buildLabel(2)), findsOneWidget);
  });
}
