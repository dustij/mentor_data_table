import "dart:convert";

import "../models/form_entry.dart";

/// A policy defining how to fetch `FormEntry` data.
abstract interface class FetchPolicy {
  /// Retrieves a list of `FormEntry` items according to this fetch policy.
  Future<List<FormEntry>> fetch();

  /// Decodes a JSON string into a list of `FormEntry` objects.
  static List<FormEntry> parseJson(String source) {
    final List<dynamic> jsonList = json.decode(source);
    return jsonList.map((e) => FormEntry.fromJson(e)).toList();
  }
}
