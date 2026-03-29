# faishal_design — Shared Flutter Design Package

## Overview
Shared Dart package providing consistent Material 3 theme, widgets, and utilities across all faishal.id Flutter apps. Referenced as a git dependency by: dzikir, almatsurat, mutabaah, doa, apps, portfolio.

## Tech Stack
- Flutter 3.x / Dart
- Material 3 (Material You)
- Google Fonts (Poppins for Latin, Amiri for Arabic)
- SharedPreferences (theme/language persistence)

## Architecture
```
lib/
  faishal_design.dart              # Barrel export
  src/
    theme/
      app_theme.dart               # ThemeData (light + dark)
      app_colors.dart              # Brand color palette
      app_typography.dart          # TextStyle definitions
    widgets/
      language_switcher.dart       # Language picker dropdown
      theme_switcher.dart          # Dark/light mode toggle
      responsive_layout.dart       # Mobile/Tablet/Desktop breakpoints
      rtl_aware.dart               # RTL layout support (Arabic)
      app_scaffold.dart            # Common scaffold with nav + controls
    l10n/
      app_localizations.dart       # Shared localization delegate
    utils/
      json_loader.dart             # Load .json assets
      seo_utils.dart               # Web SEO meta helpers
```

## Design System
- **Primary color:** Islamic green (#2E7D32 light, #66BB6A dark)
- **Default locale:** Bahasa Indonesia (id)
- **Supported locales:** id, en, ar, jv, su, zh, ja
- **Theme:** Material 3 with light/dark variants, system preference detection
- **Breakpoints:** mobile (<600dp), tablet (600-1024dp), desktop (>1024dp)
- **Arabic support:** Full RTL layout with Amiri font

## Commands
```bash
flutter test                       # Run all tests
dart analyze                       # Static analysis
dart format .                      # Format code
dart run build_runner build        # Generate code
```

## Conventions
- All public APIs must be exported via `faishal_design.dart`
- Use Riverpod providers for theme/locale state
- All widgets must support RTL
- All widgets must be responsive (mobile/tablet/desktop)
- Write widget tests for every public widget
- Default language is always Bahasa Indonesia (id)

## Consumer Apps
Apps reference this package in pubspec.yaml:
```yaml
dependencies:
  faishal_design:
    git:
      url: git@github.com:faishalwahiduddin/faishal-design.git
      ref: main
```
