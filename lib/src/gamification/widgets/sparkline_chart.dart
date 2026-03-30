import 'dart:math';
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class SparklineChart extends StatelessWidget {
  final List<double> data;
  final double height;
  final double width;
  final Color? lineColor;
  final double lineWidth;

  const SparklineChart({
    super.key,
    required this.data,
    this.height = 40.0,
    this.width = double.infinity,
    this.lineColor,
    this.lineWidth = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return SizedBox(
        height: height,
        width: width,
        child: const Center(
          child: Text('No Data'),
        ),
      );
    }

    final theme = Theme.of(context);
    final color = lineColor ?? AppColors.primary;

    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: CustomPaint(
        painter: _SparklinePainter(
          data: data,
          lineColor: color,
          lineWidth: lineWidth,
        ),
      ),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  final List<double> data;
  final Color lineColor;
  final double lineWidth;

  _SparklinePainter({
    required this.data,
    required this.lineColor,
    required this.lineWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = lineWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    double maxVal = data.reduce(max);
    double minVal = data.reduce(min);
    
    // Add small padding to min/max so lines don't get clipped
    double range = maxVal - minVal;
    if (range == 0) {
      maxVal += 1;
      minVal -= 1;
      range = 2;
    }
    
    final double padding = size.height * 0.1;
    final double usableHeight = size.height - (padding * 2);
    
    final double stepX = size.width / (data.length - 1 > 0 ? data.length - 1 : 1);

    final path = Path();
    for (int i = 0; i < data.length; i++) {
      final double normalizedY = (data[i] - minVal) / range;
      final double x = i * stepX;
      // Invert Y axis because Flutter canvas 0,0 is top-left
      final double y = size.height - padding - (normalizedY * usableHeight);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _SparklinePainter oldDelegate) {
    return oldDelegate.data != data ||
           oldDelegate.lineColor != lineColor ||
           oldDelegate.lineWidth != lineWidth;
  }
}
