import "package:mentor_data_table/models/filter_query.dart";

import "form_entry.dart";
import "sort_state.dart";

class TableState {
  final List<FormEntry> originalData;
  final List<FormEntry> resultSet;
  final List<SortState> sortOrder;
  final List<FilterQuery> filters;

  TableState({
    required this.originalData,
    required this.resultSet,
    required this.sortOrder,
    required this.filters,
  });

  TableState copyWith({
    List<FormEntry>? originalData,
    List<FormEntry>? resultSet,
    List<SortState>? sortOrder,
    List<FilterQuery>? filters,
  }) {
    return TableState(
      originalData: originalData ?? this.originalData,
      resultSet: resultSet ?? this.resultSet,
      sortOrder: sortOrder ?? this.sortOrder,
      filters: filters ?? this.filters,
    );
  }
}
