# AGENTS.md - faishal_design (Shared Flutter Design Package)

> Guidelines for AI agents working in this Dart/Flutter package.

## Quick Commands

```bash
flutter test                       # Run all tests
dart analyze                       # Static analysis
dart format .                      # Format code
dart run build_runner build        # Generate code
# Package manager: flutter pub
```

## Project Overview

**faishal_design** — Shared Dart package providing Material 3 theme, reusable widgets, and utilities for all faishal.id Flutter apps. Used as a git dependency by: dzikir, almatsurat, mutabaah, doa, apps, portfolio.

- **Type**: Dart package (not a standalone app)
- Full spec in [`docs/PRD.md`](./docs/PRD.md)

## Documentation

| Doc | Purpose |
|-----|---------|
| [`docs/PRD.md`](./docs/PRD.md) | Package requirements & design system spec |
| [`CLAUDE.md`](./CLAUDE.md) | Claude Code specific instructions |
| [`GEMINI.md`](./GEMINI.md) | Gemini/Jules specific instructions |

## Domain Terminology

| Term (ID) | Term (EN) | Term (AR) | Context |
|-----------|-----------|-----------|---------|
| Tema gelap | Dark theme | الوضع الداكن | Theme mode |
| Tema terang | Light theme | الوضع الفاتح | Theme mode |
| Bahasa | Language | اللغة | Locale switching |
| Kanan ke kiri | Right to left | من اليمين لليسار | RTL layout |

## Mandatory Rules

1. **All public APIs must be exported** via `lib/faishal_design.dart` barrel file
2. **Use Riverpod** for theme/locale state — no other state management
3. **All widgets must support RTL** — test with Arabic locale
4. **All widgets must be responsive** — mobile (<600dp), tablet (600-1024dp), desktop (>1024dp)
5. **Default locale is `id`** (Bahasa Indonesia) — never change this default
6. **Run `dart analyze`** before every commit — zero warnings
7. **Write widget tests** for every public widget
8. **Material 3 only** — no Material 2 or custom design tokens outside the theme

## Code Conventions

- **Naming**: snake_case files, PascalCase classes, camelCase methods/variables
- **Imports**: Dart SDK → Flutter SDK → external packages → internal files
- **Exports**: Only export via barrel file `faishal_design.dart`
- **Colors**: Use `AppColors` constants — never hardcode hex values in widgets
- **Typography**: Use `AppTypography` — never create TextStyle inline
- **Theme**: Access via `Theme.of(context)` — never reference AppTheme directly in consumer code
- **Providers**: Use `@riverpod` annotation for code generation

## Design System Spec

```
Primary:    #2E7D32 (Islamic green)
OnPrimary:  #FFFFFF
Secondary:  #1565C0
Surface:    #FAFAFA (light) / #121212 (dark)
Font Latin: Poppins (Google Fonts)
Font Arab:  Amiri (Google Fonts)
Breakpoint: mobile <600dp | tablet 600-1024dp | desktop >1024dp
```
