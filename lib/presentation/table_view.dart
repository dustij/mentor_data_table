import "package:flutter/material.dart";

import "package:hooks_riverpod/hooks_riverpod.dart";

import "../models/entry.dart";
import "../models/sort.dart";
import "../providers/sort_list_notifier.dart";
import "../providers/processed_data.dart";

class TableView extends ConsumerWidget {
  const TableView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final processedData = ref.watch(processedDataProvider);
    final sortList = ref.watch(sortListNotifierProvider);
    final sortListNotifier = ref.read(sortListNotifierProvider.notifier);

    return processedData.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Text("Error: $e"),
      data: (entries) {
        return SizedBox.expand(
          child: SingleChildScrollView(
            child: DataTable(
              rows: _buildRows(entries),
              columns: _buildColumns(sortList, sortListNotifier, context),
            ),
          ),
        );
      },
    );
  }

  List<DataRow> _buildRows(List<Entry> entries) {
    return entries
        .map(
          (data) => DataRow(
            key: ValueKey(
              '${data.mentorName}-${data.studentName}-${data.sessionDetails}',
            ),
            cells: Entry.fields
                .map((label) => DataCell(Text(data[label])))
                .toList(),
          ),
        )
        .toList();
  }

  List<DataColumn> _buildColumns(
    List<Sort> sortList,
    SortListNotifier notifier,
    BuildContext context,
  ) {
    return Entry.fields.map((field) {
      final sortState = sortList.firstWhere(
        (s) => s.field == field,
        orElse: () =>
            Sort(field: EntryField.mentorName, direction: SortDirection.none),
      );

      Icon? sortIcon;
      if (sortState.direction == SortDirection.asc) {
        sortIcon = const Icon(Icons.arrow_upward, size: 16);
      } else if (sortState.direction == SortDirection.desc) {
        sortIcon = const Icon(Icons.arrow_downward, size: 16);
      }

      return DataColumn(
        label: Row(
          children: [
            Text(
              field.toString(),
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(width: 16),
            sortIcon ?? const SizedBox(width: 16, height: 16),
          ],
        ),
        onSort: (_, _) => notifier.updateSort(field),
      );
    }).toList();
  }
}
