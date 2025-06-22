import "form_entry.dart";

/// Represents a query used to filter [FormEntry] instances.
/// A filter query can be a single condition or a combination of conditions using AND/OR logic.
abstract class FilterQuery {
  const FilterQuery();
  bool matches(FormEntry entry);
}

/// A simple condition filter (e.g., field contains value).
class FieldContains extends FilterQuery {
  final Field field;
  final String value;

  FieldContains(this.field, this.value);

  @override
  bool matches(FormEntry entry) {
    final content = entry[field];
    return content.toLowerCase().contains(value.toLowerCase());
  }
}

/// Combines multiple filter queries using logical AND.
class AndFilter extends FilterQuery {
  final List<FilterQuery> filters;

  AndFilter(this.filters);

  @override
  bool matches(FormEntry entry) {
    return filters.every((f) => f.matches(entry));
  }
}

/// Combines multiple filter queries using logical OR.
class OrFilter extends FilterQuery {
  final List<FilterQuery> filters;

  OrFilter(this.filters);

  @override
  bool matches(FormEntry entry) {
    return filters.any((f) => f.matches(entry));
  }
}

/// A default filter that matches all entries.
class MatchAllFilter extends FilterQuery {
  const MatchAllFilter();

  @override
  bool matches(FormEntry entry) => true;
}
