import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "package:mentor_data_table/data/local_source.dart";
import "package:mentor_data_table/models/entry.dart";

// to generate run: `dart run build_runner build --delete-conflicting-outputs`
part "original_data.g.dart";

@riverpod
Future<List<Entry>> originalData(Ref ref) async {
  return LocalSource(path: "examples/example.json").fetchAll();
}
