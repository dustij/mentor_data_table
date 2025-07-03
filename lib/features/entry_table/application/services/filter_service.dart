import "../../domain/entry.dart";
import "../../domain/filter.dart";

import "filter_query_builder.dart";

class FilterService {
  final FilterQueryBuilder _builder;

  FilterService(this._builder);

  List<Entry> applyFilters(List<Entry> entries, List<Filter> filterList) {
    if (filterList.isEmpty) return entries;

    for (final filter in filterList) {
      switch (filter.operator) {
        case FilterOperator.includes:
          _builder.whereContains(filter.field, filter.value);
        case FilterOperator.equals:
          _builder.whereEquals(filter.field, filter.value);
      }
    }

    final filterQuery = _builder.buildQuery();
    final newEntries = List<Entry>.from(entries);

    return newEntries.where((e) => filterQuery.matches(e)).toList();
  }
}
