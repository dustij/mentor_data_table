import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import 'form_entry.dart';

abstract interface class DataPolicy {
  Future<List<FormEntry>> fetchEntries();
}

/// Example policy used for development and debugging.
/// It loads dummy data from a local JSON file located in the `example/` directory.
class ExamplePolicy implements DataPolicy {
  const ExamplePolicy();
  @override
  Future<List<FormEntry>> fetchEntries() async {
    final source = await rootBundle.loadString("assets/example.json");
    final List<dynamic> jsonList = json.decode(source);
    return jsonList.map((item) => FormEntry.fromJson(item)).toList();
  }
}

// Choose policy here
const DataPolicy activePolicy = ExamplePolicy();
