import "package:flutter/services.dart";

import "../domain/entry.dart";

import "source_policy.dart";

class LocalSource implements SourcePolicy {
  final String path;

  LocalSource({required this.path});

  @override
  Future<List<Entry>> fetchAll() async {
    final source = await rootBundle.loadString(path);
    return SourcePolicy.parseJson(source);
  }
}
