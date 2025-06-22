import "dart:convert";

import "../models/form_entry.dart";

abstract interface class FetchPolicy {
  Future<List<FormEntry>> fetch();

  /// Parses a JSON string into a list of [FormEntry] objects.
  static List<FormEntry> parseJson(String source) {
    final List<dynamic> jsonList = json.decode(source);
    return jsonList.map((e) => FormEntry.fromJson(e)).toList();
  }
}
