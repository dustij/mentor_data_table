import "dart:convert";
import "dart:typed_data";

import "package:universal_html/html.dart";

Future<bool> exportXlsPlatformSpecific(Uint8List bytes, String fileName) async {
  try {
    final base64 = base64Encode(bytes);
    AnchorElement(
        href: "data:application/octet-stream;charset-utf-16le;base64,$base64",
      )
      ..setAttribute("download", fileName)
      ..click();

    return true;
  } on Exception catch (_) {
    return false;
  }
}
