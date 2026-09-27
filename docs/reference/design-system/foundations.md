---
type: Design System
title: Design System Foundations — Faishal Design (Flutter)
status: active
last-updated: 2026-09-27
---

# Design System Foundations — Faishal Design

Package Dart/Flutter kanonik untuk tema, token warna, tipografi, dan widget aplikasi mobile & web ekosistem `faishal.id`.
Rujukan spesifikasi: [`PRD.md`](../../PRD.md).

---

## 1. Palet Warna (Material 3 ThemeData)

Tersedia di `AppColors` (`lib/src/theme/app_colors.dart`):

| Token | Light Hex | Dark Hex | Peran |
|---|---|---|---|
| `primary` | `#2E7D32` | `#66BB6A` | Islamic Green — tombol, link, tab aktif |
| `secondary` | `#1565C0` | `#42A5F5` | Aksi sekunder |
| `surface` | `#FAFAFA` | `#121212` | Latar kartu / elevated card |
| `background` | `#FFFFFF` | `#1E1E1E` | Latar belakang aplikasi |
| `error` | `#D32F2F` | `#EF5350` | Pesan galat dan validasi |
| `onSurface` | `#212121` | `#E0E0E0` | Teks utama |

---

## 2. Tipografi Scale (`AppTypography`)

- **Font Latin**: Poppins (Display, Headline, Title, Body, Label).
- **Font Arab**: Amiri (Amiri Regular / Uthmani font untuk teks Al-Quran dan doa).
  - `arabicLarge`: 28sp (tampilan mushaf dan ayat fokus)
  - `arabicMedium`: 22sp (tampilan ayat dalam daftar)
