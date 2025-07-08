import "package:flutter/material.dart";

import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../view_models/table_viewmodel.dart";

import "filter_menu.dart";
import "mentor_session_table.dart";
import "search_filter_bar.dart";

class TableScreen extends HookConsumerWidget {
  const TableScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(tableViewModelProvider);
    final viewModel = ref.read(tableViewModelProvider.notifier);

    final isFilterMenuOpen = state.when(
      data: (s) => s.isFilterMenuOpen,
      loading: () => false,
      error: (_, _) => false,
    );

    // Link to position, place menu below search bar
    final layerLink = useRef(LayerLink()).value;

    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: viewModel.toggleFilterMenu,
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
                        onPressed: () async {
                          if (!state.hasValue) return;
                          final isSuccess = await viewModel.exportToXls();
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  isSuccess
                                      ? "All done! Your Excel file is good to go."
                                      : "Oops! Something went wrong...",
                                ),
                              ),
                            );
                          }
                        },
                        label: Text("Download"),
                        icon: Icon(Icons.download),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                // ---------------------------------
                // Table
                // ---------------------------------
                Expanded(
                  child: MentorSessionTable(),
                  // ),
                ),
              ],
            ),
          ),
          // ---------------------------------
          // Filter Menu
          // ---------------------------------
          if (isFilterMenuOpen)
            Positioned.fill(
              child: GestureDetector(
                onTap: viewModel.toggleFilterMenu,
                behavior: HitTestBehavior.translucent,
                child: const SizedBox.expand(),
              ),
            ),
          if (isFilterMenuOpen)
            CompositedTransformFollower(
              link: layerLink,
              showWhenUnlinked: false,
              offset: const Offset(0, 56),
              child: FilterMenu(),
            ),
        ],
      ),
    );
  }
}
