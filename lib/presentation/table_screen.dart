import "package:flutter/material.dart";

import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../presentation/filter_menu.dart";
import "../presentation/sticky_header_table.dart";
import "../providers/filter_menu_open_notifier.dart";
import "../providers/processed_data.dart";

import "download_button.dart";
import "search_filter_bar.dart";

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
                      DownloadButton(exportData: exportData),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                // ---------------------------------
                // Table
                // ---------------------------------
                Expanded(
                  child: StickyHeaderTable(),
                  // ),
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
