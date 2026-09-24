import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Guard TZ-2 (`~/projects/docs/standards.md` §TZ).
///
/// faishal_design is a shared package, not an app: no repo in `~/projects`
/// references it as of 2026-09-17 (README.md § Status pemakaian). Its one
/// real instant (`AchievementModel.unlockedAt`) is now written UTC
/// (`achievement_checker.dart`) and displayed WIB (`formatWibDate` in
/// `achievement_card.dart`) — see the commits that fixed those two sites.
/// The one remaining `DateTime.now()` site (`muhasabah_dialog.dart`) is a
/// "shown today?" gate keyed off the device's own local day, which is
/// correct for a per-device SharedPreferences flag with no cross-device
/// meaning. The guard still scans every site and requires it allowlisted
/// per file+line with a stated reason, rather than the pattern being
/// loosened.
///
/// Pemindaian per baris, bukan parse AST: sebuah KOMENTAR yang mengutip pola
/// ini pun ikut tertangkap. Itu sengaja.
class _ForbiddenPattern {
  final RegExp pattern;
  final String why;
  const _ForbiddenPattern(this.pattern, this.why);
}

const _allowedFiles = {'lib/src/utils/wib_time.dart'};

bool _isGenerated(String relPath) => relPath.endsWith('.g.dart') || relPath.endsWith('.freezed.dart');

final _forbidden = <_ForbiddenPattern>[
  _ForbiddenPattern(
    RegExp(r'\.toLocal\s*\('),
    'memakai zona waktu PERANGKAT -- tampilkan lewat toWib()/format*Wib() '
        'dari lib/src/utils/wib_time.dart',
  ),
  _ForbiddenPattern(
    RegExp(r'DateFormat\s*\('),
    'DateFormat dari package:intl merender di zona perangkat kecuali '
        'dipanggil dari dalam wib_time.dart -- pakai format*Wib()',
  ),
  _ForbiddenPattern(
    RegExp(r'DateTime\.now\s*\(\s*\)'),
    'DateTime.now() adalah instant yang benar, tapi memakainya di luar '
        'wib_time.dart tanpa alasan tercatat membuat pemanggil berikutnya '
        'lupa mengarahkannya lewat toWib()/format*Wib() sebelum tampil -- '
        'kalau situs ini memang aman, tambahkan ke _allowlist dengan alasan',
  ),
  _ForbiddenPattern(
    RegExp(r'DateTime\.(?:try)?[Pp]arse\s*\('),
    'parser bawaan Dart menandai string tanpa Z/offset sebagai zona '
        'PERANGKAT -- untuk sebuah instant lintas-perangkat pakai '
        'parseUtc() dari lib/src/utils/wib_time.dart',
  ),
];

class _AllowlistEntry {
  final String file;
  final RegExp match;
  final String why;
  const _AllowlistEntry(this.file, this.match, this.why);
}

final _allowlist = <_AllowlistEntry>[
  _AllowlistEntry(
    'lib/src/gamification/services/achievement_checker.dart',
    RegExp(r'unlockedAt: DateTime\.now\(\)\.toUtc\(\),'),
    '.toUtc() dipanggil tepat di baris ini -- sudah instant UTC yang benar '
        'per kontrak poin 1, ditampilkan lewat formatWibDate() di '
        'achievement_card.dart',
  ),
  _AllowlistEntry(
    'lib/src/gamification/widgets/muhasabah_dialog.dart',
    RegExp(r"final today = DateTime\.now\(\)\.toIso8601String\(\)\.split\('T'\)\.first;"),
    "kunci 'sudah ditampilkan hari ini?' per perangkat (SharedPreferences "
        'lokal, bukan lintas perangkat) -- hari yang benar adalah hari ini '
        'menurut perangkat yang sedang dipakai, bukan WIB tetap',
  ),
];

bool _isAllowlisted(String relPath, String line) =>
    _allowlist.any((a) => a.file == relPath && a.match.hasMatch(line));

List<String> _dartFilesUnder(Directory dir, String root) {
  if (!dir.existsSync()) return const [];
  return dir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .map((f) => f.path.substring(root.length + 1).replaceAll(r'\', '/'))
      .toList()
    ..sort();
}

List<String> findOffenders(String root, List<String> relPaths) {
  final offenders = <String>[];
  for (final rel in relPaths) {
    if (_allowedFiles.contains(rel) || _isGenerated(rel)) continue;
    final lines = File('$root/$rel').readAsLinesSync();
    for (var i = 0; i < lines.length; i++) {
      final line = lines[i];
      if (_isAllowlisted(rel, line)) continue;
      for (final f in _forbidden) {
        if (f.pattern.hasMatch(line)) {
          offenders.add('$rel:${i + 1} -- ${f.why}\n    ${line.trim()}');
        }
      }
    }
  }
  return offenders;
}

void main() {
  final root = Directory.current.path;
  final libDir = Directory('$root/lib');

  test('tidak ada berkas lib/ yang menangani waktu di luar wib_time.dart tanpa alasan', () {
    final files = _dartFilesUnder(libDir, root);
    expect(files.length, greaterThan(10));

    final offenders = findOffenders(root, files);
    expect(
      offenders,
      isEmpty,
      reason: 'Penanganan waktu tidak aman ditemukan:\n\n${offenders.join('\n')}\n',
    );
  });

  test('allowlist menunjuk baris yang nyata ada di berkasnya, bukan sisa refactor', () {
    for (final entry in _allowlist) {
      final path = '$root/${entry.file}';
      expect(File(path).existsSync(), isTrue, reason: '${entry.file} tidak ada');
      final lines = File(path).readAsLinesSync();
      final found = lines.any((l) => entry.match.hasMatch(l));
      expect(
        found,
        isTrue,
        reason:
            'allowlist ${entry.file} (${entry.match.pattern}) tidak cocok baris '
            'mana pun -- situsnya sudah dipindah/dihapus, allowlist ini jadi mati',
      );
      expect(entry.why.length, greaterThan(15), reason: 'alasan allowlist terlalu pendek');
    }
  });

  test('pola FORBIDDEN benar-benar menangkap contoh pelanggaran, bukan melunak diam-diam', () {
    const regressions = [
      'final createdAt = DateTime.now();',
      'final jam = raw.toLocal();',
      "DateFormat('dd/MM/yyyy').format(instant);",
      "final d = DateTime.parse(json['created_at']);",
      'final d = DateTime.tryParse(raw.toString());',
    ];
    for (final line in regressions) {
      final caught = _forbidden.any((f) => f.pattern.hasMatch(line));
      expect(caught, isTrue, reason: 'tidak tertangkap pola mana pun: $line');
    }
  });

  test('allowlist tidak mengecualikan seluruh berkas -- pelanggar baru di berkas yang sama tetap tertangkap', () {
    expect(
      _isAllowlisted(
        'lib/src/gamification/widgets/muhasabah_dialog.dart',
        '      final x = DateTime.now(); // bukan situs yang di-allowlist',
      ),
      isFalse,
    );
  });

  test('berkas .g.dart / .freezed.dart hasil codegen dikecualikan dari pemindaian', () {
    expect(_isGenerated('lib/src/gamification/models/achievement_model.g.dart'), isTrue);
    expect(_isGenerated('lib/src/gamification/models/achievement_model.dart'), isFalse);
  });
}
