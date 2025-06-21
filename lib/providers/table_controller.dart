import "dart:developer";

import "package:mentor_data_table/models/filter_query.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../data/fetch_policy.dart";
import "../models/form_entry.dart";
import "../models/sort_state.dart";
import "../models/table_state.dart";

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
/// The resulting filtered and sorted data is stored in [TableState.filteredData],
/// and updates are triggered through [toggleSort] or [setSearchQuery]. TODO: after adding complex filtering, update this documentation
@riverpod
class TableController extends _$TableController {
  @override
  FutureOr<TableState> build() async {
    // simulated delay, don't ship in production
    // await Future.delayed(const Duration(seconds: 2));
    final data = await fetchEntries();
    return TableState(
      originalData: data,
      filteredData: data,
      sortOrder: [],
      filterQuery: MatchAllFilter(),
    );
  }

  Future<List<FormEntry>> fetchEntries() async {
    try {
      return await activeFetchPolicy.fetch();
    } catch (e, stackTrace) {
      log(
        "An error occured while fetching entries: $e",
        stackTrace: stackTrace,
      );
      return [];
    }
  }

  void toggleSort(Field column) {
    final current = state.requireValue;
    final updatedSort = _updateSortOrder(current.sortOrder, column);
    final newFiltered = _filterEntries(
      current.originalData,
      current.filterQuery,
      updatedSort,
    );

    state = AsyncData(
      current.copyWith(sortOrder: updatedSort, filteredData: newFiltered),
    );
  }

  void setSearchQuery(String query) {
    final current = state.requireValue;

    final filter = OrFilter([
      for (final field in Field.values) FieldContains(field, query),
    ]);

    final newFiltered = _filterEntries(
      current.originalData,
      filter,
      current.sortOrder,
    );

    state = AsyncData(
      current.copyWith(filterQuery: filter, filteredData: newFiltered),
    );
  }

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
      SortDirection.none => SortDirection.ascending,
      SortDirection.ascending => SortDirection.descending,
      SortDirection.descending => SortDirection.none,
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

  /// Filters and sorts a list of [FormEntry]s based on the provided [filter] and [sortOrder].
  ///
  /// The [filter], if provided, applies matching logic using the [FilterQuery] abstraction,
  /// which can represent simple field-based conditions or complex combinations using AND/OR.
  ///
  /// Sorting is applied in reverse priority order so that earlier sort criteria take precedence.
  /// Each sort applies a tri-state direction (ascending, descending, none) to the entries.
  List<FormEntry> _filterEntries(
    List<FormEntry> entries,
    FilterQuery? filter,
    List<SortState> sortOrder,
  ) {
    // If a filter is provided, apply it to the entries.
    // Otherwise, use the original list of entries as-is.
    var filtered = filter != null
        ? entries.where((entry) => filter.matches(entry)).toList()
        : List<FormEntry>.from(entries);

    // Apply cascading sort based on the provided sort order.
    filtered.sort((a, b) {
      for (final sort in sortOrder) {
        final aVal = a[sort.column];
        final bVal = b[sort.column];
        final result = aVal.compareTo(bVal);
        if (result != 0) {
          return sort.direction == SortDirection.ascending ? result : -result;
        }
      }
      return 0;
    });

    return filtered;
  }
}
