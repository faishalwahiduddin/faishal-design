import 'package:flutter/material.dart';

/// Per-app seed colors for Material 3 color scheme generation.
///
/// Each value represents the unique brand identity of a faishal.id app.
/// Pass the appropriate [AppSeed] to [AppTheme.light] or [AppTheme.dark]
/// to generate a harmonious color scheme for that app.
enum AppSeed {
  /// Apps Hub – Islamic green (#2E7D32)
  appsHub(Color(0xFF2E7D32)),

  /// Portfolio (#2C3E7A)
  portfolio(Color(0xFF2C3E7A)),

  /// Mutabaah – deep Islamic green (#1B5E20)
  mutabaah(Color(0xFF1B5E20)),

  /// Tilawah – teal (#004D40)
  tilawah(Color(0xFF004D40)),

  /// Dzikir – indigo (#283593)
  dzikir(Color(0xFF283593)),

  /// Al-Matsurat – deep orange (#E65100)
  almatsurat(Color(0xFFE65100)),

  /// Doa – deep indigo (#1A237E)
  doa(Color(0xFF1A237E)),

  /// Rawatib – light green (#33691E)
  rawatib(Color(0xFF33691E));

  const AppSeed(this.color);

  /// The seed [Color] used to generate the Material 3 color scheme.
  final Color color;
}
