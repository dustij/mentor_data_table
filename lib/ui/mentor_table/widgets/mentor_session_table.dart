import "package:flutter/material.dart";

import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../domain/models/filter/filter.dart";
import "../../../domain/models/mentor_session/mentor_session.dart";
import "../../../domain/models/mentor_session/mentor_session_extension.dart";
import "../../../domain/models/sort/sort.dart";
import "../../core/themes/shadcn_theme.dart";
import "../view_models/table_viewmodel.dart";

class MentorSessionTable extends ConsumerWidget {
  const MentorSessionTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(tableViewModelProvider.notifier);
    final asyncState = ref.watch(tableViewModelProvider);

    return asyncState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Text("Error: $e"),
      data: (state) {
        return Container(
          width: 1000, // TODO: temporary constraints, find a better way maybe
          height: 1000,
          color: Theme.of(context).colorScheme.surfaceContainer,
          child: CustomScrollView(
            slivers: [
              // ------------------------
              // Headers
              // ------------------------
              SliverPersistentHeader(
                pinned: true,
                delegate: _TableHeaderDelegate(
                  sortList: state.sorts,
                  onSort: viewModel.updateSorts,
                  context: context,
                ),
              ),
              // ------------------------
              // Rows
              // ------------------------
              SliverList(
                delegate: SliverChildBuilderDelegate((ctx, i) {
                  final rowData = state.data[i];
                  return _Row(rowData: rowData);
                }, childCount: state.data.length),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Row extends StatelessWidget {
  final MentorSession rowData;

  const _Row({required this.rowData});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: Field.values
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
  final void Function(Field) onSort;
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
      children: Field.values.map((field) {
        final sortState = sortList.firstWhere(
          (s) => s.field == field,
          orElse: () => Sort(field: field, sortDirection: SortDirection.none),
        );

        Icon? sortIcon;
        if (sortState.sortDirection == SortDirection.asc) {
          sortIcon = Icon(
            Icons.arrow_upward,
            size: 16,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          );
        } else if (sortState.sortDirection == SortDirection.desc) {
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
