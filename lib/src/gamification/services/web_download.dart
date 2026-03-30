import 'dart:convert';
import 'dart:typed_data';

// Using package:web since dart:html is legacy
import 'package:web/web.dart' as web;

/// Downloads the [imageBytes] as a PNG file named [filename] using the browser.
void downloadImage(Uint8List imageBytes, String filename) {
  final base64Image = base64Encode(imageBytes);
  final url = 'data:image/png;base64,$base64Image';

  final web.HTMLAnchorElement anchor =
      web.document.createElement('a') as web.HTMLAnchorElement;
  anchor.href = url;
  anchor.download = filename;

  web.document.body?.appendChild(anchor);
  anchor.click();
  web.document.body?.removeChild(anchor);
}
