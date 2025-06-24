import "package:riverpod_annotation/riverpod_annotation.dart";

import "../data/example_policy.dart";
import "../data/fetch_policy.dart";
import "../models/filter_query.dart";
import "../models/form_entry.dart";
import "../models/table_state.dart";
import "../services/fetch_service.dart";
import "../services/filter_service.dart";
import "../services/sort_service.dart";

// Generated code lives in part
// to generate run: `flutter pub run build_runner build --delete-conflicting-outputs`
part "table_controller.g.dart";

/// Manages the state of the data table, including:
/// - asynchronous loading of entries,
/// - multi-column sorting,
/// - searching and composable filters,
/// - updating the result set in [TableState].
@riverpod
class TableController extends _$TableController {
  /// Loads all entries via [FetchService] and initializes [TableState]
  /// with unfiltered, unsorted data.
  @override
  FutureOr<TableState> build() async {
    // simulated delay, don't ship in production
    // await Future.delayed(const Duration(seconds: 2));
    final data = await FetchService(policy: ExamplePolicy()).fetch();
    return TableState(
      originalData: data,
      resultSet: data,
      sortOrder: [],
      filter: MatchAllFilter(),
    );
  }

  /// Toggles the sort direction of [column], reapplies the current filter,
  /// sorts the filtered entries, and updates [TableState.resultSet].
  void toggleSort(Field column) {
    final current = state.requireValue;
    final sortSvc = SortService();
    final filterSvc = FilterService();

    // Update sort order
    final updatedSort = sortSvc.updateSortOrder(
      currentOrder: current.sortOrder,
      column: column,
    );

    // Apply filter
    final filterd = filterSvc.applyFilter(
      items: current.originalData,
      filter: current.filter,
    );

    // Sort filtered data
    final sorted = sortSvc.applySort(items: filterd, sortOrder: updatedSort);

    state = AsyncData(
      current.copyWith(sortOrder: updatedSort, resultSet: sorted),
    );
  }

  /// Builds a composite OR filter matching [value] across all fields,
  /// applies it to the data, re-sorts using the current sort order,
  /// and updates [TableState] accordingly.
  void search(String value) {
    final current = state.requireValue;
    final sortSvc = SortService();
    final filterSvc = FilterService();

    // Simple search across all fields
    final filter = FilterBuilder().orGroup([
      for (final field in Field.values) FieldContains(field, value),
    ]).build();

    // Apply filter
    final filtered = filterSvc.applyFilter(
      items: current.originalData,
      filter: filter,
    );

    // Sort filterd data
    final sorted = sortSvc.applySort(
      items: filtered,
      sortOrder: current.sortOrder,
    );

    state = AsyncData(current.copyWith(filter: filter, resultSet: sorted));
  }

  /// Adds the given [filter] to the existing filter composition,
  /// reapplies filtering and sorting, and updates [TableState].
  void addFilter(FilterQuery filter) {
    // TODO: implement this
  }
}
