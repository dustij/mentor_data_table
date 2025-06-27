import "package:riverpod_annotation/riverpod_annotation.dart";

import "../data/example_policy.dart";
import "../models/filter_query.dart";
import "../models/filter_rule.dart";
import "../models/form_entry.dart";
import "../models/sort_state.dart";
import "../models/table_state.dart";
import "../providers/filter_controller.dart";
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

  /// Toggles the sort direction for [column], re-applies the existing filter,
  /// and updates the table state with the new sorted result set.
  void toggleSort(Field column) {
    final current = state.requireValue;
    final sortSvc = SortService();

    final updatedSort = sortSvc.updateSortOrder(
      sortOrder: current.sortOrder,
      column: column,
    );

    _setState(sortOrder: updatedSort);
  }

  /// Applies a search filter for [text] across all fields,
  /// then updates the table state to reflect the filtered result set.
  void search(String text) {
    ref.read(filterControllerProvider.notifier).applySearch(text);
    final query = ref.read(filterControllerProvider);

    _setState(filter: query);
  }

  /// Adds the given [filter] rule to the composite filter,
  /// then updates the table state with the new filtered result set.
  void addFilter(FilterRule filter) {
    ref.read(filterControllerProvider.notifier).addFilter(filter);
    final query = ref.read(filterControllerProvider);

    _setState(filter: query);
  }

  /// Internal helper that recalculates and emits the filtered and sorted
  /// [TableState.resultSet] based on optional overrides for [entries], [filter], and [sortOrder].
  void _setState({
    List<FormEntry>? entries,
    FilterQuery? filter,
    List<SortState>? sortOrder,
  }) {
    final current = state.requireValue;
    final sortSvc = SortService();
    final filterSvc = FilterService();

    entries ??= current.originalData;
    filter ??= current.filter;
    sortOrder ??= current.sortOrder;

    // Apply filter
    final filtered = filterSvc.applyFilter(entries: entries, filter: filter);

    // Sort filterd data
    final List<FormEntry> resultSet;
    if (sortOrder.isEmpty) {
      resultSet = filtered;
    } else {
      resultSet = sortSvc.applySort(entries: filtered, sortOrder: sortOrder);
    }

    state = AsyncData(
      current.copyWith(
        filter: filter,
        sortOrder: sortOrder,
        resultSet: resultSet,
      ),
    );
  }
}
