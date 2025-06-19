import "package:mentor_data_table/models/filter_query.dart";

import "form_entry.dart";

enum SortDirection { ascending, descending, none }

class SortState {
  final Field column;
  final SortDirection direction;

  const SortState({required this.column, required this.direction});
}

class TableState {
  final List<FormEntry> originalData;
  final List<FormEntry> filteredData;
  final List<SortState> sortOrder;
  final FilterQuery filterQuery;

  TableState({
    required this.originalData,
    required this.filteredData,
    required this.sortOrder,
    required this.filterQuery,
  });

  TableState copyWith({
    List<FormEntry>? originalData,
    List<FormEntry>? filteredData,
    List<SortState>? sortOrder,
    FilterQuery? filterQuery,
  }) {
    return TableState(
      originalData: originalData ?? this.originalData,
      filteredData: filteredData ?? this.filteredData,
      sortOrder: sortOrder ?? this.sortOrder,
      filterQuery: filterQuery ?? this.filterQuery,
    );
  }
}
