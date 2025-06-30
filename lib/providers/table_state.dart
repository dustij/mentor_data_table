import "package:riverpod_annotation/riverpod_annotation.dart";

import "package:mentor_data_table/models/entry.dart";
import "package:mentor_data_table/models/filter.dart";
import "package:mentor_data_table/models/sort_order.dart";
import "package:mentor_data_table/models/table_model.dart";

// to generate run: `dart run build_runner build --delete-conflicting-outputs`
part "table_state.g.dart";

@riverpod
class TableState extends _$TableState {
  @override
  TableModel build() {
    return TableModel.blank();
  }

  void toggleSortOrder(EntryField field) {
    // TODO: update sort order
    final newSortOrders = [] as List<SortOrder>;
    _setState(sortOrders: newSortOrders);
  }

  void _setState({
    List<Entry>? entries,
    List<SortOrder>? sortOrders,
    List<Filter>? filters,
  }) {
    entries ??= state.originalData;
    sortOrders ??= state.sortOrders;
    filters ??= state.filters;

    // TODO: apply filters
    final filtered = entries;

    // TODO: apply sort orders
    final sortedAndFiltered = filtered;

    state = state.copyWith(
      processedData: sortedAndFiltered,
      sortOrders: sortOrders,
      filters: filters,
    );
  }

  void applySearchFilter(String value) {}
}
