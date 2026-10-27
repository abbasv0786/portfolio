import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:image_picker/image_picker.dart';

/// Stores images inline in Firestore as `data:` URLs (free tier, no
/// Firebase Storage needed). Firestore documents are capped at 1 MiB, so
/// images are resized on pick and rejected above [maxBytes].
class ImageService {
  ImageService._();

  static const int maxBytes = 600 * 1024;

  static bool isDataUrl(String path) => path.startsWith('data:image/');

  static bool isRemote(String path) =>
      path.startsWith('http://') || path.startsWith('https://');

  /// Bundled asset paths (e.g. `assets/images/x.webp`).
  static bool isAsset(String path) =>
      path.isNotEmpty && !isDataUrl(path) && !isRemote(path);

  /// Lets the admin pick an image, resized to fit, and returns it as a data
  /// URL. Returns null if the picker was cancelled.
  static Future<String?> pickImageAsDataUrl({double maxWidth = 1200}) async {
    final file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: maxWidth,
      imageQuality: 80,
    );
    if (file == null) return null;
    return toDataUrl(await file.readAsBytes(), file.name,
        mimeType: file.mimeType);
  }

  /// Converts a bundled asset into a data URL.
  static Future<String> assetToDataUrl(String assetPath) async {
    final data = await rootBundle.load(assetPath);
    return toDataUrl(data.buffer.asUint8List(), assetPath);
  }

  static String toDataUrl(Uint8List bytes, String fileName,
      {String? mimeType}) {
    if (bytes.lengthInBytes > maxBytes) {
      throw Exception(
          'Image is ${(bytes.lengthInBytes / 1024).round()} KB; please use one under ${maxBytes ~/ 1024} KB.');
    }
    final type = mimeType ?? _contentType(fileName);
    return 'data:$type;base64,${base64Encode(bytes)}';
  }

  static final Map<int, Uint8List> _decoded = {};

  /// Decodes a data URL, cached so rebuilds don't re-decode large strings.
  static Uint8List decode(String dataUrl) => _decoded.putIfAbsent(
        dataUrl.hashCode,
        () => UriData.parse(dataUrl).contentAsBytes(),
      );

  static String _contentType(String name) {
    switch (name.split('.').last.toLowerCase()) {
      case 'png':
        return 'image/png';
      case 'webp':
        return 'image/webp';
      case 'gif':
        return 'image/gif';
      default:
        return 'image/jpeg';
    }
  }
}
