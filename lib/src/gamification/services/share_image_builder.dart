import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:share_plus/share_plus.dart';

// Import our web utility conditionally or universally if we build it gracefully
import 'web_download_stub.dart'
    if (dart.library.js_interop) 'web_download.dart';

/// A utility service to capture a Flutter widget as an image and share it.
class ShareImageBuilder {
  /// Captures a [RepaintBoundary] identified by [key] as a PNG image.
  ///
  /// The [key] must be attached to a [RepaintBoundary] widget.
  static Future<Uint8List?> captureAsImage(
    GlobalKey key, {
    double pixelRatio = 3.0,
  }) async {
    try {
      final boundary =
          key.currentContext?.findRenderObject() as RenderRepaintBoundary?;

      if (boundary == null) {
        debugPrint('RenderRepaintBoundary not found for key: $key');
        return null;
      }

      if (boundary.debugNeedsPaint) {
        debugPrint('Waiting for boundary to be painted...');
        await Future.delayed(const Duration(milliseconds: 20));
        return captureAsImage(key, pixelRatio: pixelRatio);
      }

      final ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);
      final ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );

      if (byteData == null) {
        return null;
      }

      return byteData.buffer.asUint8List();
    } catch (e) {
      debugPrint('Error capturing image: $e');
      return null;
    }
  }

  /// Shares a PNG image using the native share sheet or triggers a download on the web.
  static Future<void> shareImage({
    required Uint8List imageBytes,
    String? text,
    String filename = 'share_image.png',
  }) async {
    if (kIsWeb) {
      // Trigger a browser download on web since share sheet behavior varies
      // and sharing files directly isn't universally supported via Web Share API
      // without specific user gestures and file formats.
      downloadImage(imageBytes, filename);
      return;
    }

    // Mobile platforms
    try {
      final xFile = XFile.fromData(
        imageBytes,
        mimeType: 'image/png',
        name: filename,
      );

      await Share.shareXFiles([xFile], text: text);
    } catch (e) {
      debugPrint('Error sharing image: $e');
      rethrow;
    }
  }

  /// Convenience method that captures the widget and shares it immediately.
  static Future<void> captureAndShare(
    GlobalKey key, {
    String? text,
    String filename = 'share_image.png',
    double pixelRatio = 3.0,
  }) async {
    final imageBytes = await captureAsImage(key, pixelRatio: pixelRatio);
    if (imageBytes != null) {
      await shareImage(imageBytes: imageBytes, text: text, filename: filename);
    }
  }
}
