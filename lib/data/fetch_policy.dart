import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../models/form_entry.dart';

abstract interface class FetchPolicy {
  Future<List<FormEntry>> fetch();
}

/// Example policy used for development and debugging.
/// It loads dummy data from a local JSON file located in the `example/` directory.
class ExamplePolicy implements FetchPolicy {
  const ExamplePolicy();
  @override
  Future<List<FormEntry>> fetch() async {
    final source = await rootBundle.loadString("assets/example.json");
    return _parseJson(source);
  }
}

/// Parses a JSON string into a list of [FormEntry] objects.
List<FormEntry> _parseJson(String source) {
  final List<dynamic> jsonList = json.decode(source);
  return jsonList.map((e) => FormEntry.fromJson(e)).toList();
}

// Choose policy here
const FetchPolicy activeFetchPolicy = ExamplePolicy();
