import "dart:async";

import "package:flutter/material.dart";

import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../domain/models/filter/filter.dart";
import "../../core/themes/shadcn_theme.dart";
import "../view_models/table_viewmodel.dart";

class SearchFilterBar extends HookConsumerWidget {
  const SearchFilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(tableViewModelProvider.notifier);
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
            width: 400,
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

class _FilterButton extends HookConsumerWidget {
  @override
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
        padding: EdgeInsets.only(left: 16, right: 18),
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
          if (filters.isEmpty) const Text("Filter"),
          if (filters.isNotEmpty) const Text("Filters:"),
          if (filters.isNotEmpty) const SizedBox(width: 14),
          if (filters.isNotEmpty)
            _FiltersNumberAndDeleteIconButton(
              number: filters.length,
              onClick: viewModel.clearFilters,
            ),
        ],
      ),
    );
  }
}

class _FiltersNumberAndDeleteIconButton extends StatelessWidget {
  final int number;
  final void Function() onClick;

  const _FiltersNumberAndDeleteIconButton({
    required this.number,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withAlpha(50),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text("$number"),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: onClick,
            style: IconButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(0),
              minimumSize: Size(24, 24),
              hoverColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}

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
