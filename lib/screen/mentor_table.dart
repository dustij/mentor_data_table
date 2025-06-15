import 'package:flutter/material.dart';
import 'package:mentor_data_table/data/data_source_policy.dart';

import '../data/submission_entry.dart';

class MentorTable extends StatelessWidget {
  final DataSourcePolicy dataSource;

  const MentorTable(this.dataSource, {super.key});

  List<DataColumn> _createColumns() {
    return SubmissionEntry.fields().map((name) {
      return DataColumn(label: Text(name));
    }).toList();
  }

  List<DataRow> _createRows() {
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox.expand(
          child: DataTable(columns: _createColumns(), rows: _createRows()),
        ),
      ),
    );
  }
}
