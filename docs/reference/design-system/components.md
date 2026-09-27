---
type: Design System
title: Component Catalog — Faishal Design (Flutter)
status: active
last-updated: 2026-09-27
---

# Component Catalog — Faishal Design

Katalog widget Flutter reusable yang disediakan oleh package `faishal_design` (`lib/faishal_design.dart`).

---

## 1. Layout & Scaffold

- `AppScaffold`: Scaffold standar dengan top bar, drawer, dan bottom bar adaptif.
- `ResponsiveLayout`: Pembungkus adaptif breakpoint mobile (<600dp), tablet (600–1024dp), dan desktop (>1024dp).
- `RtlAware`: Penyesuaian layout otomatis untuk teks bahasa Arab (RTL) vs Latin (LTR).

---

## 2. Reading & Gamification Widgets

- `ReadingCard`: Kartu bacaan ayat/doa dengan badge nomor ayat, terjemahan, dan aksi audio/bookmark.
- `DzikirCounter` & `TasbihCounter`: Widget counter interaktif dengan getaran haptic.
- `ArabicTextBlock`: Blok teks Al-Quran bersanad dengan harakat presisi.
- `ShareImageBuilder`: Renderer kartu kutipan doa/ayat ke gambar PNG siap bagikan.
