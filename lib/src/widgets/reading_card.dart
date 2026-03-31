import 'package:flutter/material.dart';

/// Content card shell with optional colored left border (3px),
/// rounded-xl corners, and proper padding.
/// Used as a container for dzikir/doa reading cards.
class ReadingCard extends StatelessWidget {
  final Widget child;
  final Color? accentColor;
  final EdgeInsetsGeometry padding;
  final bool dimmed;

  const ReadingCard({
    super.key,
    required this.child,
    this.accentColor,
    this.padding = const EdgeInsets.all(16),
    this.dimmed = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Opacity(
      opacity: dimmed ? 0.6 : 1.0,
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(12),
          border: accentColor != null
              ? Border(
                  left: BorderSide(color: accentColor!, width: 3),
                )
              : null,
        ),
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
