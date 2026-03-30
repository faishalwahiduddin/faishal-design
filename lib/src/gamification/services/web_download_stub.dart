import 'dart:typed_data';

/// Stub method for non-web platforms (Mobile, Desktop).
/// Does nothing since downloading a file directly via a browser API is a web-only feature.
void downloadImage(Uint8List imageBytes, String filename) {
  // No-op on native platforms
}
