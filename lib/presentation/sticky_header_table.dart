import "package:flutter/material.dart";

import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:mentor_data_table/theme/shadcn_theme.dart";

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
        return Container(
          color: Theme.of(context).colorScheme.surfaceContainer,
          child: CustomScrollView(
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
          ),
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
    return Row(
      children: Entry.fields
          .map(
            (field) => Expanded(
              child: Container(
                constraints: BoxConstraints(
                  minHeight: kMinInteractiveDimension,
                ),
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  border: BoxBorder.fromLTRB(
                    right: BorderSide(
                      color: Theme.of(
                        context,
                      ).colorScheme.outlineVariant.withAlpha(50),
                    ),
                    bottom: BorderSide(
                      color: Theme.of(
                        context,
                      ).colorScheme.outlineVariant.withAlpha(50),
                    ),
                  ),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(rowData[field]),
                ),
              ),
            ),
          )
          .toList(),
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
    return Row(
      children: Entry.fields.map((field) {
        final sortState = sortList.firstWhere(
          (s) => s.field == field,
          orElse: () => Sort(field: field, direction: SortDirection.none),
        );

        Icon? sortIcon;
        if (sortState.direction == SortDirection.asc) {
          sortIcon = Icon(
            Icons.arrow_upward,
            size: 16,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          );
        } else if (sortState.direction == SortDirection.desc) {
          sortIcon = Icon(
            Icons.arrow_downward,
            size: 16,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          );
        }

        return Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Theme.of(context).colorScheme.outline),
                right: BorderSide(color: Theme.of(context).colorScheme.outline),
                bottom: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                  width: 2,
                ),
              ),
            ),
            child: SizedBox(
              height: maxExtent,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Slate.slate100,
                  foregroundColor: Slate.slate500,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 0,
                  ),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  alignment: Alignment.centerLeft,
                  minimumSize: Size.fromHeight(maxExtent),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                onPressed: () => onSort(field),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      field.toString(),
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(width: 16),
                    sortIcon ?? const SizedBox(width: 16, height: 16),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
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
