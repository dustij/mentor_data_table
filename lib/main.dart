import 'package:flutter/material.dart';
import 'package:mentor_data_table/data/data_source_policy.dart';
import 'package:mentor_data_table/screen/mentor_table.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MentorTable(ExampleSourcePolicy()));
  }
}
