# AGENTS.md - faishal_design (Shared Flutter Design Package)

> Guidelines for AI agents working in this Dart/Flutter package.

## Mulai di sini (60 detik)

<!-- trace:begin start-here -->
- **App**: `faishal_design` — **paket Flutter, bukan aplikasi** (tidak ada `main()`, tidak ada direktori platform). Isinya tema Material 3 + tipografi Latin/Arab, widget baca bernuansa Islami, `QuranTextRepository` di atas `assets/data/quran_uthmani.json`, dan satu mesin gamifikasi lengkap (XP, level, streak, achievement, tantangan, kartu share). Semua API publik lewat satu barrel, `lib/faishal_design.dart`.
- **Platform & jalankan**: dikonsumsi lewat dependency path/git dari repo app lain — tidak ada `flutter run` di sini. **Per 2026-09-17 tidak ada satu pun repo di `~/projects` yang memakainya**: tidak ada `faishal_design` di `pubspec.yaml` mana pun dan tidak ada `.dart` yang meng-import `package:faishal_design` (`lineage/CLAUDE.md` mencatat paket ini dilepas dari alurnya pada 2026-07-01). Klaim di bagian *Project Overview* di bawah bahwa paket ini dipakai `dzikir`/`almatsurat`/`mutabaah`/`doa`/`apps`/`portfolio` **sudah basi**. `.github/workflows/build.yml` menutup sebagian celah itu dengan membangun app konsumen sekali-pakai di CI.
- **Branch**: `main` = default. Kerja di branch task dari `main`. Kedua workflow (`test.yml`, `build.yml`) jalan di push ke `main`/`develop` dan PR ke `main`; **tidak ada** branch `build` khusus seperti repo app fleet — branch itu di sana untuk menahan runner macOS, dan paket ini tidak memakainya.
- **Cek**: `dart analyze lib test && flutter test` sebelum commit, plus `dart run build_runner build` (CI gagal bila pohon kerja kotor setelahnya — per 2026-09-17 codegen sudah bersih). **Pakai `dart analyze lib test`, bukan `dart analyze` polos**: `skills/` adalah symlink ke `../.agents/skills/` berisi materi skill agen dengan contoh kode yang memang tidak lengkap, dan analyze polos melaporkan 47 temuan yang 44 di antaranya dari sana. **Kedua gerbang merah hari ini** — `dart analyze lib test` keluar 1 (`_progress` tak terpakai di `dzikir_counter.dart:52`, plus 2 info deprecated `Share`/`shareXFiles` di `share_image_builder.dart:74`), dan `flutter test` **flaky**: dari sembilan run pada 2026-09-17 sebagian hijau dan sebagian merah dengan 1–2 kegagalan yang berganti-ganti, semuanya di `share_card_template_test.dart`, akibat `Column` di `share_card_template.dart:112` yang meluap ~19 px dengan metrik teks yang tidak tetap karena `google_fonts` mengambil font saat runtime. Jangan perlakukan satu run hijau sebagai bukti, dan jangan kira temuan ini regresimu.
- **CLI**: `gh-faishal` (remote `faishalwahiduddin/faishal-design`) — jangan bare `gh`. Tidak ada `wrangler-*`: paket, tanpa target deploy.
- **Larangan**: jangan ekspor API publik di luar barrel `lib/faishal_design.dart`; jangan hardcode hex warna di widget (pakai `AppColors`) atau bikin `TextStyle` inline (pakai `AppTypography`); jangan ganti locale default dari `id`; jangan pakai state management selain Riverpod; jangan tambahkan token Material 2 atau token desain kustom di luar tema; setiap widget wajib lolos RTL (uji dengan locale Arab) dan responsif di tiga breakpoint (<600dp, 600–1024dp, >1024dp); jangan sunting `*.freezed.dart`/`*.g.dart` dengan tangan; jangan perlakukan `skills/` sebagai sumber paket — itu symlink ke materi agen. Jangan menjalankan dev server (`flutter run`) atau `flutter build` kecuali diminta — `docs/standards.md` §Larangan bersama pada akar `~/projects`.
<!-- trace:end -->

## Quick Commands

```bash
flutter test                       # Run all tests
dart analyze                       # Static analysis
dart format .                      # Format code
dart run build_runner build        # Generate code
# Package manager: flutter pub
```

## Project Overview

**faishal_design** — Shared Dart package providing Material 3 theme, reusable widgets, and utilities for the faishal.id Flutter fleet. **No repo in `~/projects` depends on it as of 2026-09-17** (verified: no `faishal_design` in any `pubspec.yaml`, no `package:faishal_design` import anywhere); the older claim that dzikir, almatsurat, mutabaah, doa, apps and portfolio consume it is out of date.

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
