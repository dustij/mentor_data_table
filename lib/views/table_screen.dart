import "package:flutter/material.dart";

import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:mentor_data_table/providers/table_controller.dart";

import "../models/form_entry.dart";

class TableScreen extends HookConsumerWidget {
  const TableScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tableState = ref.watch(tableControllerProvider);

    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: SearchAnchor.bar(suggestionsBuilder: (_, _) => []),
              ),
            ],
          ),
          Expanded(
            child: tableState.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text('Error: $e'),
              data: (state) {
                return SizedBox.expand(
                  child: SingleChildScrollView(
                    child: DataTable(
                      columns: FormEntry.fields
                          .map((label) => _buildColumn(ref, label))
                          .toList(),
                      rows: state.filteredData
                          .map((data) => _buildRow(data))
                          .toList(),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  DataColumn _buildColumn(WidgetRef ref, Field field) {
    return DataColumn(
      label: Text(field.toString()),
      onSort: (_, _) =>
          ref.read(tableControllerProvider.notifier).toggleSort(field),
    );
  }

  DataRow _buildRow(FormEntry data) {
    return DataRow(
      cells: FormEntry.fields
          .map((label) => DataCell(Text(data[label])))
          .toList(),
    );
  }
}
