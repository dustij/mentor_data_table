import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../provider/form_entries_provider.dart';
import '../provider/form_entry.dart';

class MentorTable extends ConsumerWidget {
  const MentorTable({super.key});

  List<DataColumn> _createColumns(WidgetRef ref) {
    final notifier = ref.read(formEntriesProvider.notifier);
    return FormEntry.fields.map((field) {
      return DataColumn(
        label: Text(field),
        onSort: (_, _) {
          // Get the function for the selected column to compare its values between two rows.
          // final getter = FormEntry.fieldGetters[field]!;
          // notifier.sortBy(field, (a, b) => getter(a).compareTo(getter(b)));
          notifier.sortBy(field, (a, b) => a[field].compareTo(b[field]));
        },
      );
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
            child: SingleChildScrollView(
              child: DataTable(
                columns: _createColumns(ref),
                rows: _createRows(entries),
              ),
            ),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Error: $error',
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
