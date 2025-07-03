import "package:flutter/foundation.dart";

Future<bool> exportXlsPlatformSpecific(Uint8List bytes, String fileName) async {
  throw UnsupportedError("Xls export is not supported by this platform.");
}
