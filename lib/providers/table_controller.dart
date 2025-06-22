import "package:mentor_data_table/providers/filter_service.dart";
import "package:mentor_data_table/providers/sort_service.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../data/fetch_policy.dart";
import "../models/filter_query.dart";
import "../models/form_entry.dart";
import "../models/sort_state.dart";
import "../models/table_state.dart";

import "fetch_policy.dart";

// Generated code lives in part
// to generate run: `flutter pub run build_runner build --delete-conflicting-outputs`
part "table_controller.g.dart";

/// [TableController] manages the state of the data table including
/// asynchronous data fetching, multi-column sorting, and search/filter functionality.
///
/// - Sorting: Supports tri-state sorting (ascending, descending, none) on each column.
///   The sort order reflects the sequence in which columns were clicked. Columns retain
///   their position in the list unless removed by toggling back to "none."
///
/// - Filtering: Allows both simple search queries across all fields and complex logical
///   filters using composable [FilterQuery] instances like [AndFilter], [OrFilter], and [FieldContains].
///
/// - Data Source: Data is loaded using a policy pattern abstraction via [FetchPolicy],
///   enabling modular fetching strategies (e.g., from a local JSON file or remote API).
///
/// The resulting filtered and sorted data is stored in [TableState.resultSet],
/// and updates are triggered through [toggleSort] or [search]. TODO: after adding complex filtering, update this documentation
@riverpod
class TableController extends _$TableController {
  @override
  FutureOr<TableState> build() async {
    // simulated delay, don't ship in production
    // await Future.delayed(const Duration(seconds: 2));
    final data = await ref.watch(fetchPolicyProvider).fetch();
    return TableState(
      originalData: data,
      resultSet: data,
      sortOrder: [],
      filters: [MatchAllFilter()],
    );
  }

  void toggleSort(Field column) {
    final current = state.requireValue;
    final sortSvc = ref.watch(sortServiceProvider);
    final filterSvc = ref.watch(filterServiceProvider);

    // Update sort order
    final updatedSort = sortSvc.updateSortOrder(
      currentOrder: current.sortOrder,
      field: column,
    );

    // Apply filters
    final filterd = filterSvc.applyFilters(
      data: current.originalData,
      filters: current.filters,
    );

    // Sort filtered data
    final sorted = sortSvc.applySort(data: filterd, sortOrder: updatedSort);

    state = AsyncData(
      current.copyWith(sortOrder: updatedSort, resultSet: sorted),
    );

    // TODO: delete this
    // final updatedSort = _updateSortOrder(current.sortOrder, column);
    // final newFiltered = _filterEntries(
    //   current.originalData,
    //   current.filters,
    //   updatedSort,
    // );
    // state = AsyncData(
    //   current.copyWith(sortOrder: updatedSort, resultSet: newFiltered),
    // );
  }

  void search(String value) {
    final current = state.requireValue;
    final sortSvc = ref.watch(sortServiceProvider);
    final filterSvc = ref.watch(filterServiceProvider);

    // Simple search across all fields
    final filter = OrFilter([
      for (final field in Field.values) FieldContains(field, value),
    ]);

    // Apply filters
    final filtered = filterSvc.applyFilters(
      data: current.originalData,
      filters: [filter],
    );

    // Sort filterd data
    final sorted = sortSvc.applySort(
      data: filtered,
      sortOrder: current.sortOrder,
    );

    state = AsyncData(current.copyWith(filters: [filter], resultSet: sorted));

    // TODO - delete this
    // final newFiltered = _filterEntries(current.originalData, [
    //   filter,
    // ], current.sortOrder);
    // state = AsyncData(
    //   current.copyWith(filters: [filter], resultSet: newFiltered),
    // );
  }

  void addFilter(FilterQuery filter) {
    // TODO: implement this
  }

  // ============================================================================
  // TODO: EVERYTHING BELOW WILL BE REFACTORED AWAY

  /// Updates the list of [SortState]s based on user interaction with a column header.
  ///
  /// This method cycles the sort direction of the given [column] in the order:
  /// none → ascending → descending → none.
  ///
  /// If the column is already in the sort order, its previous state is removed.
  /// If the new direction is not `none`, the column is reinserted at its previous index,
  /// maintaining the sequence in which columns were clicked.
  ///
  /// This preserves the sort precedence order without re-prioritizing columns,
  /// allowing stable cascading multi-column sorting based on click sequence.
  List<SortState> _updateSortOrder(List<SortState> current, Field column) {
    // Check if the column is already in the current sort order.
    // If not found, return a default SortState with no direction.
    final existingIndex = current.indexWhere((s) => s.column == column);
    final currentDirection = existingIndex == -1
        ? SortDirection.none
        : current[existingIndex].direction;

    // Determine the next sort direction in the tri-state cycle:
    SortDirection nextDirection = switch (currentDirection) {
      SortDirection.none => SortDirection.asc,
      SortDirection.asc => SortDirection.desc,
      SortDirection.desc => SortDirection.none,
    };

    // Copy state (follow rules for keeping state immutable)
    final newSortOrder = List<SortState>.from(current);

    // If column's sort state existed, remove it from the list
    if (existingIndex != -1) {
      newSortOrder.removeAt(existingIndex);
    }

    // If the direction is declared, insert the new sort state in its old position for this column
    if (nextDirection != SortDirection.none) {
      final insertIndex = existingIndex != -1
          ? existingIndex
          : newSortOrder.length;
      newSortOrder.insert(
        insertIndex,
        SortState(column: column, direction: nextDirection),
      );
    }

    return newSortOrder;
  }

  /// Filters and sorts a list of [FormEntry]s based on the provided [filters] and [sortOrder].
  ///
  /// If [filters] are provided, each [FilterQuery] is applied in sequence to narrow down
  /// the entries. This produces a logical AND behavior: all filters must match for an entry
  /// to be included in the result.
  ///
  /// Complex filtering logic can be represented using combinations of [FieldContains],
  /// [AndFilter], and [OrFilter] types.
  ///
  /// Sorting is applied after filtering. The [sortOrder] list reflects the sequence in which
  /// columns were clicked. Columns are sorted in that order, without reprioritization.
  List<FormEntry> _filterEntries(
    List<FormEntry> entries,
    List<FilterQuery>? filters,
    List<SortState> sortOrder,
  ) {
    // If filters are provided, apply each filter in sequence to narrow down the entries.
    // Each filter acts on the result of the previous one, combining with logical AND behavior.
    // If no filters are provided, use the original list of entries as-is.
    final filtered = filters != null
        ? filters.fold<List<FormEntry>>(
            entries,
            (previous, filter) => previous.where(filter.matches).toList(),
          )
        : List<FormEntry>.from(entries);

    // Apply cascading sort based on the provided sort order.
    filtered.sort((a, b) {
      for (final sort in sortOrder) {
        final aVal = a[sort.column];
        final bVal = b[sort.column];
        final result = aVal.compareTo(bVal);
        if (result != 0) {
          return sort.direction == SortDirection.asc ? result : -result;
        }
      }
      return 0;
    });

    return filtered;
  }
}
