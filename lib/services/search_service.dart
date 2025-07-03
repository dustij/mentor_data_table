import "../models/entry.dart";

import "filter_query_builder.dart";

class SearchService {
  final FilterQueryBuilder _builder;

  SearchService(this._builder);

  List<Entry> applySearch(List<Entry> entries, String searchText) {
    for (final field in EntryField.values) {
      _builder.orContains(field, searchText);
    }

    final filterQuery = _builder.buildQuery();
    final newEntries = List<Entry>.from(entries);

    return newEntries.where((e) => filterQuery.matches(e)).toList();
  }
}
