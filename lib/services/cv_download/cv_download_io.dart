import 'dart:typed_data';

import 'package:printing/printing.dart';

/// Opens the platform share sheet for the PDF on mobile/desktop.
Future<void> savePdf(Uint8List bytes, String fileName) =>
    Printing.sharePdf(bytes: bytes, filename: fileName);
