import 'dart:convert';

import 'package:flutter/services.dart';

import 'quran_passage.dart';
import 'quran_reference.dart';

class QuranTextRepository {
  QuranTextRepository._();

  static final QuranTextRepository instance = QuranTextRepository._();

  static const _assetPath = 'assets/data/quran_uthmani.json';
  static const _packageAssetPath =
      'packages/faishal_design/assets/data/quran_uthmani.json';
  static final RegExp _rangePattern = RegExp(
    r'QS\.?\s*([^:(]+?)\s*:\s*(\d+)(?:\s*-\s*(\d+))?',
    caseSensitive: false,
  );
  static final RegExp _surahOnlyPattern = RegExp(
    r'QS\.?\s*([^:(]+?)\s*\((\d+)\)',
    caseSensitive: false,
  );

  Map<int, _QuranSurah>? _surahsByNumber;
  Map<String, int>? _surahAliases;

  Future<void> ensureLoaded() async {
    if (_surahsByNumber != null && _surahAliases != null) {
      return;
    }

    final raw = await _loadAsset();
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    final surahs = (decoded['surahs'] as List<dynamic>)
        .map((item) => Map<String, dynamic>.from(item as Map))
        .map(_QuranSurah.fromJson)
        .toList();

    _surahsByNumber = {for (final surah in surahs) surah.number: surah};
    _surahAliases = _buildSurahAliases(surahs);
  }

  Future<QuranPassage> getPassage(
    QuranReference reference, {
    String? sourceLabel,
  }) async {
    await ensureLoaded();

    final surah = _surahsByNumber![reference.surahNumber];
    if (surah == null) {
      throw ArgumentError('Surah ${reference.surahNumber} tidak ditemukan.');
    }
    if (reference.endAyah > surah.ayahs.length) {
      throw RangeError(
        'Rentang ayat ${reference.startAyah}-${reference.endAyah} melebihi '
        'jumlah ayat surah ${reference.surahNumber}.',
      );
    }

    final verses = surah.ayahs
        .where(
          (ayah) =>
              ayah.number >= reference.startAyah &&
              ayah.number <= reference.endAyah,
        )
        .map(
          (ayah) => QuranAyahSegment(
            surahNumber: reference.surahNumber,
            ayahNumber: ayah.number,
            text: ayah.text,
          ),
        )
        .toList(growable: false);

    return QuranPassage(
      reference: reference,
      sourceLabel: sourceLabel ?? _defaultSourceLabel(surah, reference),
      verses: verses,
    );
  }

  Future<QuranPassage?> findPassageForSource(String sourceLabel) async {
    final reference = await parseReferenceLabel(sourceLabel);
    if (reference == null) {
      return null;
    }
    return getPassage(reference, sourceLabel: sourceLabel);
  }

  Future<String> _loadAsset() async {
    try {
      return await rootBundle.loadString(_packageAssetPath);
    } catch (_) {
      return rootBundle.loadString(_assetPath);
    }
  }

  Future<QuranReference?> parseReferenceLabel(String sourceLabel) async {
    await ensureLoaded();

    final cleaned = sourceLabel.trim();

    final rangeMatch = _rangePattern.firstMatch(cleaned);
    if (rangeMatch != null) {
      final surahToken = rangeMatch.group(1)!;
      final surahNumber = _findSurahNumber(surahToken);
      if (surahNumber == null) {
        return null;
      }

      final startAyah = int.parse(rangeMatch.group(2)!);
      final endAyah = int.parse(rangeMatch.group(3) ?? rangeMatch.group(2)!);

      return QuranReference(
        surahNumber: surahNumber,
        startAyah: startAyah,
        endAyah: endAyah,
      );
    }

    final surahOnlyMatch = _surahOnlyPattern.firstMatch(cleaned);
    if (surahOnlyMatch != null) {
      final surahNumber = int.parse(surahOnlyMatch.group(2)!);
      final surah = _surahsByNumber![surahNumber];
      if (surah == null) {
        return null;
      }

      return QuranReference(
        surahNumber: surahNumber,
        startAyah: 1,
        endAyah: surah.ayahs.length,
      );
    }

    return null;
  }

  int? _findSurahNumber(String token) {
    final normalized = _normalizeToken(token);
    if (normalized.isEmpty) {
      return null;
    }
    return _surahAliases![normalized];
  }

  String _defaultSourceLabel(_QuranSurah surah, QuranReference reference) {
    if (reference.startAyah == 1 && reference.endAyah == surah.ayahs.length) {
      return 'QS. ${surah.nameLatin} (${surah.number})';
    }
    if (reference.isSingleAyah) {
      return 'QS. ${surah.nameLatin}: ${reference.startAyah}';
    }
    return 'QS. ${surah.nameLatin}: ${reference.startAyah}-${reference.endAyah}';
  }

  Map<String, int> _buildSurahAliases(List<_QuranSurah> surahs) {
    final aliases = <String, int>{};

    void register(String alias, int surahNumber) {
      final normalized = _normalizeToken(alias);
      if (normalized.isNotEmpty) {
        aliases[normalized] = surahNumber;
      }
    }

    for (final surah in surahs) {
      register(surah.nameLatin, surah.number);
      register(surah.nameLatin.replaceAll('aa', 'a'), surah.number);
      register(surah.nameLatin.replaceAll('ii', 'i'), surah.number);
      register(surah.nameLatin.replaceAll('uu', 'u'), surah.number);

      final normalized = _normalizeToken(surah.nameLatin);
      if (normalized.endsWith('a')) {
        register('${surah.nameLatin}h', surah.number);
      }
      if (normalized.endsWith('ah')) {
        register(
          surah.nameLatin.substring(0, surah.nameLatin.length - 1),
          surah.number,
        );
      }
    }

    const manualAliases = <String, int>{
      'al fatihah': 1,
      'al baqarah': 2,
      'ali imran': 3,
      'an nisa': 4,
      'al maidah': 5,
      'al anam': 6,
      'al araf': 7,
      'al anfal': 8,
      'at taubah': 9,
      'at tawbah': 9,
      'yunus': 10,
      'hud': 11,
      'yusuf': 12,
      'ar rad': 13,
      'ibrahim': 14,
      'al hijr': 15,
      'an nahl': 16,
      'al isra': 17,
      'al israa': 17,
      'bani israil': 17,
      'al kahfi': 18,
      'maryam': 19,
      'ta ha': 20,
      'al anbiya': 21,
      'al hajj': 22,
      'al muminun': 23,
      'an nur': 24,
      'al furqan': 25,
      'asy syuara': 26,
      'ash shaffat': 37,
      'as shaffat': 37,
      'as saffat': 37,
      'al ikhlas': 112,
      'al ikhlaas': 112,
      'al falaq': 113,
      'an nas': 114,
      'an naas': 114,
    };

    manualAliases.forEach(register);
    return aliases;
  }

  String _normalizeToken(String value) {
    return value
        .toLowerCase()
        .replaceAll(RegExp(r'qs\.?'), '')
        .replaceAll(RegExp(r'[^a-z0-9]+'), ' ')
        .trim();
  }
}

class _QuranSurah {
  final int number;
  final String nameLatin;
  final List<_QuranAyah> ayahs;

  const _QuranSurah({
    required this.number,
    required this.nameLatin,
    required this.ayahs,
  });

  factory _QuranSurah.fromJson(Map<String, dynamic> json) {
    return _QuranSurah(
      number: json['number'] as int,
      nameLatin: json['nameLatin'] as String,
      ayahs: (json['ayahs'] as List<dynamic>)
          .map((item) => Map<String, dynamic>.from(item as Map))
          .map(_QuranAyah.fromJson)
          .toList(growable: false),
    );
  }
}

class _QuranAyah {
  final int number;
  final String text;

  const _QuranAyah({required this.number, required this.text});

  factory _QuranAyah.fromJson(Map<String, dynamic> json) {
    return _QuranAyah(
      number: json['number'] as int,
      text: json['text'] as String,
    );
  }
}
