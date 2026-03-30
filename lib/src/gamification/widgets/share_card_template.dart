import 'dart:math';

import 'package:flutter/material.dart';

import '../constants/motivational_quotes.dart';

/// Supported sizes for the share card.
enum ShareCardSize {
  /// Instagram Story size: 1080x1920
  story,

  /// Square feed size: 1080x1080
  square,
}

/// A branded image card template for sharing gamification stats, achievements, etc.
/// This widget provides the basic layout with app icon, branding, and a footer
/// containing a motivational quote, wrapping an arbitrary [child] widget.
class ShareCardTemplate extends StatelessWidget {
  /// The app-specific content to display in the center.
  final Widget child;

  /// The dimensions of the card.
  final ShareCardSize size;

  /// Optional app icon to display in the top-left corner.
  final Widget? appIcon;

  /// The name of the app to display next to the [appIcon].
  final String appName;

  /// Optional specific quote to display in the footer. If null, a random one
  /// is picked from [motivationalQuotes].
  final String? quote;

  const ShareCardTemplate({
    super.key,
    required this.child,
    this.size = ShareCardSize.story,
    this.appIcon,
    this.appName = 'faishal.id',
    this.quote,
  });

  @override
  Widget build(BuildContext context) {
    // Determine exact pixel dimensions based on chosen preset.
    // We render this in a specific fixed logical pixel size which
    // is large enough to get a high-quality capture (e.g., 1080x1920).
    final double width = 1080.0;
    final double height = size == ShareCardSize.story ? 1920.0 : 1080.0;

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Use a fixed palette for branding
    final bgColor = isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF8F9FA);
    final primaryColor = const Color(0xFF1F5E3D); // Islamic Green accent
    final textColor = isDark ? Colors.white : Colors.black87;
    final mutedTextColor = isDark ? Colors.white70 : Colors.black54;

    final displayQuote =
        quote ??
        motivationalQuotes[Random().nextInt(motivationalQuotes.length)];

    return Container(
      width: width,
      height: height,
      color: bgColor,
      child: Stack(
        children: [
          // Background accent element (e.g., subtle geometric pattern or gradient)
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor.withValues(alpha: 0.05),
              ),
            ),
          ),
          Positioned(
            bottom: -150,
            left: -100,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor.withValues(alpha: 0.05),
              ),
            ),
          ),

          // Green accent bar on top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(height: 16, color: primaryColor),
          ),

          // Main layout
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 64.0,
              vertical: 80.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize:
                  MainAxisSize.min, // Avoid overflowing fixed size in tests
              children: [
                // Header: App Icon + Branding
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          if (appIcon != null) ...[
                            SizedBox(width: 80, height: 80, child: appIcon),
                            const SizedBox(width: 24),
                          ],
                          Expanded(
                            child: Text(
                              appName,
                              style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                                fontFamily: 'Poppins',
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'faishal.id',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),

                // Flexible spacer to center content
                const Spacer(flex: 2),

                // Center Content Area
                Center(
                  child: Theme(
                    // Ensure the child widget uses a larger base font size to scale
                    // properly within the 1080px wide canvas.
                    data: theme.copyWith(
                      textTheme: theme.textTheme.copyWith(
                        headlineMedium: theme.textTheme.headlineMedium
                            ?.copyWith(fontSize: 64),
                        titleLarge: theme.textTheme.titleLarge?.copyWith(
                          fontSize: 48,
                        ),
                        bodyLarge: theme.textTheme.bodyLarge?.copyWith(
                          fontSize: 36,
                        ),
                        bodyMedium: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 28,
                        ),
                        bodySmall: theme.textTheme.bodySmall?.copyWith(
                          fontSize: 24,
                        ),
                      ),
                    ),
                    child: child,
                  ),
                ),

                const Spacer(flex: 3),

                // Footer: Motivational quote
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 48,
                      vertical: 32,
                    ),
                    decoration: BoxDecoration(
                      color: primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(
                        color: primaryColor.withValues(alpha: 0.2),
                        width: 2,
                      ),
                    ),
                    child: Text(
                      displayQuote,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontStyle: FontStyle.italic,
                        color: mutedTextColor,
                        fontFamily: 'Amiri', // Islamic typography
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
