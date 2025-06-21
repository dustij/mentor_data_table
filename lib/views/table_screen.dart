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
          Row(
            children: [
              Expanded(
                child: TableSearchBar(
                  onSearch: (query) => ref
                      .read(tableControllerProvider.notifier)
                      .setSearchQuery(query),
                ),
              ),
            ],
          ),
          Expanded(
            child: tableState.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text('Error: $e'),
              data: (state) {
                return FormEntryTable(
                  entries: state.filteredData,
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
