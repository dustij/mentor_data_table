import "package:flutter/material.dart";

import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:mentor_data_table/presentation/sticky_header_table.dart";
import "package:mentor_data_table/providers/filter_menu_open_notifier.dart";
import "package:mentor_data_table/providers/processed_data.dart";
import "package:mentor_data_table/services/export/xls_export_service.dart";

import "../presentation/filter_menu.dart";
import "search_filter_bar.dart";
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
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Row(
                    children: [
                      // ---------------------------------
                      // Search and Filter Button
                      // ---------------------------------
                      CompositedTransformTarget(
                        link: layerLink,
                        child: SearchFilterBar(),
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
                SizedBox(height: 16),
                // ---------------------------------
                // Table
                // ---------------------------------
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      border: BoxBorder.fromLTRB(
                        top: BorderSide(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ),
                    ),
                    // child: TableView(),
                    child: StickyHeaderTable(),
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
          // Filter menu widget
          if (filterMenuOpen)
            CompositedTransformFollower(
              link: layerLink,
              showWhenUnlinked: false,
              offset: Offset(0, 56),
              child: FilterMenu(onClose: () => filterMenuOpenNotifier.toggle()),
            ),
        ],
      ),
    );
  }
}
