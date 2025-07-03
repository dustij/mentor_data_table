import "package:flutter/services.dart";

import "../data/source_policy.dart";
import "../models/entry.dart";

class LocalSource implements SourcePolicy {
  final String path;

  LocalSource({required this.path});

  @override
  Future<List<Entry>> fetchAll() async {
    final source = await rootBundle.loadString(path);
    return SourcePolicy.parseJson(source);
  }
}
