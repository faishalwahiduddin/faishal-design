import 'dart:async';
import 'package:flutter/material.dart';

import '../models/celebration_type.dart';
import '../utils/celebration_controller.dart';
import '../utils/confetti_painter.dart';
import '../../theme/app_typography.dart';

/// A full-screen celebration overlay widget for milestones.
class MilestoneCelebration extends StatefulWidget {
  /// Creates a milestone celebration overlay.
  const MilestoneCelebration({
    super.key,
    required this.type,
    required this.title,
    required this.subtitle,
    this.xpEarned,
    this.icon,
    this.badgeImage,
    this.onDismiss,
  });

  /// The type of celebration.
  final CelebrationType type;

  /// The title of the celebration.
  final String title;

  /// The subtitle of the celebration.
  final String subtitle;

  /// Optional XP earned to display.
  final int? xpEarned;

  /// Optional icon to display.
  final Widget? icon;

  /// Optional badge image provider.
  final ImageProvider? badgeImage;

  /// Callback when the celebration is dismissed.
  final VoidCallback? onDismiss;

  @override
  State<MilestoneCelebration> createState() => _MilestoneCelebrationState();
}

class _MilestoneCelebrationState extends State<MilestoneCelebration>
    with SingleTickerProviderStateMixin {
  late CelebrationController _celebrationController;
  Timer? _dismissTimer;

  @override
  void initState() {
    super.initState();
    _celebrationController = CelebrationController(this);

    // Start celebration animation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _celebrationController.play();
        // Auto-dismiss after 3 seconds
        _dismissTimer = Timer(const Duration(seconds: 3), _dismiss);
      }
    });
  }

  @override
  void dispose() {
    _dismissTimer?.cancel();
    _celebrationController.dispose();
    super.dispose();
  }

  void _dismiss() {
    if (mounted) {
      widget.onDismiss?.call();
    }
  }

  Widget _buildIcon(BuildContext context) {
    if (widget.badgeImage != null) {
      return Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: widget.badgeImage!,
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
      );
    }

    if (widget.icon != null) {
      return Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Center(
          child: IconTheme(
            data: IconThemeData(
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
            child: widget.icon!,
          ),
        ),
      );
    }

    // Default icon based on type
    IconData defaultIconData;
    switch (widget.type) {
      case CelebrationType.badgeUnlock:
        defaultIconData = Icons.emoji_events;
        break;
      case CelebrationType.levelUp:
        defaultIconData = Icons.arrow_upward;
        break;
      case CelebrationType.streakMilestone:
        defaultIconData = Icons.local_fire_department;
        break;
      case CelebrationType.khatam:
        defaultIconData = Icons.menu_book;
        break;
      case CelebrationType.custom:
        defaultIconData = Icons.star;
        break;
    }

    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Center(
        child: Icon(
          defaultIconData,
          size: 64,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        _dismissTimer?.cancel();
        _dismiss();
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            // Semi-transparent background
            Positioned.fill(
              child: Container(
                color: (isDark ? Colors.black : Colors.white).withValues(
                  alpha: 0.85,
                ),
              ),
            ),

            // Main content
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icon/Badge with animation
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.elasticOut,
                      builder: (context, value, child) {
                        return Transform.scale(scale: value, child: child);
                      },
                      child: _buildIcon(context),
                    ),
                    const SizedBox(height: 32),

                    // Title
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: Transform.translate(
                            offset: Offset(0, 20 * (1 - value)),
                            child: child,
                          ),
                        );
                      },
                      child: Text(
                        widget.title,
                        style: AppTypography.displayLarge.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Subtitle
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: Transform.translate(
                            offset: Offset(0, 20 * (1 - value)),
                            child: child,
                          ),
                        );
                      },
                      child: Text(
                        widget.subtitle,
                        style: AppTypography.titleLarge.copyWith(
                          color: theme.colorScheme.onSurface,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // XP Earned (Optional)
                    if (widget.xpEarned != null && widget.xpEarned! > 0)
                      TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.0, end: 1.0),
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeOut,
                        builder: (context, value, child) {
                          return Opacity(
                            opacity: value,
                            child: Transform.scale(
                              scale: 0.8 + (0.2 * value),
                              child: child,
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.secondary.withValues(
                              alpha: 0.1,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: theme.colorScheme.secondary.withValues(
                                alpha: 0.3,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.star,
                                color: theme.colorScheme.secondary,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '+${widget.xpEarned} XP',
                                style: AppTypography.labelLarge.copyWith(
                                  color: theme.colorScheme.secondary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    
                    const SizedBox(height: 48),
                    
                    // Tap to dismiss hint
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeIn,
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: child,
                        );
                      },
                      child: Text(
                        'Ketuk untuk menutup',
                        style: AppTypography.bodyMedium.copyWith(
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Confetti Animation
            ListenableBuilder(
              listenable: _celebrationController,
              builder: (context, child) {
                if (!_celebrationController.isPlaying) {
                  return const SizedBox.shrink();
                }

                return Positioned.fill(
                  child: RepaintBoundary(
                    child: CustomPaint(
                      painter: ConfettiPainter(
                        particles: _celebrationController.particles,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
