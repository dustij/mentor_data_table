import "package:flutter/material.dart";

import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:mentor_data_table/providers/processed_data.dart";
import "package:mentor_data_table/services/export/xls_export_service.dart";

import "../providers/filter_list_notifier.dart";
import "../theme/shadcn_theme.dart";
import "../presentation/filter_menu.dart";
import "table_search_filter_bar.dart";
import "../presentation/table_view.dart";

class TableScreen extends HookConsumerWidget {
  const TableScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Local state for showing filters menu
    final isFilterMenuOpen = useState(false);

    // For changing filter button when advance filter is applied (like Jotform's)
    final filterList = ref.watch(filterListNotifierProvider);
    final filterListNotifier = ref.read(filterListNotifierProvider.notifier);

    // Data to export
    final exportData = ref.watch(processedDataProvider);

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
                      // Expanded(
                      CompositedTransformTarget(
                        link: layerLink,
                        child: TableSearchFilterBar(),
                      ),
                      // ),
                      // // ---------------------------------
                      // // Filter Button
                      // // ---------------------------------
                      // FilledButtonTheme(
                      //   // TODO: make like Jotform
                      //   data: ShadcnTheme.filterButtonTheme,
                      //   child: FilledButton.icon(
                      //     onPressed: () {
                      //       isFilterMenuOpen.value = !isFilterMenuOpen.value;
                      //     },
                      //     label: const Text("Filter"),
                      //     icon: const Icon(Icons.filter_list),
                      //   ),
                      // ),
                      Spacer(),
                      // ---------------------------------
                      // Download Button
                      // ---------------------------------
                      ElevatedButton.icon(
                        onPressed: () {
                          exportData.when(
                            data: (data) {
                              final exportService = XlsExportService();
                              exportService.export(
                                fileName: "test",
                                context: context,
                                data: data,
                              );
                            },
                            error: (_, _) =>
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Oops! Something went wrong.",
                                    ),
                                  ),
                                ),
                            loading: () =>
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Cool! Your download is started.",
                                    ),
                                  ),
                                ),
                          );
                        },
                        icon: Icon(Icons.download),
                        label: Text("Download"),
                      ),
                    ],
                  ),
                ),
                Expanded(child: TableView()),
              ],
            ),
          ),
          // Filter Menu
          if (isFilterMenuOpen.value)
            // Ensures filter menu actually closes
            Positioned.fill(
              child: GestureDetector(
                onTap: () => isFilterMenuOpen.value = false,
                behavior: HitTestBehavior.translucent,
                child: const SizedBox.expand(),
              ),
            ),
          if (isFilterMenuOpen.value)
            CompositedTransformFollower(
              link: layerLink,
              showWhenUnlinked: false,
              offset: Offset(0, 80),
              child: FilterMenu(onClose: () => isFilterMenuOpen.value = false),
            ),
        ],
      ),
    );
  }
}
