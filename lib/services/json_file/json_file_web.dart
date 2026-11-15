import 'dart:async';
import 'dart:js_interop';

import 'package:web/web.dart' as web;

/// Triggers a browser download of [json]. Returns true when downloaded.
Future<bool> saveJsonFile(String json, String fileName) async {
  final blob = web.Blob(
    [json.toJS].toJS,
    web.BlobPropertyBag(type: 'application/json'),
  );
  final url = web.URL.createObjectURL(blob);
  final anchor = web.HTMLAnchorElement()
    ..href = url
    ..download = fileName
    ..style.display = 'none';
  web.document.body?.appendChild(anchor);
  anchor.click();
  anchor.remove();
  web.URL.revokeObjectURL(url);
  return true;
}

/// Opens the browser file picker and returns the chosen file's text,
/// or null if nothing was picked.
Future<String?> pickJsonFile() async {
  final input = web.HTMLInputElement()
    ..type = 'file'
    ..accept = '.json,application/json';
  final completer = Completer<String?>();
  input.onchange = ((web.Event _) {
    final file = input.files?.item(0);
    if (file == null) {
      completer.complete(null);
      return;
    }
    file.text().toDart.then(
          (text) => completer.complete(text.toDart),
          onError: completer.completeError,
        );
  }).toJS;
  input.oncancel = ((web.Event _) {
    if (!completer.isCompleted) completer.complete(null);
  }).toJS;
  input.click();
  return completer.future;
}

const bool canPickJsonFile = true;
