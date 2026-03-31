import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';

/// Circular progress ring counter for tasbih/dzikir counting.
/// Shows current/target with animated progress ring, completion glow,
/// and optional reset button.
class TasbihCounter extends StatefulWidget {
  final int current;
  final int target;
  final VoidCallback? onTap;
  final VoidCallback? onReset;
  final double size;

  const TasbihCounter({
    super.key,
    required this.current,
    required this.target,
    this.onTap,
    this.onReset,
    this.size = 100,
  });

  @override
  State<TasbihCounter> createState() => _TasbihCounterState();
}

class _TasbihCounterState extends State<TasbihCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _glowController;

  bool get _completed => widget.current >= widget.target;
  double get _progress =>
      widget.target > 0 ? (widget.current / widget.target).clamp(0.0, 1.0) : 0;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
  }

  @override
  void didUpdateWidget(TasbihCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_wasCompleted(oldWidget) && _completed) {
      _glowController.repeat(reverse: true, count: 3);
      HapticFeedback.mediumImpact();
    }
  }

  bool _wasCompleted(TasbihCounter old) => old.current >= old.target;

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (_completed || widget.onTap == null) return;
    HapticFeedback.lightImpact();
    widget.onTap!();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final isDark = theme.brightness == Brightness.dark;
    final fillColor = isDark ? AppColors.iosFillDark : AppColors.iosFillLight;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBuilder(
          animation: _glowController,
          builder: (context, child) {
            final glowOpacity = _glowController.isAnimating
                ? (_glowController.value * 0.3 + 0.1)
                : 0.0;
            return Container(
              decoration: _completed && _glowController.isAnimating
                  ? BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withValues(alpha: glowOpacity),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    )
                  : null,
              child: child,
            );
          },
          child: GestureDetector(
            onTap: _handleTap,
            child: SizedBox(
              width: widget.size,
              height: widget.size,
              child: CustomPaint(
                painter: _TasbihRingPainter(
                  progress: _progress,
                  trackColor: fillColor,
                  progressColor: primaryColor,
                  completed: _completed,
                ),
                child: Center(
                  child: _completed
                      ? Icon(Icons.check, color: primaryColor, size: 28)
                      : Text(
                          '${widget.current}/${widget.target}',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurface,
                            fontFeatures: const [FontFeature.tabularFigures()],
                          ),
                        ),
                ),
              ),
            ),
          ),
        ),
        if (widget.current > 0 && widget.onReset != null) ...[
          const SizedBox(height: 8),
          GestureDetector(
            onTap: widget.onReset,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.refresh, size: 13, color: primaryColor),
                const SizedBox(width: 4),
                Text(
                  'Reset',
                  style: TextStyle(fontSize: 13, color: primaryColor),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _TasbihRingPainter extends CustomPainter {
  final double progress;
  final Color trackColor;
  final Color progressColor;
  final bool completed;

  _TasbihRingPainter({
    required this.progress,
    required this.trackColor,
    required this.progressColor,
    required this.completed,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - 4;
    final strokeWidth = completed ? 5.0 : 4.0;

    // Track
    final trackPaint = Paint()
      ..color = trackColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, trackPaint);

    // Progress arc
    if (progress > 0) {
      final progressPaint = Paint()
        ..color = progressColor
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -pi / 2,
        2 * pi * progress,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_TasbihRingPainter old) =>
      old.progress != progress ||
      old.trackColor != trackColor ||
      old.completed != completed;
}
