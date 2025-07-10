/// Module: Table Screen
///
/// The main scaffold for the mentor sessions feature. Combines:
/// - A responsive search and filter bar.
/// - A download button for exporting data.
/// - A horizontally scrollable sessions table.
/// - An overlay filter menu tied to the search bar position.
library;

import "package:flutter/material.dart";

import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:mentor_data_table/ui/core/breakpoints.dart";

import "../view_models/table_viewmodel.dart";

import "filter_menu.dart";
import "mentor_session_table.dart";
import "search_filter_bar.dart";

/// A `HookConsumerWidget` that composes the overall table screen.
///
/// Manages:
/// - Tapping outside to close the filter menu.
/// - Laying out the search/filter bar, download button, and table.
/// - Positioning the filter menu overlay beneath the search bar.
class TableScreen extends HookConsumerWidget {
  const TableScreen({super.key});

  /// Builds the screen UI including:
  /// - A `SafeArea` with a `Stack` for layering.
  /// - A `GestureDetector` to dismiss the filter menu on outside taps.
  /// - A `Column` with search/filter bar, download button, and table.
  /// - Conditional overlay of the `FilterMenu` when open.
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
      body: SafeArea(
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                if (isFilterMenuOpen) viewModel.toggleFilterMenu();
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
                        context.responsive<Widget>(
                          base: ElevatedButton(
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
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 0),
                            ),
                            child: Icon(Icons.download),
                          ),
                          sm: ElevatedButton.icon(
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
                            icon: Icon(Icons.download),
                            label: Text("Download"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),

                  // ---------------------------------
                  // Table
                  // ---------------------------------
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        // constraints.maxWidth is the full width available to the Column
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ConstrainedBox(
                            // force the table to be at least as wide
                            // as the Column (so it never shrinks past the screen)
                            constraints: BoxConstraints(
                              minWidth: constraints.maxWidth,
                            ),
                            // but it can grow wider if MentorSessionTable needs more
                            child: MentorSessionTable(),
                          ),
                        );
                      },
                    ),
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
                  onTap: () {
                    if (isFilterMenuOpen) viewModel.toggleFilterMenu();
                  },
                  behavior: HitTestBehavior.translucent,
                  child: const SizedBox.expand(),
                ),
              ),
            if (isFilterMenuOpen)
              CompositedTransformFollower(
                link: layerLink,
                showWhenUnlinked: false,
                offset: const Offset(0, 56),
                child: SingleChildScrollView(child: FilterMenu()),
              ),
          ],
        ),
      ),
    );
  }
}
