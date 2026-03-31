import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// iOS-style 0.5px hairline separator.
class IslamicDivider extends StatelessWidget {
  final double indent;

  const IslamicDivider({super.key, this.indent = 16});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color =
        isDark ? AppColors.iosSeparatorDark : AppColors.iosSeparatorLight;

    return Container(
      height: 0.5,
      margin: EdgeInsetsDirectional.only(start: indent),
      color: color,
    );
  }
}
