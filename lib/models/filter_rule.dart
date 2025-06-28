import "form_entry.dart";

/// Defines the types of comparison operations for filtering.
///
/// - `includes`: checks if the entry’s field contains the given text.
/// - `equals`: checks if the entry’s field exactly matches the given text.
enum FilterOperator {
  includes("includes"),
  equals("equals");

  final String text;
  const FilterOperator(this.text);

  /// Returns the enum whose [text] matches [label], or throws if none match.
  static FilterOperator fromText(String label) {
    return FilterOperator.values.firstWhere(
      (f) => f.text == label,
      orElse: () => throw ArgumentError("Unknown field label: $label"),
    );
  }
}

/// Represents a single filter rule, specifying which [field] to filter,
/// the comparison [operator], and the target [value] value.
class FilterRule {
  final Field field;
  final String value;
  final FilterOperator operator;

  /// Creates a [FilterRule] for the given [field], using [operator] to compare against [value].
  FilterRule({
    required this.field,
    required this.value,
    required this.operator,
  });
}
