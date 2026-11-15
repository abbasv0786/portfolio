import 'package:flutter/services.dart';

/// Off the web there is no download folder to drop a file into, so the JSON
/// is copied to the clipboard instead. Returns false to say "not downloaded".
Future<bool> saveJsonFile(String json, String fileName) async {
  await Clipboard.setData(ClipboardData(text: json));
  return false;
}

/// File picking is web-only; callers fall back to pasting the JSON.
Future<String?> pickJsonFile() async => null;

const bool canPickJsonFile = false;
