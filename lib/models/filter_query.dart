import "filter_rule.dart";
import "form_entry.dart";

/// Represents a query used to filter [FormEntry] instances.
/// A filter query can be a single condition or a combination of conditions using AND/OR logic.
abstract class FilterQuery {
  const FilterQuery();

  /// Return a brand-new copy of this query object.
  FilterQuery clone();

  /// Returns true if the given [entry] satisfies this filter"s condition.
  bool matches(FormEntry entry);

  /// Returns the [FilterRule] representation of this query
  FilterRule asFilterRule();
}

/// A simple condition filter (e.g., [field] contains [text]).
class FieldContains extends FilterQuery {
  final Field field;
  final String text;

  FieldContains(this.field, this.text);

  @override
  FilterQuery clone() => FieldContains(field, text);

  @override
  String toString() => "$field contains $text";

  /// Returns true if [entry]"s value for [field] contains [text], case-insensitive.
  @override
  bool matches(FormEntry entry) {
    final content = entry[field];
    return content.toLowerCase().contains(text.toLowerCase());
  }

  @override
  FilterRule asFilterRule() {
    return FilterRule(
      field: field,
      value: text,
      operator: FilterOperator.includes,
    );
  }
}

/// A condition filter that matches entries where the field"s value equals [text].
/// Comparison is case-insensitive for string values.
class FieldEquals extends FilterQuery {
  final Field field;
  final String text;

  FieldEquals(this.field, this.text);

  @override
  FilterQuery clone() => FieldEquals(field, text);

  @override
  String toString() => "$field equals $text";

  /// Returns true if [entry]"s value for [field] equals [text], case-insensitive for strings.
  @override
  bool matches(FormEntry entry) {
    final content = entry[field];
    if (content is String) {
      return content.toLowerCase() == text.toLowerCase();
    }
    return content == text;
  }

  @override
  FilterRule asFilterRule() {
    return FilterRule(
      field: field,
      value: text,
      operator: FilterOperator.equals,
    );
  }
}

/// Combines multiple filter queries using logical AND.
class AndFilter extends FilterQuery {
  final List<FilterQuery> filters;

  AndFilter(this.filters);

  @override
  FilterQuery clone() => AndFilter(filters.map((f) => f.clone()).toList());

  @override
  String toString() {
    final inner = filters.map((f) => f.toString()).join(" AND ");
    return "($inner)";
  }

  /// Returns true if all nested filters return true for the given [entry].
  @override
  bool matches(FormEntry entry) {
    return filters.every((f) => f.matches(entry));
  }

  @override
  FilterRule asFilterRule() {
    // TODO: implement asFilterRule
    throw UnimplementedError();
  }
}

/// Combines multiple filter queries using logical OR.
class OrFilter extends FilterQuery {
  final List<FilterQuery> filters;

  OrFilter(this.filters);

  @override
  FilterQuery clone() => OrFilter(filters.map((f) => f.clone()).toList());

  @override
  String toString() {
    final inner = filters.map((f) => f.toString()).join(" OR ");
    return "($inner)";
  }

  /// Returns true if any nested filter returns true for the given [entry].
  @override
  bool matches(FormEntry entry) {
    return filters.any((f) => f.matches(entry));
  }

  @override
  FilterRule asFilterRule() {
    // TODO: implement asFilterRule
    throw UnimplementedError();
  }
}

/// A default filter that matches all entries.
class MatchAllFilter extends FilterQuery {
  const MatchAllFilter();

  @override
  FilterQuery clone() => this;

  @override
  String toString() => "Match all";

  /// Always returns true, matching every entry.
  @override
  bool matches(FormEntry entry) => true;

  @override
  FilterRule asFilterRule() {
    // TODO: implement asFilterRule
    throw UnimplementedError();
  }
}
