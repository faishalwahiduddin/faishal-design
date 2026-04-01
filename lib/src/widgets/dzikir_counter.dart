import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';

/// Style variants for DzikirCounter.
enum DzikirCounterStyle {
  /// Large circular ring — hero element for detail/focus pages.
  ring,

  /// Full-width tappable bar with compact ring — for inline card use.
  bar,
}

/// Unified counter widget for dzikir/tasbih counting.
///
/// Two styles:
/// - [DzikirCounterStyle.ring]: 160px (default) circular segmented progress ring
/// - [DzikirCounterStyle.bar]: full-width tappable bar with compact 48px ring
///
/// Features: segmented progress arc, scale bounce, ripple pulse,
/// completion glow, explicit reset button.
class DzikirCounter extends StatefulWidget {
  final int current;
  final int target;
  final VoidCallback? onTap;
  final VoidCallback? onReset;
  final DzikirCounterStyle style;
  final double? size;

  const DzikirCounter({
    super.key,
    required this.current,
    required this.target,
    this.onTap,
    this.onReset,
    this.style = DzikirCounterStyle.ring,
    this.size,
  });

  @override
  State<DzikirCounter> createState() => _DzikirCounterState();
}

class _DzikirCounterState extends State<DzikirCounter>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _rippleController;
  late AnimationController _glowController;

  bool get _completed => widget.current >= widget.target;
  double get _progress =>
      widget.target > 0 ? (widget.current / widget.target).clamp(0.0, 1.0) : 0;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
      reverseDuration: const Duration(milliseconds: 200),
    );
    _rippleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void didUpdateWidget(DzikirCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Tap feedback: bounce + ripple when current increments
    if (widget.current > oldWidget.current && !_completed) {
      _playTapFeedback();
    }
    // Completion feedback
    if (!_wasCompleted(oldWidget) && _completed) {
      _playCompletionFeedback();
    }
  }

  bool _wasCompleted(DzikirCounter old) => old.current >= old.target;

  void _playTapFeedback() {
    _scaleController.forward().then((_) {
      if (mounted) _scaleController.reverse();
    });
    _rippleController.forward(from: 0);
  }

  void _playCompletionFeedback() {
    HapticFeedback.mediumImpact();
    _glowController.forward(from: 0);
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _rippleController.dispose();
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
    return switch (widget.style) {
      DzikirCounterStyle.ring => _buildRingStyle(context),
      DzikirCounterStyle.bar => _buildBarStyle(context),
    };
  }

  // ─── Ring Style (Detail Page) ─────────────────────────────────

  Widget _buildRingStyle(BuildContext context) {
    final theme = Theme.of(context);
    final ringSize = widget.size ?? 160.0;
    final strokeWidth = 10.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Glow wrapper
        AnimatedBuilder(
          animation: _glowController,
          builder: (context, child) {
            final glowValue = _glowController.value;
            final glowCurve = Curves.easeOut.transform(glowValue);
            return Container(
              decoration: _completed && _glowController.isAnimating
                  ? BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.completedGreen
                              .withValues(alpha: 0.35 * (1 - glowCurve)),
                          blurRadius: 24 * glowCurve,
                          spreadRadius: 8 * glowCurve,
                        ),
                      ],
                    )
                  : null,
              child: child,
            );
          },
          child: // Scale bounce wrapper
              AnimatedBuilder(
            animation: _scaleController,
            builder: (context, child) {
              final scale = 1.0 - (_scaleController.value * 0.08);
              return Transform.scale(scale: scale, child: child);
            },
            child: GestureDetector(
              onTap: _handleTap,
              behavior: HitTestBehavior.opaque,
              child: SizedBox(
                width: ringSize,
                height: ringSize,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Ripple pulse
                    AnimatedBuilder(
                      animation: _rippleController,
                      builder: (context, _) {
                        if (!_rippleController.isAnimating) {
                          return const SizedBox.shrink();
                        }
                        return CustomPaint(
                          size: Size(ringSize, ringSize),
                          painter: _RipplePainter(
                            progress: _rippleController.value,
                            color: theme.colorScheme.primary,
                            ringRadius: (ringSize / 2) - strokeWidth,
                          ),
                        );
                      },
                    ),
                    // Segmented ring
                    CustomPaint(
                      size: Size(ringSize, ringSize),
                      painter: _SegmentedArcPainter(
                        current: widget.current,
                        target: widget.target,
                        trackColor: theme.brightness == Brightness.dark
                            ? AppColors.iosFillDark
                            : AppColors.iosFillLight,
                        progressColor: theme.colorScheme.primary,
                        completedColor: AppColors.completedGreen,
                        strokeWidth: strokeWidth,
                        completed: _completed,
                      ),
                    ),
                    // Center content
                    _buildRingContent(theme),
                  ],
                ),
              ),
            ),
          ),
        ),
        // Reset button
        if (widget.current > 0 && widget.onReset != null) ...[
          const SizedBox(height: 10),
          _buildResetButton(theme),
        ],
      ],
    );
  }

  Widget _buildRingContent(ThemeData theme) {
    if (_completed) {
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: Icon(
          Icons.check_rounded,
          key: const ValueKey('check'),
          color: AppColors.completedGreen,
          size: 36,
        ),
      );
    }
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 150),
      child: Column(
        key: ValueKey(widget.current),
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${widget.current}',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
          Container(
            width: 20,
            height: 1,
            color: theme.colorScheme.outline.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 2),
          Text(
            '${widget.target}',
            style: TextStyle(
              fontSize: 12,
              color: theme.colorScheme.onSurfaceVariant,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }

  // ─── Bar Style (Reading Card) ─────────────────────────────────

  Widget _buildBarStyle(BuildContext context) {
    final theme = Theme.of(context);
    const ringSize = 48.0;
    const strokeWidth = 6.0;

    return AnimatedBuilder(
      animation: _scaleController,
      builder: (context, child) {
        final scale = 1.0 - (_scaleController.value * 0.03);
        return Transform.scale(scale: scale, child: child);
      },
      child: GestureDetector(
        onTap: _handleTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedBuilder(
          animation: _glowController,
          builder: (context, child) {
            final bgColor = _completed
                ? AppColors.completedGreen.withValues(
                    alpha: 0.12 + (_glowController.isAnimating
                        ? 0.08 * (1 - _glowController.value)
                        : 0),
                  )
                : theme.brightness == Brightness.dark
                    ? AppColors.iosFillDark
                    : AppColors.iosFillLight;
            return Container(
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: child,
            );
          },
          child: Row(
            children: [
              // Compact ring
              SizedBox(
                width: ringSize,
                height: ringSize,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(
                      size: const Size(ringSize, ringSize),
                      painter: _SegmentedArcPainter(
                        current: widget.current,
                        target: widget.target,
                        trackColor: theme.brightness == Brightness.dark
                            ? Colors.white.withValues(alpha: 0.1)
                            : Colors.black.withValues(alpha: 0.06),
                        progressColor: theme.colorScheme.primary,
                        completedColor: AppColors.completedGreen,
                        strokeWidth: strokeWidth,
                        completed: _completed,
                      ),
                    ),
                    if (_completed)
                      Icon(Icons.check_rounded,
                          color: AppColors.completedGreen, size: 20)
                    else
                      Text(
                        '${widget.current}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface,
                          fontFeatures: const [FontFeature.tabularFigures()],
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Count text
              Expanded(
                child: Text(
                  _completed
                      ? '${widget.target} / ${widget.target}'
                      : '${widget.current} / ${widget.target}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _completed
                        ? AppColors.completedGreen
                        : theme.colorScheme.onSurface,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ),
              // Reset button
              if (widget.current > 0 && widget.onReset != null)
                GestureDetector(
                  onTap: widget.onReset,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      Icons.refresh_rounded,
                      size: 18,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Shared ───────────────────────────────────────────────────

  Widget _buildResetButton(ThemeData theme) {
    return GestureDetector(
      onTap: widget.onReset,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.refresh_rounded, size: 13, color: theme.colorScheme.primary),
          const SizedBox(width: 4),
          Text(
            'Reset',
            style: TextStyle(fontSize: 13, color: theme.colorScheme.primary),
          ),
        ],
      ),
    );
  }
}

// ─── Segmented Arc Painter ────────────────────────────────────────

class _SegmentedArcPainter extends CustomPainter {
  final int current;
  final int target;
  final Color trackColor;
  final Color progressColor;
  final Color completedColor;
  final double strokeWidth;
  final bool completed;

  _SegmentedArcPainter({
    required this.current,
    required this.target,
    required this.trackColor,
    required this.progressColor,
    required this.completedColor,
    required this.strokeWidth,
    required this.completed,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - (strokeWidth / 2) - 2;
    final effectiveStroke = completed ? strokeWidth + 2 : strokeWidth;

    if (target <= 1) {
      _paintSingleArc(canvas, center, radius, effectiveStroke);
      return;
    }

    final gapAngle = target <= 10 ? 0.04 : 0.03; // radians between segments
    final totalGap = gapAngle * target;
    final totalArc = 2 * pi - totalGap;
    final segmentAngle = totalArc / target;
    final startOffset = -pi / 2; // start from top

    for (int i = 0; i < target; i++) {
      final segStart = startOffset + i * (segmentAngle + gapAngle);
      final isFilled = i < current;

      // Determine color: last third uses completedColor when filled
      Color color;
      if (!isFilled) {
        color = trackColor;
      } else if (completed) {
        color = completedColor;
      } else if (i >= (target * 0.66).floor()) {
        color = completedColor;
      } else {
        color = progressColor;
      }

      final paint = Paint()
        ..color = color
        ..strokeWidth = effectiveStroke
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        segStart,
        segmentAngle,
        false,
        paint,
      );
    }
  }

  void _paintSingleArc(
      Canvas canvas, Offset center, double radius, double strokeWidth) {
    // Track
    final trackPaint = Paint()
      ..color = trackColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, trackPaint);

    // Progress
    if (current > 0) {
      final progressPaint = Paint()
        ..color = completed ? completedColor : progressColor
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;
      canvas.drawCircle(center, radius, progressPaint);
    }
  }

  @override
  bool shouldRepaint(_SegmentedArcPainter old) =>
      old.current != current ||
      old.target != target ||
      old.trackColor != trackColor ||
      old.completed != completed;
}

// ─── Ripple Painter ───────────────────────────────────────────────

class _RipplePainter extends CustomPainter {
  final double progress;
  final Color color;
  final double ringRadius;

  _RipplePainter({
    required this.progress,
    required this.color,
    required this.ringRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final expandRadius = ringRadius + (20 * progress);
    final opacity = 0.15 * (1 - progress);

    final paint = Paint()
      ..color = color.withValues(alpha: opacity)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, expandRadius, paint);
  }

  @override
  bool shouldRepaint(_RipplePainter old) => old.progress != progress;
}
