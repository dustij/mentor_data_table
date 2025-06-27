import "form_entry.dart";

/// Defines the types of comparison operations for filtering.
///
/// - `includes`: checks if the entry’s field contains the given text.
/// - `equals`: checks if the entry’s field exactly matches the given text.
enum FilterOperator { includes, equals }

/// Represents a single filter rule, specifying which [field] to filter,
/// the comparison [operator], and the target [text] value.
class FilterRule {
  final Field field;
  final String text;
  final FilterOperator operator;

  /// Creates a [FilterRule] for the given [field], using [operator] to compare against [text].
  FilterRule({required this.field, required this.text, required this.operator});
}
