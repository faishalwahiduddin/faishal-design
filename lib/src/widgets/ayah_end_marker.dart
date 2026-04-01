import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AyahEndMarker extends StatelessWidget {
  final int ayahNumber;
  final double fontSize;
  final Color? color;

  const AyahEndMarker({
    super.key,
    required this.ayahNumber,
    this.fontSize = 20,
    this.color,
  });

  static String buildLabel(int ayahNumber) {
    return '﴿${_toArabicIndic(ayahNumber)}﴾';
  }

  static String _toArabicIndic(int value) {
    const digits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    return value
        .toString()
        .split('')
        .map((digit) => digits[int.parse(digit)])
        .join();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      buildLabel(ayahNumber),
      textDirection: TextDirection.rtl,
      style: GoogleFonts.amiri(
        fontSize: fontSize,
        height: 1,
        color: color ?? Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
