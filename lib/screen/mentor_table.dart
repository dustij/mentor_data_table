import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../provider/form_entries_provider.dart';
import '../provider/form_entry.dart';

class MentorTable extends ConsumerWidget {
  const MentorTable({super.key});

  List<DataColumn> _createColumns() {
    return FormEntry.fields.map((field) {
      return DataColumn(label: Text(field));
    }).toList();
  }

  List<DataRow> _createRows(List<FormEntry> entries) {
    return entries.map((entry) {
      return DataRow(
        cells: [
          DataCell(Text(entry.mentorName)),
          DataCell(Text(entry.studentName)),
          DataCell(Text(entry.sessionDetails)),
          DataCell(Text(entry.notes)),
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // async because likely fetching from database via http request
    final asyncData = ref.watch(formEntriesProvider);

    return Scaffold(
      body: asyncData.when(
        data: (entries) => Center(
          child: SizedBox.expand(
            child: DataTable(
              columns: _createColumns(),
              rows: _createRows(entries),
            ),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            const Center(child: Text("Oops, something went wrong.")),
      ),
    );
  }
}
