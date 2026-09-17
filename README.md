# faishal_design

Paket Flutter bersama (`package:faishal_design`) untuk fleet aplikasi faishal.id:
tema Material 3, tipografi Latin/Arab, widget baca bernuansa Islami, repositori teks
Al-Qur'an Utsmani, dan satu mesin gamifikasi (XP, level, streak, achievement,
tantangan, kartu share) yang lengkap dengan model, storage, dan widgetnya.

> **Paket, bukan aplikasi.** Tidak ada `main()`, tidak ada direktori platform.
> Konsumsinya lewat `dependency` berjalur path atau git dari repo app lain.

## Status pemakaian (per 2026-09-17)

**Tidak ada satu pun repo di `~/projects` yang memakai paket ini saat ini.**
Klaim di `AGENTS.md` dan `CLAUDE.md` bahwa paket ini dipakai `dzikir`, `almatsurat`,
`mutabaah`, `doa`, `apps`, dan `portfolio` sudah tidak benar: tidak ada
`faishal_design` di `pubspec.yaml` mana pun, dan tidak ada satu berkas `.dart` di
workspace yang meng-import `package:faishal_design`. `faishal.id/lineage/CLAUDE.md`
mencatat paket ini **dihapus dari alurnya pada 2026-07-01**.

Artinya: perubahan di sini tidak memutus app mana pun hari ini — tetapi juga tidak
ada app yang membuktikan paket ini masih benar. `.github/workflows/build.yml`
menutup sebagian celah itu dengan membangun app konsumen sekali-pakai di CI.

## Isi paket

Semua API publik diekspor lewat satu barrel, `lib/faishal_design.dart`.

| Area | Isi |
|------|-----|
| Tema | `AppTheme.light()` / `AppTheme.dark()`, `AppColors`, `AppTypography` — Material 3, hijau `#2E7D32`, Poppins (Latin) + Amiri (Arab) via `google_fonts` |
| Provider | `themeProvider`, `localeProvider`, `sharedPreferencesProvider` (Riverpod; locale default `id`) |
| Widget baca | `ArabicTextBlock`, `QuranMushafText`, `AyahEndMarker`, `IslamicDivider`, `ReadingCard`, `ReadingTopBar`, `ReadingBottomSheet`, `ContentSidebar`, `SourceBadge`, `SectionHeader`, `DzikirCounter`, `TasbihCounter` |
| Layout | `ResponsiveLayout`, `AppScaffold`, `RtlAware` — breakpoint mobile <600dp, tablet 600–1024dp, desktop >1024dp |
| Kontrol | `ThemeSwitcher`, `LanguageSwitcher` |
| Al-Qur'an | `QuranTextRepository` (singleton) membaca `assets/data/quran_uthmani.json`, plus `QuranReference` dan `QuranPassage` |
| Gamifikasi | `GamificationEngine`, `AchievementChecker`, `GamificationStorage`, model `freezed` (achievement, challenge, level, streak, XP event), tabel XP dan ambang level, widget dashboard/kartu/share |
| Utilitas | `JsonLoader`, `SeoUtils` (implementasi web + stub, dipilih lewat conditional import) |

## Menjalankan

```bash
flutter pub get
dart analyze lib test      # lihat catatan di bawah — jangan `dart analyze` polos
flutter test
dart run build_runner build   # regenerasi *.freezed.dart / *.g.dart
```

### Kenapa `dart analyze lib test`, bukan `dart analyze`

`skills/` berisi **symlink** ke `../.agents/skills/` — materi skill agen, bukan
sumber paket ini. Contoh kodenya sengaja tidak lengkap (import paket yang tidak ada
di `pubspec.yaml`, cuplikan yang tidak ter-compile), jadi `dart analyze` polos
melaporkan 47 temuan yang 44 di antaranya berasal dari sana dan menenggelamkan
temuan nyata. Membatasi ke `lib test` membuat gerbangnya bicara soal paket ini.

## Utang yang diketahui (per 2026-09-17, sudah diverifikasi dengan menjalankannya)

| Gerbang | Hasil |
|---------|-------|
| `dart analyze lib test` | **keluar 1** — 3 temuan: `_progress` tak terpakai di `lib/src/widgets/dzikir_counter.dart:52`, dan 2 info `deprecated_member_use` (`Share`/`shareXFiles` → `SharePlus`) di `lib/src/gamification/services/share_image_builder.dart:74` |
| `flutter test` | **flaky.** 89 test, 1 dilewati. Dijalankan sembilan kali pada 2026-09-17: sebagian run hijau, sebagian merah dengan **1–2** kegagalan, dan *test yang gagal berganti-ganti antar-run* — `renders child correctly`, `renders default app name and branding`, `renders with Story size dimensions`, semuanya di `test/src/gamification/widgets/share_card_template_test.dart`. Penyebabnya satu: `Column` di `lib/src/gamification/widgets/share_card_template.dart:112` meluap ~19 px, dan ambangnya bergeser karena `google_fonts` mengambil font saat runtime sehingga metrik teksnya tidak tetap. **Jangan perlakukan satu run hijau sebagai bukti** |
| `dart pub publish --dry-run` | gagal — belum ada `CHANGELOG.md` dan `homepage`/`repository` di `pubspec.yaml`. Paket ini privat dan tidak dipublikasikan ke pub.dev, jadi ini bukan penghalang, hanya catatan |

Rinciannya dan syarat pelunasannya ada di
[`docs/standards-backlog.md`](../../docs/standards-backlog.md) di akar `~/projects`.

## Dokumen lain

| Berkas | Isi |
|--------|-----|
| [`AGENTS.md`](./AGENTS.md) | Kontrak untuk agen AI, termasuk blok **Mulai di sini (60 detik)** |
| [`CLAUDE.md`](./CLAUDE.md) | Catatan tambahan khusus Claude Code |
| [`GEMINI.md`](./GEMINI.md) | Catatan tambahan khusus Gemini/Jules |
| [`docs/PRD.md`](./docs/PRD.md) | Spesifikasi design system dan kebutuhan paket |
