import "package:flutter/material.dart";

import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../providers/table_controller.dart";
import "../widgets/filter_builder_dropdown.dart";
import "../widgets/form_entry_table.dart";
import "../widgets/table_search_bar.dart";

/// A screen widget displaying the data table with search, filter, and download controls.
///
/// - Shows a loading spinner while data is being fetched.
/// - Displays errors if fetching fails.
/// - Renders a search bar and buttons for filtering and downloading.
/// - Displays the table of entries with sort capabilities.
class TableScreen extends HookConsumerWidget {
  const TableScreen({super.key});

  @override
  /// Builds the UI hierarchy for the table screen, wiring up
  /// state from [tableControllerProvider] and handlers for search
  /// and sort interactions.
  Widget build(BuildContext context, WidgetRef ref) {
    final tableState = ref.watch(tableControllerProvider);

    // Local state for showing the filter dropdown
    final isFilterOpen = useState(false);
    // Link to position the dropdown below the Filter button
    final filterLink = useRef(LayerLink()).value;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          if (isFilterOpen.value) isFilterOpen.value = false;
        },
        behavior: HitTestBehavior.opaque,
        child: Stack(
          children: [
            Column(
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
                      CompositedTransformTarget(
                        link: filterLink,
                        child: FilledButton.icon(
                          onPressed: () {
                            isFilterOpen.value = !isFilterOpen.value;
                          },
                          label: const Text("Filter"),
                          icon: const Icon(Icons.filter_list),
                          style: FilledButton.styleFrom(
                            backgroundColor: isFilterOpen.value
                                ? null
                                : Theme.of(context).colorScheme.secondary,
                            foregroundColor: isFilterOpen.value
                                ? null
                                : Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
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
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
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
            if (isFilterOpen.value)
              Positioned.fill(
                child: GestureDetector(
                  onTap: () => isFilterOpen.value = false,
                  behavior: HitTestBehavior.translucent,
                  child: const SizedBox.expand(),
                ),
              ),
            if (isFilterOpen.value)
              CompositedTransformFollower(
                link: filterLink,
                showWhenUnlinked: false,
                offset: const Offset(0, 40),
                child: const FilterBuilderDropdown(),
              ),
          ],
        ),
      ),
    );
  }
}
