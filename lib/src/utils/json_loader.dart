import 'dart:convert';
import 'package:flutter/services.dart';

/// A utility class for loading and parsing JSON data from Flutter assets.
class JsonLoader {
  /// Loads and parses a single JSON object from the given asset path.
  ///
  /// Throws an exception if the file cannot be found, read, or parsed.
  static Future<T> load<T>(
    String assetPath,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    try {
      final jsonString = await rootBundle.loadString(assetPath);
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return fromJson(jsonMap);
    } catch (e) {
      throw Exception('Failed to load JSON from $assetPath: $e');
    }
  }

  /// Loads and parses a JSON array (list) from the given asset path.
  ///
  /// Throws an exception if the file cannot be found, read, or parsed.
  static Future<List<T>> loadList<T>(
    String assetPath,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    try {
      final jsonString = await rootBundle.loadString(assetPath);
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList
          .map((item) => fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to load JSON list from $assetPath: $e');
    }
  }
}
