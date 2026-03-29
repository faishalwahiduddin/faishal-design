# PRD: faishal_design — Shared Flutter Design Package

## 1. Overview

**faishal_design** adalah shared Dart package yang menyediakan design system konsisten untuk seluruh ekosistem aplikasi Flutter faishal.id. Package ini menjadi satu-satunya sumber kebenaran untuk tema, warna, tipografi, widget reusable, dan utilitas yang digunakan oleh 6 aplikasi: dzikir, almatsurat, mutabaah, doa, apps, dan portfolio.

## 2. Problem Statement

Tanpa design system terpusat, setiap aplikasi akan mengembangkan tema dan komponen sendiri-sendiri, menghasilkan inkonsistensi visual dan duplikasi kode. Pengguna yang berpindah antar aplikasi akan merasakan pengalaman yang berbeda-beda.

## 3. Target Users

- **Primary**: Developer (Claude, Jules, Gemini) yang membangun 6 Flutter apps
- **Secondary**: End users yang menggunakan semua aplikasi dan mengharapkan konsistensi

## 4. Features

### 4.1 MVP Features

#### Theme System
- Material 3 ThemeData dengan light dan dark mode
- Color scheme: Islamic green (#2E7D32) sebagai primary
- Typography: Poppins (Latin), Amiri (Arabic)
- Automatic system theme detection
- Manual toggle dengan persistence via SharedPreferences

#### Widget Library
- **LanguageSwitcher**: Dropdown/bottom sheet pemilih bahasa dengan flag icon
- **ThemeSwitcher**: Toggle button dark/light mode (sun/moon icon)
- **ResponsiveLayout**: Builder widget dengan breakpoints mobile/tablet/desktop
- **RtlAware**: Wrapper yang mendeteksi locale dan set Directionality
- **AppScaffold**: Common scaffold dengan AppBar, drawer/rail navigation, theme & language controls

#### Localization
- SharedLocalizationDelegate untuk 7 bahasa: id (default), en, ar, jv, su, zh, ja
- Bahasa Indonesia sebagai default
- Fallback ke Bahasa Indonesia jika terjemahan tidak tersedia

#### Utilities
- **JsonLoader**: Helper untuk load dan parse JSON dari assets
- **SeoUtils**: Web SEO meta tag helpers (title, description, OG tags)

### 4.2 Future Features
- Animasi transisi custom antar halaman
- Komponen form standar (text field, dropdown, date picker)
- Bottom navigation bar template
- Splash screen template

## 5. Design System Specification

### Color Palette

| Token | Light | Dark | Usage |
|-------|-------|------|-------|
| primary | #2E7D32 | #66BB6A | Buttons, links, active states |
| onPrimary | #FFFFFF | #000000 | Text on primary |
| secondary | #1565C0 | #42A5F5 | Secondary actions |
| surface | #FAFAFA | #121212 | Card backgrounds |
| background | #FFFFFF | #1E1E1E | Page backgrounds |
| error | #D32F2F | #EF5350 | Error states |
| onSurface | #212121 | #E0E0E0 | Body text |

### Typography Scale

| Style | Font | Size | Weight | Usage |
|-------|------|------|--------|-------|
| displayLarge | Poppins | 32sp | Bold | Page titles |
| headlineMedium | Poppins | 24sp | SemiBold | Section headers |
| titleLarge | Poppins | 20sp | Medium | Card titles |
| bodyLarge | Poppins | 16sp | Regular | Body text |
| bodyMedium | Poppins | 14sp | Regular | Secondary text |
| labelLarge | Poppins | 14sp | Medium | Buttons |
| arabicLarge | Amiri | 28sp | Regular | Arabic text display |
| arabicMedium | Amiri | 22sp | Regular | Arabic text in lists |

### Responsive Breakpoints

| Breakpoint | Width | Layout |
|------------|-------|--------|
| Mobile | < 600dp | Single column, bottom nav |
| Tablet | 600-1024dp | Two column, rail nav |
| Desktop | > 1024dp | Three column, side nav |

### Spacing Scale
- xs: 4dp, sm: 8dp, md: 16dp, lg: 24dp, xl: 32dp, xxl: 48dp

## 6. Supported Locales

| Code | Language | Direction | Default |
|------|----------|-----------|---------|
| id | Bahasa Indonesia | LTR | **Ya (default)** |
| en | English | LTR | — |
| ar | العربية | **RTL** | — |
| jv | Basa Jawa | LTR | — |
| su | Basa Sunda | LTR | — |
| zh | 中文 | LTR | — |
| ja | 日本語 | LTR | — |

## 7. Technical Architecture

### Package Structure
```
lib/
  faishal_design.dart              # Barrel export
  src/
    theme/
      app_theme.dart               # ThemeData factory
      app_colors.dart              # Color constants
      app_typography.dart          # TextStyle definitions
    widgets/
      language_switcher.dart
      theme_switcher.dart
      responsive_layout.dart
      rtl_aware.dart
      app_scaffold.dart
    l10n/
      app_localizations.dart
    utils/
      json_loader.dart
      seo_utils.dart
```

### Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  google_fonts: ^6.2.0
  shared_preferences: ^2.3.0
  flutter_riverpod: ^2.6.0
  riverpod_annotation: ^2.6.0
```

## 8. Integration Pattern

Consumer apps add to `pubspec.yaml`:
```yaml
dependencies:
  faishal_design:
    git:
      url: git@github.com:faishalwahiduddin/faishal-design.git
      ref: main
```

In `main.dart`:
```dart
import 'package:faishal_design/faishal_design.dart';

void main() {
  runApp(
    ProviderScope(
      child: FaishalApp(
        title: 'App Name',
        routerConfig: appRouter,
      ),
    ),
  );
}
```

## 9. Testing Requirements

- Widget test untuk setiap public widget
- Test light dan dark theme rendering
- Test RTL layout dengan locale Arabic
- Test responsive breakpoints (mobile, tablet, desktop)
- Test language switcher persistence
- Test theme switcher persistence

## 10. Success Metrics

- Semua 6 aplikasi menggunakan faishal_design tanpa custom ThemeData
- Konsistensi visual 100% antar aplikasi
- Dark/light mode berfungsi di semua aplikasi
- Language switcher berfungsi di semua aplikasi
- Zero warnings dari `dart analyze`

## 11. Implementation Phases

| Phase | Deliverable | Priority |
|-------|------------|----------|
| 1 | Theme (colors, typography, ThemeData) | P0 |
| 2 | ThemeSwitcher + LanguageSwitcher widgets | P0 |
| 3 | ResponsiveLayout + RtlAware widgets | P0 |
| 4 | AppScaffold + JsonLoader + SeoUtils | P1 |
| 5 | Tests + documentation | P1 |
