import 'package:flutter/material.dart';

class StreakFlame extends StatefulWidget {
  final int streakDays;

  const StreakFlame({
    super.key,
    required this.streakDays,
  });

  @override
  State<StreakFlame> createState() => _StreakFlameState();
}

class _StreakFlameState extends State<StreakFlame>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    if (widget.streakDays > 0) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant StreakFlame oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.streakDays > 0 && oldWidget.streakDays == 0) {
      _controller.repeat(reverse: true);
    } else if (widget.streakDays == 0 && oldWidget.streakDays > 0) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Scale flame icon based on streak size (maxes out around 30 days)
    final double baseSize = 48.0;
    final double bonusSize = (widget.streakDays / 30).clamp(0.0, 1.0) * 24.0;
    final double iconSize = baseSize + bonusSize;
    
    final bool isActive = widget.streakDays > 0;
    final Color flameColor = isActive ? Colors.deepOrange : Colors.grey;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: isActive ? _scaleAnimation.value : 1.0,
              child: Icon(
                isActive ? Icons.local_fire_department : Icons.local_fire_department_outlined,
                size: iconSize,
                color: flameColor,
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        Text(
          '${widget.streakDays}',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: isActive ? theme.colorScheme.onSurface : Colors.grey,
          ),
        ),
        Text(
          'Hari',
          style: theme.textTheme.labelMedium?.copyWith(
            color: isActive ? theme.colorScheme.onSurfaceVariant : Colors.grey,
          ),
        ),
      ],
    );
  }
}
