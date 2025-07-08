import "dart:io";
import "dart:typed_data";

import "package:open_file/open_file.dart";
import "package:path_provider/path_provider.dart";

Future<bool> exportXlsPlatformSpecific(Uint8List bytes, String fileName) async {
  try {
    final path = (await getApplicationSupportDirectory()).path;
    final filePath = Platform.isWindows
        ? "$path\\$fileName"
        : "$path/$fileName";
    final file = File(filePath);
    await file.writeAsBytes(bytes, flush: true);

    OpenFile.open(filePath);

    return true;
  } on Exception catch (_) {
    return false;
  }
}
