import "filter_query.dart";
import "form_entry.dart";
import "sort_state.dart";

/// Represents the immutable state of the data table, including:
/// - [originalData]: the full list of entries fetched from the data source,
/// - [resultSet]: the current filtered and sorted subset for display,
/// - [sortOrder]: the list of active sort states in precedence order,
/// - [filter]: the composite filter applied to the data.
class TableState {
  final List<FormEntry> originalData;
  final List<FormEntry> resultSet;
  final List<SortState> sortOrder;
  final FilterQuery filter;

  /// Creates a new [TableState] instance with the provided data, result set,
  /// sort order, and filter.
  TableState({
    required this.originalData,
    required this.resultSet,
    required this.sortOrder,
    required this.filter,
  });

  /// Returns a new [TableState] based on this one, overriding only the
  /// non-null parameters to produce an updated state.
  TableState copyWith({
    List<FormEntry>? originalData,
    List<FormEntry>? resultSet,
    List<SortState>? sortOrder,
    FilterQuery? filter,
  }) {
    return TableState(
      originalData: originalData ?? this.originalData,
      resultSet: resultSet ?? this.resultSet,
      sortOrder: sortOrder ?? this.sortOrder,
      filter: filter ?? this.filter,
    );
  }
}
