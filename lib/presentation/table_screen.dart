import "package:flutter/material.dart";

import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:mentor_data_table/providers/filter_menu_open_notifier.dart";
import "package:mentor_data_table/providers/processed_data.dart";
import "package:mentor_data_table/services/export/xls_export_service.dart";

import "../presentation/filter_menu.dart";
import "table_search_filter_bar.dart";
import "../presentation/table_view.dart";

class TableScreen extends HookConsumerWidget {
  const TableScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Toggle filter menu
    final filterMenuOpen = ref.watch(filterMenuOpenNotifierProvider);
    final filterMenuOpenNotifier = ref.read(
      filterMenuOpenNotifierProvider.notifier,
    );

    // Data to export
    final exportData = ref.watch(processedDataProvider);

    // Link to position, place menu below search bar
    final layerLink = useRef(LayerLink()).value;

    // TODO: Padding (responsive)
    const padding = 16.0;

    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              if (filterMenuOpen) filterMenuOpenNotifier.toggle();
            },
            behavior: HitTestBehavior.opaque,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    padding,
                    padding,
                    padding,
                    0,
                  ),
                  child: Row(
                    children: [
                      // ---------------------------------
                      // Search and Filter Button
                      // ---------------------------------
                      CompositedTransformTarget(
                        link: layerLink,
                        child: TableSearchFilterBar(),
                      ),
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
                // ---------------------------------
                // Table
                // ---------------------------------
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(padding),
                    child: TableView(),
                  ),
                ),
              ],
            ),
          ),
          // ---------------------------------
          // Filter Menu
          // ---------------------------------
          if (filterMenuOpen)
            // Ensures filter menu actually closes
            Positioned.fill(
              child: GestureDetector(
                onTap: () => filterMenuOpenNotifier.toggle(),
                behavior: HitTestBehavior.translucent,
                child: const SizedBox.expand(),
              ),
            ),
          if (filterMenuOpen)
            CompositedTransformFollower(
              link: layerLink,
              showWhenUnlinked: false,
              offset: Offset(8, 68),
              child: FilterMenu(onClose: () => filterMenuOpenNotifier.toggle()),
            ),
        ],
      ),
    );
  }
}
