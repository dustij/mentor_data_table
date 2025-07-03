import "package:flutter/material.dart";

import "package:hooks_riverpod/hooks_riverpod.dart";

import "../application/providers/processed_data.dart";
import "../application/providers/sort_list_notifier.dart";
import "../domain/entry.dart";
import "../domain/sort.dart";

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
              columns: _buildColumns(sortList, sortListNotifier),
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
            Text(field.toString()),
            const SizedBox(width: 4),
            sortIcon ?? const SizedBox(width: 16, height: 16),
          ],
        ),
        onSort: (_, _) => notifier.updateSort(field),
      );
    }).toList();
  }
}
