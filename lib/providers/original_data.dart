import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../data/local_source.dart";
import "../models/entry.dart";

// to generate run: `dart run build_runner build --delete-conflicting-outputs`
part "original_data.g.dart";

@riverpod
Future<List<Entry>> originalData(Ref ref) async {
  return LocalSource(path: "examples/example.json").fetchAll();
}
