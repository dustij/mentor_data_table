/// Module: Search & Filter Bar Widget
///
/// Provides a combined search input and filter menu toggle for mentor sessions.
/// Contains a debounced search bar and a filter button reflecting active filters.
/// Integrates with `TableViewModel` for updating search terms and toggling filters.
library;

import "dart:async";

import "package:flutter/material.dart";

import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "package:mentor_data_table/ui/core/breakpoints.dart";

import "../../../domain/models/filter/filter.dart";
import "../../core/themes/shadcn_theme.dart";
import "../view_models/table_viewmodel.dart";

/// A widget combining a search bar and filter toggle button.
///
/// Uses Flutter Hooks to debounce search input and Riverpod to manage search
/// and filter state.
class SearchFilterBar extends HookConsumerWidget {
  const SearchFilterBar({super.key});

  @override
  /// Builds the search bar and filter button row.
  ///
  /// - Displays a debounced text field for entering search queries.
  /// - Shows a clear icon when the search text is not empty.
  /// - Adjusts width responsively based on whether filters are active.
  /// - Includes a filter button that opens the filter menu.
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(tableViewModelProvider.notifier);
    final state = ref.watch(tableViewModelProvider);

    final filters = state.when(
      loading: () => <Filter>[],
      error: (_, _) => <Filter>[],
      data: (s) => s.filters,
    );

    final controller = useTextEditingController();

    useListenable(controller);

    void onSearch(String s) => viewModel.setSearchTerm(s);
    useDebouncedSearch(controller, onSearch);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border(
                top: BorderSide(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
                left: BorderSide(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
                bottom: BorderSide(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            height: 48,
            width: context.responsive<double>(
              base: filters.isEmpty ? 200 : 170,
              sm: filters.isEmpty ? 300 : 250,
              md: filters.isEmpty ? 400 : 330,
            ),
            child: SearchBar(
              hintText: "Search",
              controller: controller,
              onSubmitted: onSearch,
              trailing: controller.text.isNotEmpty
                  ? [
                      IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          controller.clear();
                          onSearch("");
                        },
                      ),
                    ]
                  : null,
              padding: const WidgetStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 16.0),
              ),
              leading: const Icon(Icons.search),
              // Override theme
              shape: const WidgetStatePropertyAll<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
              backgroundColor: const WidgetStatePropertyAll<Color>(
                Colors.transparent,
              ),
              elevation: const WidgetStatePropertyAll<double>(0),
              overlayColor: const WidgetStatePropertyAll<Color>(
                Colors.transparent,
              ),
              surfaceTintColor: const WidgetStatePropertyAll<Color>(
                Colors.transparent,
              ),
            ),
          ),
          // ---------------------------------
          // Filter Button
          // ---------------------------------
          _FilterButton(),
        ],
      ),
    );
  }
}

/// A button widget to toggle the filter menu visibility.
///
/// Displays filter icon, optional label, and when filters are active,
/// shows the filter count and a clear button.
class _FilterButton extends HookConsumerWidget {
  @override
  /// Builds the filter toggle button UI.
  ///
  /// - Reads the current filter list from `TableViewModel`.
  /// - Shows count and clear icon when filters exist.
  /// - Tapping invokes `toggleFilterMenu` on the view model.
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(tableViewModelProvider.notifier);
    final state = ref.watch(tableViewModelProvider);

    final filters = state.when(
      loading: () => <Filter>[],
      error: (_, _) => <Filter>[],
      data: (s) => s.filters,
    );

    return FilledButton(
      onPressed: () => viewModel.toggleFilterMenu(),
      style: FilledButton.styleFrom(
        elevation: 0,
        backgroundColor: Slate.slate100,
        foregroundColor: Slate.slate500,
        side: const BorderSide(color: ShadcnColors.borderVariant),
        padding: EdgeInsets.only(left: 16, right: 8),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.zero,
            bottomLeft: Radius.zero,
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.filter_alt),
          const SizedBox(width: 8),
          if (filters.isEmpty)
            context.responsive<Widget>(
              base: Text(""),
              sm: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text("Filter"),
              ),
            ),
          if (filters.isNotEmpty)
            context.responsive<Widget>(
              base: Text(""),
              sm: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Text("Filters:"),
              ),
            ),
          if (filters.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: _FiltersNumberAndDeleteIconButton(
                number: filters.length,
                onClick: viewModel.clearFilters,
              ),
            ),
        ],
      ),
    );
  }
}

/// Displays the number of active filters and a button to clear them.
///
/// Styled as a badge with a delete icon to invoke the provided callback.
class _FiltersNumberAndDeleteIconButton extends StatelessWidget {
  final int number;
  final void Function() onClick;

  const _FiltersNumberAndDeleteIconButton({
    required this.number,
    required this.onClick,
  });

  @override
  /// Builds the filter count badge and clear icon button.
  ///
  /// Shows the filter count on wider screens and attaches `onClick`.
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      padding: EdgeInsets.only(
        left: context.responsive<double>(base: 0, sm: 16),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withAlpha(50),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          context.responsive<Widget>(
            base: SizedBox.shrink(),
            sm: Text("$number"),
          ),
          IconButton(
            visualDensity: VisualDensity.compact,
            icon: const Icon(Icons.clear),
            onPressed: onClick,
            style: IconButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              hoverColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}

/// A hook to debounce search input changes.
///
/// Adds a listener to the provided `controller` and invokes `onSearch`
/// after the specified `delay` when the text changes.
///
/// **Parameters:**
/// - `controller` (`TextEditingController`): The input controller to listen on.
/// - `onSearch` (`void Function(String)`): Callback to call with the debounced text.
/// - `delay` (`Duration`): Debounce duration (default is 300ms).
void useDebouncedSearch(
  TextEditingController controller,
  void Function(String) onSearch, {
  Duration delay = const Duration(milliseconds: 300),
}) {
  final debounce = useRef<Timer?>(null);

  useEffect(() {
    void listener() {
      debounce.value?.cancel();
      debounce.value = Timer(delay, () {
        onSearch(controller.text);
      });
    }

    controller.addListener(listener);
    return () {
      controller.removeListener(listener);
      debounce.value?.cancel();
    };
  }, [controller]);
}
