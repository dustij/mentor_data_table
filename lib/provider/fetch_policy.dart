import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import 'form_entry.dart';

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
    final List<dynamic> jsonList = json.decode(source);
    return jsonList.map((item) => FormEntry.fromJson(item)).toList();
  }
}

// Choose policy here
const FetchPolicy activeFetchPolicy = ExamplePolicy();
