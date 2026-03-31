import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

/// RTL Arabic text block with Amiri font, configurable scale,
/// and proper line height for reading views.
class ArabicTextBlock extends StatelessWidget {
  final String text;
  final double fontScale;
  final double baseFontSize;
  final TextAlign textAlign;

  const ArabicTextBlock({
    super.key,
    required this.text,
    this.fontScale = 1.0,
    this.baseFontSize = 30,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? AppColors.arabicTextDark : AppColors.arabicTextLight;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Text(
        text,
        textAlign: textAlign,
        style: GoogleFonts.amiri(
          fontSize: baseFontSize * fontScale,
          height: 2.2,
          color: textColor,
        ),
      ),
    );
  }
}
