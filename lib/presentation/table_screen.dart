import "package:flutter/material.dart";

import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../providers/filter_list_notifier.dart";
import "../theme/shadcn_theme.dart";
import "../presentation/filter_menu.dart";
import "../presentation/table_search_bar.dart";
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
                      // ---------------------------------
                      // Filter Button
                      // ---------------------------------
                      FilledButtonTheme(
                        // TODO: make like Jotform
                        data: ShadcnTheme.filterButtonTheme,
                        child: FilledButton.icon(
                          onPressed: () {
                            isFilterMenuOpen.value = !isFilterMenuOpen.value;
                          },
                          label: const Text("Filter"),
                          icon: const Icon(Icons.filter_list),
                        ),
                      ),
                      Spacer(),
                      // ---------------------------------
                      // Download Button
                      // ---------------------------------
                      ElevatedButton.icon(
                        onPressed: () {
                          // TODO: xls export service
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
