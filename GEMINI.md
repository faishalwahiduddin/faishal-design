# GEMINI.md

This file provides guidance to Gemini when working in this repository.

> **Full context lives in `AGENTS.md`** — read it before doing anything.

## Quick Commands

```bash
flutter test                       # Run all tests
dart analyze                       # Static analysis (run before committing)
dart format .                      # Format code
dart run build_runner build        # Generate code
```

## Key Notes for Gemini

- Gemini: read AGENTS.md first, then proceed with standard workflow
- **This is a Dart package, not a standalone app** — no `flutter run`
- Shared design system for all faishal.id Flutter apps
- Material 3 theme with light/dark mode
- Default locale: `id` (Bahasa Indonesia), supported: id, en, ar, jv, su, zh, ja
- All widgets must support RTL (Arabic) and responsive layouts
- Export all public APIs via `lib/faishal_design.dart` barrel file
- Use Riverpod for theme/locale state
- Run `dart analyze` before every commit — zero warnings
- Consumer apps reference via git dependency in pubspec.yaml

## Jules Task Hints

- When scaffolding: create theme, widgets, l10n, and utils modules first
- Test each widget with both LTR and RTL locales
- Ensure SharedPreferences persistence for theme and language selection
