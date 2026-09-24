/// Waktu menurut jam dinding Jakarta (WIB).
///
/// Kontrak: `~/projects/docs/standards.md` §TZ. DB/penyimpanan selalu UTC,
/// tampilan & input selalu WIB, format 24 jam.
///
/// Ini paket bersama (`faishal_design`), bukan app -- tidak ada satu pun
/// repo di `~/projects` yang memakainya per 2026-09-17 (lihat README.md §
/// Status pemakaian), jadi zona konsumennya belum bisa dipastikan. Fungsi
/// di sini bersifat opsional: dipakai kalau app konsumen memang perlu
/// menampilkan sebuah instant sebagai WIB (mis. `AchievementModel.
/// unlockedAt` di `src/gamification/`), bukan diwajibkan untuk setiap
/// pemakaian `DateTime` di paket ini.
///
/// WIB itu UTC+7 tetap: tidak ada DST dan tidak pernah ada sejak 1964. Offset
/// tetap di sini benar, bukan penyederhanaan yang menunggu meledak.
library;

const Duration kWibOffset = Duration(hours: 7);

/// Nama zona IANA, untuk label/anotasi. Perhitungan sesungguhnya selalu
/// lewat [kWibOffset] literal — bukan lewat database zona waktu — karena WIB
/// tidak butuh aturan DST yang menjustifikasi kerumitan itu.
const String kWibTz = 'Asia/Jakarta';

/// Label zona untuk ditempelkan pada waktu yang ditampilkan.
const String kWibLabel = 'WIB';

/// [instant] sebagai jam dinding WIB.
///
/// Hasilnya ditandai UTC secara sengaja: yang dibawa hanyalah ANGKA jam dinding
/// WIB. Menandainya lokal akan mengundang `toLocal()` berikutnya menggeser lagi.
DateTime toWib(DateTime instant) => instant.toUtc().add(kWibOffset);

/// Sekarang, sebagai jam dinding WIB.
DateTime nowWib() => toWib(DateTime.now());

/// Urai nilai mentah jadi instant UTC. Lihat dokumentasi rujukan:
/// `atourin/app-admin/lib/utils/wib_time.dart`.
///
/// Menangani: string berakhiran `Z`/offset lengkap, offset gaya Postgres
/// (`+00`, `+0700`), tanggal telanjang `YYYY-MM-DD` (dianggap tengah malam
/// WIB), string naif ber-jam (dianggap UTC, bukan zona perangkat), dan epoch
/// milidetik. Tanggal kalender mustahil (mis. `2026-02-30`) → `null` di
/// semua jalur, bukan digulirkan diam-diam ke bulan berikutnya.
DateTime? parseUtc(Object? raw) {
  if (raw == null) return null;
  if (raw is DateTime) return raw.toUtc();
  if (raw is int) return DateTime.fromMillisecondsSinceEpoch(raw, isUtc: true);

  final text = raw.toString().trim();
  if (text.isEmpty) return null;

  final asEpoch = int.tryParse(text);
  if (asEpoch != null && !text.contains('-') && !text.contains(':')) {
    if (text.length >= 11) {
      return DateTime.fromMillisecondsSinceEpoch(asEpoch, isUtc: true);
    }
    return null;
  }

  if (RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(text)) {
    try {
      return wibDayRangeUtc(text).startUtc;
    } on FormatException {
      return null;
    }
  }

  // Bagian tanggal WAJIB persis YYYY-MM-DD di awal string -- bukan opsional.
  // Tanpa ini, bentuk yang tidak diawali begitu (mis. "20260115T100000"
  // format basic ISO tanpa tanda hubung, atau "+002026-01-15T..." format
  // tahun-diperluas) lolos tanpa validasi kalender lalu diam-diam diterima
  // DateTime.tryParse bawaan Dart di bawah -- keduanya BUKAN bentuk yang
  // didukung modul ini.
  final dateHead = RegExp(r'^(\d{4})-(\d{2})-(\d{2})').firstMatch(text);
  if (dateHead == null) return null;
  final hy = int.parse(dateHead.group(1)!);
  final hmo = int.parse(dateHead.group(2)!);
  final hd = int.parse(dateHead.group(3)!);
  final headCheck = DateTime.utc(hy, hmo, hd);
  if (headCheck.year != hy || headCheck.month != hmo || headCheck.day != hd) {
    return null;
  }

  // Jam/menit/detik divalidasi eksplisit SEBELUM DateTime.tryParse --
  // DateTime.tryParse bawaan Dart menggulirkan overflow diam-diam (mis.
  // "T25:00" -> jam 01:00 hari berikutnya, "T10:61" -> jam 11:01), dan
  // tanpa cek ini di sinilah nilai yang salah lolos sebagai instant yang
  // tampak valid.
  final timeHead = RegExp(
    r'^\d{4}-\d{2}-\d{2}[T ](\d{2}):(\d{2})(?::(\d{2}))?',
  ).firstMatch(text);
  if (timeHead != null) {
    final hh = int.parse(timeHead.group(1)!);
    final mm = int.parse(timeHead.group(2)!);
    final ss = timeHead.group(3) != null ? int.parse(timeHead.group(3)!) : 0;
    if (hh > 23 || mm > 59 || ss > 59) return null;
  }

  var normalized = text;
  final withColon = RegExp(
    r'^(.*\d{2}:\d{2}(?::\d{2}(?:\.\d+)?)?)([+-]\d{2})(\d{2})?$',
  ).firstMatch(text);
  if (withColon != null) {
    final minutes = withColon.group(3) ?? '00';
    normalized = '${withColon.group(1)}${withColon.group(2)}:$minutes';
  }

  final parsed = DateTime.tryParse(normalized);
  if (parsed == null) return null;
  if (parsed.isUtc) return parsed;

  return DateTime.utc(
    parsed.year,
    parsed.month,
    parsed.day,
    parsed.hour,
    parsed.minute,
    parsed.second,
    parsed.millisecond,
    parsed.microsecond,
  );
}

/// Tanggal kalender WIB hari ini, `YYYY-MM-DD`.
String todayWib() => wibDateKey(DateTime.now());

/// Instant UTC untuk tengah malam WIB pada hari yang memuat [instant].
DateTime wibStartOfDayUtc(DateTime instant) {
  final w = toWib(instant);
  return DateTime.utc(w.year, w.month, w.day).subtract(kWibOffset);
}

/// Instant UTC untuk milidetik terakhir hari WIB yang memuat [instant].
DateTime wibEndOfDayUtc(DateTime instant) => wibStartOfDayUtc(instant)
    .add(const Duration(days: 1))
    .subtract(const Duration(milliseconds: 1));

/// Rentang UTC **setengah terbuka** `[startUtc, endUtc)` untuk satu hari
/// kalender WIB, `date` berbentuk `YYYY-MM-DD`.
///
/// Melempar [FormatException] untuk tanggal yang bukan `YYYY-MM-DD` atau
/// yang tidak ada di kalender (mis. `2026-02-30`).
({DateTime startUtc, DateTime endUtc}) wibDayRangeUtc(String date) {
  final m = RegExp(r'^(\d{4})-(\d{2})-(\d{2})$').firstMatch(date);
  if (m == null) {
    throw FormatException('Tanggal WIB bukan YYYY-MM-DD: $date');
  }
  final y = int.parse(m.group(1)!);
  final mo = int.parse(m.group(2)!);
  final d = int.parse(m.group(3)!);
  final wallMidnight = DateTime.utc(y, mo, d);
  if (wallMidnight.year != y || wallMidnight.month != mo || wallMidnight.day != d) {
    throw FormatException('Tanggal WIB tidak ada di kalender: $date');
  }
  final start = wallMidnight.subtract(kWibOffset);
  return (startUtc: start, endUtc: start.add(const Duration(days: 1)));
}

/// Rentang UTC setengah terbuka yang mencakup tanggal WIB `from`..`to`
/// **inklusif**. `to` yang lebih awal dari `from` ditukar.
({DateTime startUtc, DateTime endUtc}) wibRangeUtc(String from, String to) {
  final a = wibDayRangeUtc(from);
  final b = wibDayRangeUtc(to);
  return !a.startUtc.isAfter(b.startUtc)
      ? (startUtc: a.startUtc, endUtc: b.endUtc)
      : (startUtc: b.startUtc, endUtc: a.endUtc);
}

/// Rentang UTC setengah terbuka untuk satu bulan kalender WIB, `yearMonth`
/// berbentuk `YYYY-MM`.
({DateTime startUtc, DateTime endUtc}) wibMonthRangeUtc(String yearMonth) {
  final m = RegExp(r'^(\d{4})-(\d{2})$').firstMatch(yearMonth);
  if (m == null) {
    throw FormatException('Bulan WIB bukan YYYY-MM: $yearMonth');
  }
  final y = int.parse(m.group(1)!);
  final mo = int.parse(m.group(2)!);
  if (mo < 1 || mo > 12) {
    throw FormatException('Bulan WIB tidak valid: $yearMonth');
  }
  final start = DateTime.utc(y, mo, 1).subtract(kWibOffset);
  final nextMonth = mo == 12 ? DateTime.utc(y + 1, 1, 1) : DateTime.utc(y, mo + 1, 1);
  return (startUtc: start, endUtc: nextMonth.subtract(kWibOffset));
}

/// Kunci hari `dd/MM` menurut WIB.
String wibDayKey(DateTime instant) {
  final w = toWib(instant);
  return '${_two(w.day)}/${_two(w.month)}';
}

/// Kunci hari `YYYY-MM-DD` menurut WIB.
String wibDateKey(DateTime instant) {
  final w = toWib(instant);
  return '${w.year.toString().padLeft(4, '0')}-${_two(w.month)}-${_two(w.day)}';
}

/// `dd/MM/yyyy` menurut WIB.
String formatWibDate(DateTime instant) {
  final w = toWib(instant);
  return '${_two(w.day)}/${_two(w.month)}/${w.year}';
}

/// `HH:mm` menurut WIB. Selalu 24 jam — tidak pernah AM/PM.
String formatWibTime(DateTime instant) {
  final w = toWib(instant);
  return '${_two(w.hour)}:${_two(w.minute)}';
}

/// `dd/MM/yyyy HH:mm WIB`.
String formatWibDateTime(DateTime instant) =>
    '${formatWibDate(instant)} ${formatWibTime(instant)} $kWibLabel';

/// Memformat nilai date-only (`YYYY-MM-DD`) **tanpa** konversi zona — dipakai
/// untuk kolom kalender murni (tanggal lahir, HPHT). Input yang ternyata
/// sebuah instant (memuat `T`) ditampilkan lewat tanggal WIB-nya supaya tidak
/// crash, bukan sebagai fallback diam-diam yang salah.
String formatWibServerDate(String raw) {
  if (raw.length <= 10) {
    final parts = raw.split('-');
    return parts.length == 3 ? '${parts[2]}/${parts[1]}/${parts[0]}' : raw;
  }
  // parseUtc(), bukan DateTime.tryParse() bawaan -- string naif di sini
  // berarti UTC per kontrak, bukan zona perangkat, dan parseUtc() juga
  // menolak tanggal kalender mustahil alih-alih menggulirkannya.
  final parsed = parseUtc(raw);
  return parsed == null ? raw : formatWibDateTime(parsed);
}

/// Nilai dari field input pengguna (`YYYY-MM-DDTHH:mm[:ss]`) yang mewakili
/// jam dinding WIB, diubah jadi string ISO UTC untuk disimpan.
String? wibInputToUtc(String? local) {
  if (local == null) return null;
  final trimmed = local.trim();
  if (trimmed.isEmpty) return null;

  final withOffset = RegExp(
    r'^\d{4}-\d{2}-\d{2}[T ]\d{2}:\d{2}(?::\d{2}(?:\.\d+)?)?'
    r'(?:Z|[+-]\d{2}(?::?\d{2})?)$',
  );
  if (withOffset.hasMatch(trimmed)) {
    return parseUtc(trimmed)?.toIso8601String();
  }

  final m = RegExp(
    r'^(\d{4})-(\d{2})-(\d{2})[T ](\d{2}):(\d{2})(?::(\d{2})(?:\.\d+)?)?$',
  ).firstMatch(trimmed);
  if (m == null) return null;

  final y = int.parse(m.group(1)!);
  final mo = int.parse(m.group(2)!);
  final d = int.parse(m.group(3)!);
  final h = int.parse(m.group(4)!);
  final mi = int.parse(m.group(5)!);
  final s = m.group(6) != null ? int.parse(m.group(6)!) : 0;
  if (h > 23 || mi > 59 || s > 59) return null;

  final wallClock = DateTime.utc(y, mo, d, h, mi, s);
  final rolledOver = wallClock.year != y ||
      wallClock.month != mo ||
      wallClock.day != d ||
      wallClock.hour != h ||
      wallClock.minute != mi ||
      wallClock.second != s;
  if (rolledOver) return null;

  return wallClock.subtract(kWibOffset).toIso8601String();
}

/// Kebalikan [wibInputToUtc]: instant → `YYYY-MM-DDTHH:mm` untuk nilai awal
/// field input, dalam jam dinding WIB.
String utcToWibInput(DateTime instant) {
  final w = toWib(instant);
  return '${w.year.toString().padLeft(4, '0')}-${_two(w.month)}-${_two(w.day)}'
      'T${_two(w.hour)}:${_two(w.minute)}';
}

const List<String> _hariIndonesia = [
  'Minggu', 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu',
];

const List<String> _bulanIndonesia = [
  'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
  'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',
];

/// `Jumat, 21 Agustus 2026` menurut WIB.
String formatWibLongDate(DateTime instant) {
  final w = toWib(instant);
  return '${_hariIndonesia[w.weekday % 7]}, ${w.day} '
      '${_bulanIndonesia[w.month - 1]} ${w.year}';
}

/// `Jumat, 21 Agustus 2026 14:30 WIB`.
String formatWibLongDateTime(DateTime instant) =>
    '${formatWibLongDate(instant)} ${formatWibTime(instant)} $kWibLabel';

String _two(int n) => n.toString().padLeft(2, '0');
