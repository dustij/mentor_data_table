import "package:mentor_data_table/models/filter_query.dart";

import "form_entry.dart";
import "sort_state.dart";

class TableState {
  final List<FormEntry> originalData;
  final List<FormEntry> filteredData;
  final List<SortState> sortOrder;
  final List<FilterQuery> filters;

  TableState({
    required this.originalData,
    required this.filteredData,
    required this.sortOrder,
    required this.filters,
  });

  TableState copyWith({
    List<FormEntry>? originalData,
    List<FormEntry>? filteredData,
    List<SortState>? sortOrder,
    List<FilterQuery>? filters,
  }) {
    return TableState(
      originalData: originalData ?? this.originalData,
      filteredData: filteredData ?? this.filteredData,
      sortOrder: sortOrder ?? this.sortOrder,
      filters: filters ?? this.filters,
    );
  }
}
