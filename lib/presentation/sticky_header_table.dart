import "package:flutter/material.dart";

import "package:hooks_riverpod/hooks_riverpod.dart";

import "../models/entry.dart";
import "../models/sort.dart";
import "../providers/processed_data.dart";
import "../providers/sort_list_notifier.dart";

class StickyHeaderTable extends ConsumerWidget {
  const StickyHeaderTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final processedData = ref.watch(processedDataProvider);
    final sortList = ref.watch(sortListNotifierProvider);
    final sortListNotifier = ref.read(sortListNotifierProvider.notifier);

    return processedData.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Text("Error: $e"),
      data: (entries) {
        return CustomScrollView(
          slivers: [
            // ------------------------
            // Headers
            // ------------------------
            SliverPersistentHeader(
              pinned: true,
              delegate: _TableHeaderDelegate(
                sortList: sortList,
                onSort: sortListNotifier.updateSort,
                context: context,
              ),
            ),
            // ------------------------
            // Rows
            // ------------------------
            SliverList(
              delegate: SliverChildBuilderDelegate((ctx, i) {
                final rowData = entries[i];
                return _Row(rowData: rowData);
              }, childCount: entries.length),
            ),
          ],
        );
      },
    );
  }
}

class _Row extends StatelessWidget {
  final Entry rowData;

  const _Row({required this.rowData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: Entry.fields
            .map((field) => Expanded(child: Text(rowData[field])))
            .toList(),
      ),
    );
  }
}

class _TableHeaderDelegate extends SliverPersistentHeaderDelegate {
  final List<Sort> sortList;
  final void Function(EntryField) onSort;
  final BuildContext context;

  _TableHeaderDelegate({
    required this.sortList,
    required this.onSort,
    required this.context,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Material(
      elevation: overlapsContent ? 2 : 0,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          border: Border(
            bottom: BorderSide(color: Theme.of(context).colorScheme.outline),
          ),
        ),
        height: kMinInteractiveDimension,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: Entry.fields.map((field) {
            final sortState = sortList.firstWhere(
              (s) => s.field == field,
              orElse: () => Sort(field: field, direction: SortDirection.none),
            );

            Icon? sortIcon;
            if (sortState.direction == SortDirection.asc) {
              sortIcon = const Icon(Icons.arrow_upward, size: 16);
            } else if (sortState.direction == SortDirection.desc) {
              sortIcon = const Icon(Icons.arrow_downward, size: 16);
            }

            return Expanded(
              child: InkWell(
                onTap: () => onSort(field),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      field.toString(),
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(width: 16),
                    sortIcon ?? const SizedBox(width: 16, height: 16),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  double get maxExtent => kMinInteractiveDimension;

  @override
  double get minExtent => kMinInteractiveDimension;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
