import "form_entry.dart";

/// Enum representing the direction of sorting to apply.
/// - `asc`: sort in ascending order.
/// - `desc`: sort in descending order.
/// - `none`: no sorting.
enum SortDirection { asc, desc, none }

/// Encapsulates the sorting state for a single column,
/// pairing a [column] with a [direction].
class SortState {
  final Field column;
  final SortDirection direction;

  /// Creates a [SortState] for the given [column] in the specified [direction].
  const SortState({required this.column, required this.direction});

  /// Returns a string representation like "Column Label - direction".
  @override
  String toString() => "${column.text} - ${direction.name}";
}
