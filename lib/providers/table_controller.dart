import "dart:developer";

import "package:mentor_data_table/models/filter_query.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../data/fetch_policy.dart";
import "../models/form_entry.dart";
import "../models/table_state.dart";

// Generated code lives in part
// to generate run: `flutter pub run build_runner build --delete-conflicting-outputs`
part "table_controller.g.dart";

/// [TableController] manages the state of the table including data fetching,
/// multi-column sorting, and text-based filtering.
///
/// It supports tri-state sorting (ascending, descending, none) on each column,
/// and allows multiple columns to be sorted in prioritized order. Sorting is
/// toggled by calling [toggleSort] with a column name.
///
/// Filtering is performed using a search query that matches any field in the
/// [FormEntry], such as mentor name, student name, session details, or notes.
/// The filtered and sorted result is stored in [TableState.filteredData].
///
/// In addition to simple search, the controller is designed to support
/// complex filtering logic, where multiple filter criteria can be combined
/// to refine the results further.
@riverpod
class TableController extends _$TableController {
  @override
  FutureOr<TableState> build() async {
    // simulated delay, remove later
    // await Future.delayed(const Duration(seconds: 2)); // this lets spinner animate
    final data = await fetchEntries(); // this blocks
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
    // FIXME: sorting works but not as intended, I want it to combine sorted columns instead of prioritize and only sort one column at a time
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

  /// Updates the list of [SortState]s based on a new column interaction.
  ///
  /// If the specified [column] is already being sorted, its sort direction is cycled
  /// in the following order: none → ascending → descending → none.
  ///
  /// The updated column is moved to the beginning of the list to give it the highest
  /// priority in multi-column sorting. If the new direction is `none`, the column
  /// is removed from the sort order entirely.
  List<SortState> _updateSortOrder(List<SortState> current, Field column) {
    // Check if the column is already in the current sort order.
    // If not found, return a default SortState with no direction.
    final existing = current.firstWhere(
      (s) => s.column == column,
      orElse: () => const SortState(
        column: Field.mentorName,
        direction: SortDirection.none,
      ),
    );

    // Determine the next sort direction in the tri-state cycle:
    SortDirection nextDirection = switch (existing.direction) {
      SortDirection.none => SortDirection.ascending,
      SortDirection.ascending => SortDirection.descending,
      SortDirection.descending => SortDirection.none,
    };

    // Remove the existing sort entry for the column, if present.
    // Then insert the new sort state at the beginning of the list
    // to give it highest priority during sorting.
    var newSortOrder = List<SortState>.from(
      current.where((s) => s.column != column),
    );
    if (nextDirection != SortDirection.none) {
      newSortOrder.insert(
        0,
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

    // Apply sorting for each column in the sort order, starting with the lowest priority.
    // Sorting is stable and applied in reverse order so that higher priority columns take precedence.
    for (final sort in sortOrder.reversed) {
      filtered.sort((a, b) {
        final aVal = a[sort.column];
        final bVal = b[sort.column];
        final result = aVal.compareTo(bVal);
        return sort.direction == SortDirection.ascending ? result : -result;
      });
    }

    return filtered;
  }
}
