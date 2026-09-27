# Design System — faishal_design

> **SSOT (Single Source of Truth)** sistem desain aplikasi ini berada di direktori [`docs/reference/design-system/`](./docs/reference/design-system/).
> Seluruh pengembangan antarmuka (UI/UX) wajib merujuk ke dokumentasi tersebut sebelum menulis kode.

---

## 1. Ikhtisar Produk & Surface

- **Aplikasi**: faishal_design — Paket tema dan komponen desain kanonik Flutter armada faishal.id.
- **Pembagian Surface**: Material 3 Themes, Islamic Reading Widgets, Gamification Engine.

---

## 2. Navigasi Dokumentasi Desain (SSOT)

| Dokumen | Path | Deskripsi |
|---|---|---|
| **Index & Surfaces** | [`docs/reference/design-system/README.md`](./docs/reference/design-system/README.md) | Pintu masuk panduan, pemetaan surface, dan rute live showcase. |
| **Foundations** | [`docs/reference/design-system/foundations.md`](./docs/reference/design-system/foundations.md) | Token visual teknis (palet warna, tipografi, spacing, radius, elevasi, motion). |
| **Components** | [`docs/reference/design-system/components.md`](./docs/reference/design-system/components.md) | Inventori komponen baku, tombol, form, tabel data, modal, dan status interaksi. |

---

## 3. Disiplin & Standar Kualitas UI/UX (/ui-ux-pro-max)

1. **Dilarang Hardcode Nilai Hex**:
   - Seluruh warna wajib menggunakan token semantik CSS variables / utility theme framework (contoh: `bg-primary`, `text-foreground`, `border-border`).
   - Dilarang keras menulis warna literal (`#1E40AF`, `rgb(...)`) langsung pada markup template komponen.
2. **Kontras Aksesibilitas (WCAG 2.1 AA)**:
   - Teks normal / body wajib memiliki kontras rasio minimal **4.5:1** terhadap latar belakang.
   - Headline / teks besar (>=18pt atau >=14pt bold) dan batas komponen interaktif wajib minimal **3:1**.
3. **Ergonomi & Target Sentuh**:
   - Elemen interaktif (tombol, input, icon link) wajib memiliki target sentuh minimal **44×44pt** (iOS) atau **48×48dp** (Web / Android).
4. **Ikonografi Vektor**:
   - Dilarang menggunakan emoji karakter (`🎉`, `✅`) sebagai ikon aksi atau status antarmuka. Wajib menggunakan SVG atau ikon resmi (Lucide, Heroicons, Phosphor, CupertinoIcons).
5. **Indikator Fokus & Gerakan**:
   - Dilarang menghilangkan indikator fokus (`outline: none`) tanpa styling fokus keyboard pengganti yang jelas.
   - Seluruh animasi wajib menghormati pengaturan pengguna `prefers-reduced-motion`.
