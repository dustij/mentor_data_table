import "package:flutter/material.dart";

import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "package:mentor_data_table/providers/table_state.dart";
import "package:mentor_data_table/services/download_service.dart";
import "package:mentor_data_table/widgets/entries_table.dart";
import "package:mentor_data_table/widgets/filter_menu.dart";
import "package:mentor_data_table/widgets/table_search_bar.dart";

class TableScreen extends HookConsumerWidget {
  const TableScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tableState = ref.watch(tableStateProvider);

    // Local state for showing filters menu
    final isFilterMenuOpen = useState(false);

    // Link to position, place menu below search bar
    final layerLink = useRef(LayerLink()).value;

    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              if (isFilterMenuOpen.value) isFilterMenuOpen.value = false;
            },
            behavior: HitTestBehavior.opaque,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Expanded(
                        child: CompositedTransformTarget(
                          link: layerLink,
                          child: TableSearchBar(),
                        ),
                      ),
                      FilledButton.icon(
                        onPressed: () {
                          isFilterMenuOpen.value = !isFilterMenuOpen.value;
                        },
                        label: const Text("Filter"),
                        icon: const Icon(Icons.filter_list),
                      ),
                      Spacer(),
                      ElevatedButton.icon(
                        onPressed: () {
                          // TODO: on success show a snackbar notification
                          DownloadService().download(tableState.processedData);
                        },
                        icon: Icon(Icons.download),
                        label: Text("Download"),
                      ),
                    ],
                  ),
                ),
                Expanded(child: EntriesTable()),
              ],
            ),
          ),
          // Filter Menu
          if (isFilterMenuOpen.value)
            CompositedTransformFollower(
              link: layerLink,
              showWhenUnlinked: false,
              offset: Offset(0, 40),
              child: FilterMenu(onClose: () => isFilterMenuOpen.value = false),
            ),
        ],
      ),
    );
  }
}
