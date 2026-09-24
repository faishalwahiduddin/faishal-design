import 'package:flutter_test/flutter_test.dart';
import 'package:faishal_design/faishal_design.dart';

void main() {
  group('toWib', () {
    test('menggeser tujuh jam dari UTC', () {
      final w = toWib(DateTime.utc(2026, 8, 21, 5, 0));
      expect(w.hour, 12);
      expect(w.day, 21);
    });

    test('tidak bergantung pada zona waktu perangkat', () {
      final instant = DateTime.utc(2026, 8, 21, 5, 0);
      expect(toWib(instant), toWib(instant.toLocal()));
    });
  });

  group('batas hari', () {
    test('16:59:59 UTC masih hari yang sama di WIB', () {
      expect(wibDayKey(DateTime.utc(2026, 8, 20, 16, 59, 59)), '20/08');
    });

    test('17:00:00 UTC sudah hari berikutnya di WIB', () {
      expect(wibDayKey(DateTime.utc(2026, 8, 20, 17, 0, 0)), '21/08');
    });

    test('awal hari WIB adalah 17:00 UTC hari sebelumnya', () {
      final start = wibStartOfDayUtc(DateTime.utc(2026, 8, 21, 5, 0));
      expect(start, DateTime.utc(2026, 8, 20, 17, 0, 0));
    });

    test('rentang sehari penuh persis 24 jam', () {
      final now = DateTime.utc(2026, 8, 21, 5, 0);
      final span = wibEndOfDayUtc(now).difference(wibStartOfDayUtc(now));
      expect(span.inMilliseconds, const Duration(days: 1).inMilliseconds - 1);
    });
  });

  group('format', () {
    test('jam selalu 24 jam, tidak pernah AM/PM', () {
      final s = formatWibTime(DateTime.utc(2026, 8, 21, 6, 45));
      expect(s, '13:45');
      expect(s.toUpperCase().contains('AM'), isFalse);
      expect(s.toUpperCase().contains('PM'), isFalse);
    });

    test('tengah malam WIB ditulis 00:00, bukan 12:00', () {
      expect(formatWibTime(DateTime.utc(2026, 8, 20, 17, 0)), '00:00');
    });

    test('tanggal-waktu diberi label zona', () {
      expect(
        formatWibDateTime(DateTime.utc(2026, 8, 21, 6, 45)),
        '21/08/2026 13:45 WIB',
      );
    });

    test('hari Minggu tidak salah indeks', () {
      // 23 Agustus 2026 adalah Minggu; weekday=7 dan 7 % 7 = 0.
      expect(
        formatWibLongDate(DateTime.utc(2026, 8, 23, 5, 0)),
        'Minggu, 23 Agustus 2026',
      );
    });

    test('pergantian tahun lewat batas WIB', () {
      expect(formatWibDate(DateTime.utc(2026, 12, 31, 17, 0)), '01/01/2027');
    });
  });

  group('parseUtc — kasus probe wajib', () {
    test('date-only 2026-01-15 => tengah malam WIB dalam UTC', () {
      expect(parseUtc('2026-01-15'), DateTime.utc(2026, 1, 14, 17, 0, 0));
      expect(wibDateKey(parseUtc('2026-01-15')!), '2026-01-15');
    });

    test('tanggal mustahil ditolak di semua jalur', () {
      expect(parseUtc('2026-02-30'), isNull); // date-only
      expect(parseUtc('2026-02-29'), isNull); // 2026 bukan kabisat
      expect(parseUtc('2026-02-30T10:00:00Z'), isNull); // instant Z
      expect(parseUtc('2026'), isNull); // format tak lengkap
    });

    test('kalender kabisat asli tetap diterima', () {
      expect(parseUtc('2028-02-29'), isNotNull);
    });

    test('offset Postgres +00 dan +0700 diurai benar', () {
      expect(
        parseUtc('2026-08-21 05:00:00+00'),
        DateTime.utc(2026, 8, 21, 5, 0),
      );
      expect(
        parseUtc('2026-08-21T12:00:00+0700'),
        DateTime.utc(2026, 8, 21, 5, 0),
      );
    });

    test('tanggal telanjang tidak salah cocok sebagai offset dua digit', () {
      // Regresi: "-15" di ujung "2026-01-15" tidak boleh dibaca sebagai offset.
      for (final d in ['2026-08-31', '2026-04-30', '2026-01-10']) {
        expect(parseUtc(d), isNotNull, reason: 'gagal urai $d');
      }
    });

    test('null dan string tak-terurai mengembalikan null', () {
      expect(parseUtc(null), isNull);
      expect(parseUtc('bukan tanggal'), isNull);
      expect(parseUtc(''), isNull);
    });
  });

  group('wibInputToUtc — kasus probe wajib', () {
    test('input naif WIB dikonversi ke UTC', () {
      expect(wibInputToUtc('2026-01-15T10:00'), '2026-01-15T03:00:00.000Z');
    });

    test('input dengan offset diteruskan apa adanya (tidak dikurangi lagi)', () {
      expect(
        wibInputToUtc('2026-01-15T10:00+07:00'),
        '2026-01-15T03:00:00.000Z',
      );
      expect(
        wibInputToUtc('2026-01-15T10:00+00'),
        '2026-01-15T10:00:00.000Z',
      );
    });

    test('jam 24 dan tanggal mustahil ditolak', () {
      expect(wibInputToUtc('2026-01-15T24:00'), isNull);
      expect(wibInputToUtc('2026-02-30T10:00Z'), isNull);
      expect(wibInputToUtc('2026-01-15T10:00junk'), isNull);
    });

    test('round-trip wibInputToUtc <-> utcToWibInput', () {
      final utc = wibInputToUtc('2026-01-15T10:00');
      final instant = parseUtc(utc)!;
      expect(utcToWibInput(instant), '2026-01-15T10:00');
    });
  });

  group('todayWib dan wibDateKey', () {
    test('todayWib konsisten dengan wibDateKey(sekarang)', () {
      expect(todayWib(), wibDateKey(DateTime.now()));
      expect(RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(todayWib()), isTrue);
    });
  });

  group('wibDayRangeUtc', () {
    test('setengah terbuka: 24 jam persis', () {
      final r = wibDayRangeUtc('2026-08-21');
      expect(r.startUtc, DateTime.utc(2026, 8, 20, 17, 0, 0));
      expect(r.endUtc, DateTime.utc(2026, 8, 21, 17, 0, 0));
    });

    test('tanggal mustahil dilempar FormatException', () {
      expect(() => wibDayRangeUtc('2026-02-30'), throwsFormatException);
    });
  });

  group('wibRangeUtc', () {
    test('from > to ditukar, bukan menghasilkan rentang kosong', () {
      final normal = wibRangeUtc('2026-08-01', '2026-08-05');
      final terbalik = wibRangeUtc('2026-08-05', '2026-08-01');
      expect(terbalik, normal);
    });
  });

  group('wibMonthRangeUtc', () {
    test('Desember menyeberang ke Januari tahun berikutnya', () {
      final r = wibMonthRangeUtc('2026-12');
      expect(r.endUtc, DateTime.utc(2026, 12, 31, 17, 0, 0));
    });
  });
}
