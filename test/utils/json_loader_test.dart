import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:faishal_design/faishal_design.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('JsonLoader', () {
    const String validObjectAsset = 'assets/test_object.json';
    const String validListAsset = 'assets/test_list.json';
    const String invalidAsset = 'assets/missing.json';
    const String malformedAsset = 'assets/malformed.json';

    setUpAll(() {
      // Mock rootBundle responses
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMessageHandler('flutter/assets', (ByteData? message) async {
            if (message == null) return null;
            final String key = utf8.decode(message.buffer.asUint8List());

            if (key == validObjectAsset) {
              final ByteData data = ByteData.view(
                Uint8List.fromList(
                  utf8.encode('{"id": 1, "name": "test"}'),
                ).buffer,
              );
              return data;
            } else if (key == validListAsset) {
              final ByteData data = ByteData.view(
                Uint8List.fromList(
                  utf8.encode(
                    '[{"id": 1, "name": "test1"}, {"id": 2, "name": "test2"}]',
                  ),
                ).buffer,
              );
              return data;
            } else if (key == malformedAsset) {
              final ByteData data = ByteData.view(
                Uint8List.fromList(
                  utf8.encode('{"id": 1, "name": "test"'),
                ).buffer,
              ); // missing closing brace
              return data;
            }

            return null; // Return null for missing files
          });
    });

    test('load parses a valid JSON object', () async {
      final result = await JsonLoader.load<Map<String, dynamic>>(
        validObjectAsset,
        (json) => json,
      );

      expect(result['id'], 1);
      expect(result['name'], 'test');
    });

    test('load throws Exception for missing asset', () async {
      expect(
        () =>
            JsonLoader.load<Map<String, dynamic>>(invalidAsset, (json) => json),
        throwsException,
      );
    });

    test('load throws Exception for malformed JSON', () async {
      expect(
        () => JsonLoader.load<Map<String, dynamic>>(
          malformedAsset,
          (json) => json,
        ),
        throwsException,
      );
    });

    test('loadList parses a valid JSON array', () async {
      final result = await JsonLoader.loadList<Map<String, dynamic>>(
        validListAsset,
        (json) => json,
      );

      expect(result.length, 2);
      expect(result[0]['id'], 1);
      expect(result[0]['name'], 'test1');
      expect(result[1]['id'], 2);
      expect(result[1]['name'], 'test2');
    });

    test('loadList throws Exception for missing asset', () async {
      expect(
        () => JsonLoader.loadList<Map<String, dynamic>>(
          invalidAsset,
          (json) => json,
        ),
        throwsException,
      );
    });

    test('loadList throws Exception for malformed JSON', () async {
      expect(
        () => JsonLoader.loadList<Map<String, dynamic>>(
          malformedAsset,
          (json) => json,
        ),
        throwsException,
      );
    });
  });
}
