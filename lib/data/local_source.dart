import "package:flutter/services.dart";

import "package:mentor_data_table/data/source_policy.dart";
import "package:mentor_data_table/models/entry.dart";

class LocalSource implements SourcePolicy {
  final String path;

  LocalSource({required this.path});

  @override
  Future<List<Entry>> fetchAll() async {
    final source = await rootBundle.loadString(path);
    return SourcePolicy.parseJson(source);
  }
}
