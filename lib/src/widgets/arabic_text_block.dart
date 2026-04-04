import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

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
        style: AppTypography.arabicStyle(
          fontSize: baseFontSize * fontScale,
          height: 2.2,
          color: textColor,
        ),
      ),
    );
  }
}
