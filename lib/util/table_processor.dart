import "package:mentor_data_table/models/entry.dart";
import "package:mentor_data_table/models/filter.dart";
import "package:mentor_data_table/models/sort.dart";
import "package:mentor_data_table/util/filter_query_builder.dart";

class TableProcessor {
  static List<Entry> process({
    required List<Entry> originalData,
    List<Filter>? filterList,
    String? searchText,
    List<Sort>? sortList,
  }) {
    var processedData = List<Entry>.from(originalData);

    if (filterList != null) {
      processedData = applyFilters(processedData, filterList);
    }
    if (searchText != null) {
      processedData = applySearch(processedData, searchText);
    }
    if (sortList != null) {
      processedData = applySort(processedData, sortList);
    }

    return processedData;
  }

  static List<Entry> applySearch(List<Entry> entries, String text) {
    final builder = FilterQueryBuilder();
    for (final field in EntryField.values) {
      builder.orContains(field, text);
    }

    final filterQuery = builder.buildQuery();
    final newEntries = List<Entry>.from(entries);

    return newEntries.where((e) => filterQuery.matches(e)).toList();
  }

  static List<Entry> applyFilters(
    List<Entry> entries,
    List<Filter> filterList,
  ) {
    final builder = FilterQueryBuilder();
    for (final filter in filterList) {
      switch (filter.operator) {
        case FilterOperator.includes:
          builder.whereContains(filter.field, filter.value);
        case FilterOperator.equals:
          builder.whereEquals(filter.field, filter.value);
      }
    }

    final filterQuery = builder.buildQuery();
    final newEntries = List<Entry>.from(entries);

    return newEntries.where((e) => filterQuery.matches(e)).toList();
  }

  static List<Entry> applySort(List<Entry> entries, List<Sort> sortList) {
    final newEntries = List<Entry>.from(entries);

    newEntries.sort((a, b) {
      for (final sort in sortList) {
        final aVal = a[sort.field];
        final bVal = b[sort.field];
        final result = aVal.compareTo(bVal);
        if (result != 0) {
          return sort.direction == SortDirection.asc ? result : -result;
        }
      }
      return 0;
    });

    return newEntries;
  }
}
