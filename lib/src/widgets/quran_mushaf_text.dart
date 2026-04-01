import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../quran/quran_passage.dart';
import 'ayah_end_marker.dart';

class QuranMushafText extends StatelessWidget {
  final QuranPassage passage;
  final double fontScale;
  final double baseFontSize;
  final TextAlign textAlign;
  final bool showAyahMarkers;

  const QuranMushafText({
    super.key,
    required this.passage,
    this.fontScale = 1,
    this.baseFontSize = 30,
    this.textAlign = TextAlign.center,
    this.showAyahMarkers = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final markerColor = theme.colorScheme.primary;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Text.rich(
        TextSpan(
          children: [
            for (final ayah in passage.verses) ...[
              TextSpan(text: '${ayah.text} '),
              if (showAyahMarkers)
                TextSpan(
                  text: '${AyahEndMarker.buildLabel(ayah.ayahNumber)} ',
                  style: GoogleFonts.amiri(
                    fontSize: (baseFontSize * fontScale) * 0.72,
                    height: 1.8,
                    color: markerColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
            ],
          ],
          style: GoogleFonts.amiri(
            fontSize: baseFontSize * fontScale,
            height: 2,
            color: textColor,
          ),
        ),
        textAlign: textAlign,
        softWrap: true,
        textWidthBasis: TextWidthBasis.parent,
      ),
    );
  }
}
