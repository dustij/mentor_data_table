import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:mentor_data_table/providers/filter_list_notifier.dart";

import "../providers/filter_menu_open_notifier.dart";
import "../theme/shadcn_theme.dart";

class FilterButton extends HookConsumerWidget {
  const FilterButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterList = ref.watch(filterListNotifierProvider);
    final filterListNotifier = ref.read(filterListNotifierProvider.notifier);

    final hasFilters = filterList.isNotEmpty;

    final filterMenuOpenNotifier = ref.read(
      filterMenuOpenNotifierProvider.notifier,
    );

    return FilledButton(
      onPressed: () => filterMenuOpenNotifier.toggle(),
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
        // mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.filter_alt),
          const SizedBox(width: 8),
          if (!hasFilters) const Text("Filter"),
          if (hasFilters) const Text("Filters:"),
          if (hasFilters) const SizedBox(width: 14),
          if (hasFilters)
            _FiltersNumberAndDeleteIconButton(
              number: filterList.length,
              notifier: filterListNotifier,
            ),
        ],
      ),
    );
  }
}

class _FiltersNumberAndDeleteIconButton extends StatelessWidget {
  final int number;
  final FilterListNotifier notifier;

  const _FiltersNumberAndDeleteIconButton({
    required this.number,
    required this.notifier,
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
            onPressed: () => notifier.clear(),
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
