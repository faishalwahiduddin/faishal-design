import 'package:flutter/material.dart';

import 'share_card_template.dart';
import 'stat_tile.dart';

/// A pre-built share card layout for displaying a grid of stats.
class ShareStatsCard extends StatelessWidget {
  /// The size of the card (Story or Square).
  final ShareCardSize size;

  /// Optional app icon to display in the header.
  final Widget? appIcon;

  /// The app name to display.
  final String appName;

  /// List of StatTiles to display.
  final List<StatTile> stats;

  /// Optional motivational quote.
  final String? quote;

  const ShareStatsCard({
    super.key,
    required this.stats,
    this.size = ShareCardSize.story,
    this.appIcon,
    this.appName = 'faishal.id',
    this.quote,
  });

  @override
  Widget build(BuildContext context) {
    return ShareCardTemplate(
      size: size,
      appIcon: appIcon,
      appName: appName,
      quote: quote,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'My Progress',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 64),
          // We wrap in a constrained box to ensure it fits the width nicely
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Wrap(
              spacing: 32,
              runSpacing: 32,
              alignment: WrapAlignment.center,
              children: stats.map((stat) {
                return SizedBox(
                  width: 350,
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      // Scale up the inner texts slightly for the large stat card
                      textTheme: Theme.of(context).textTheme.copyWith(
                        labelMedium: const TextStyle(fontSize: 32),
                        headlineSmall: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                        bodySmall: const TextStyle(fontSize: 24),
                      ),
                      iconTheme: const IconThemeData(size: 48),
                    ),
                    child: stat,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
