import "dart:convert";

import "../models/entry.dart";

abstract class SourcePolicy {
  Future<List<Entry>> fetchAll();

  static List<Entry> parseJson(String source) {
    final List<dynamic> jsonList = json.decode(source);
    return jsonList.map((e) => Entry.fromJson(e)).toList();
  }
}
