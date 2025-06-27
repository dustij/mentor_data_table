import "package:flutter/services.dart" show rootBundle;

import "../models/form_entry.dart";

import "fetch_policy.dart";

/// Example policy used for development and debugging.
/// It loads dummy data from a local JSON file.
class ExamplePolicy implements FetchPolicy {
  @override
  Future<List<FormEntry>> fetch() async {
    final source = await rootBundle.loadString("examples/example.json");
    return FetchPolicy.parseJson(source);
  }
}
