import "package:flutter/material.dart";

import "package:hooks_riverpod/hooks_riverpod.dart";

import "package:mentor_data_table/providers/table_controller.dart";
import "package:mentor_data_table/widgets/form_entry_table.dart";
import "package:mentor_data_table/widgets/table_search_bar.dart";

class TableScreen extends HookConsumerWidget {
  const TableScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tableState = ref.watch(tableControllerProvider);

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TableSearchBar(
                    onSearch: (value) => ref
                        .read(tableControllerProvider.notifier)
                        .search(value),
                  ),
                ),
                SizedBox(width: 8),
                FilledButton.icon(
                  onPressed: () => [], // TODO
                  label: Text("Filter"),
                  icon: Icon(Icons.filter_list),
                ),
                Spacer(),
                ElevatedButton.icon(
                  onPressed: () => {}, // TODO
                  icon: Icon(Icons.download),
                  label: Text("Download"),
                ),
              ],
            ),
          ),
          Divider(),
          Expanded(
            child: tableState.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text("Error: $e"),
              data: (state) {
                return FormEntryTable(
                  entries: state.resultSet,
                  onSort: (field) => ref
                      .read(tableControllerProvider.notifier)
                      .toggleSort(field),
                  sortOrder: state.sortOrder,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
