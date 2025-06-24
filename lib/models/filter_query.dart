import "form_entry.dart";

/// Represents a query used to filter [FormEntry] instances.
/// A filter query can be a single condition or a combination of conditions using AND/OR logic.
abstract class FilterQuery {
  const FilterQuery();

  /// Returns true if the given [entry] satisfies this filter's condition.
  bool matches(FormEntry entry);
}

/// A simple condition filter (e.g., field contains value).
class FieldContains extends FilterQuery {
  final Field field;
  final String value;

  FieldContains(this.field, this.value);

  /// Returns true if [entry]'s value for [field] contains [value], case-insensitive.
  @override
  bool matches(FormEntry entry) {
    final content = entry[field];
    return content.toLowerCase().contains(value.toLowerCase());
  }
}

/// A condition filter that matches entries where the field's value equals [value].
/// Comparison is case-insensitive for string values.
class FieldEquals extends FilterQuery {
  final Field field;
  final String value;

  FieldEquals(this.field, this.value);

  /// Returns true if [entry]'s value for [field] equals [value], case-insensitive for strings.
  @override
  bool matches(FormEntry entry) {
    final content = entry[field];
    if (content is String) {
      return content.toLowerCase() == value.toLowerCase();
    }
    return content == value;
  }
}

/// Combines multiple filter queries using logical AND.
class AndFilter extends FilterQuery {
  final List<FilterQuery> filters;

  AndFilter(this.filters);

  /// Returns true if all nested filters return true for the given [entry].
  @override
  bool matches(FormEntry entry) {
    return filters.every((f) => f.matches(entry));
  }
}

/// Combines multiple filter queries using logical OR.
class OrFilter extends FilterQuery {
  final List<FilterQuery> filters;

  OrFilter(this.filters);

  /// Returns true if any nested filter returns true for the given [entry].
  @override
  bool matches(FormEntry entry) {
    return filters.any((f) => f.matches(entry));
  }
}

/// A default filter that matches all entries.
class MatchAllFilter extends FilterQuery {
  const MatchAllFilter();

  /// Always returns true, matching every entry.
  @override
  bool matches(FormEntry entry) => true;
}
