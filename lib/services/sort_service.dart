import "../models/form_entry.dart";
import "../models/sort_state.dart";

/// Service providing sorting operations for `FormEntry` lists.
///
/// Includes methods to update sort order precedence based on user interactions
/// and apply cascading multi-column sorts.
class SortService {
  /// Updates the sort order list based on toggling [column].
  ///
  /// - [sortOrder]: the existing list of sort states in precedence order.
  /// - [column]: the column whose sort direction is toggled.
  ///
  /// Returns a new list of `SortState` reflecting the updated direction and order.
  List<SortState> updateSortOrder({
    required List<SortState> sortOrder,
    required Field column,
  }) {
    // Check if the column is already in the current sort order.
    // If not found, return a default SortState with no direction.
    final existingIndex = sortOrder.indexWhere((s) => s.column == column);
    final currentDirection = existingIndex == -1
        ? SortDirection.none
        : sortOrder[existingIndex].direction;

    // Determine the next sort direction in the tri-state cycle:
    SortDirection nextDirection = switch (currentDirection) {
      SortDirection.none => SortDirection.asc,
      SortDirection.asc => SortDirection.desc,
      SortDirection.desc => SortDirection.none,
    };

    // Copy state (follow rules for keeping state immutable)
    final newSortOrder = List<SortState>.from(sortOrder);

    // If column's sort state existed, remove it from the list
    if (existingIndex != -1) {
      newSortOrder.removeAt(existingIndex);
    }

    // If the direction is declared, insert the new sort state in its old position for this column
    if (nextDirection != SortDirection.none) {
      final insertIndex = existingIndex != -1
          ? existingIndex
          : newSortOrder.length;
      newSortOrder.insert(
        insertIndex,
        SortState(column: column, direction: nextDirection),
      );
    }

    return newSortOrder;
  }

  /// Sorts the provided list of [FormEntry] items according to the given [sortOrder].
  ///
  /// Performs a cascading, multi-column sort: it iterates through the [sortOrder] list,
  /// comparing each pair of entries by the specified column in sequence. If two entries
  /// are equal on one column, the next column in the sequence is used to break ties.
  ///
  /// - [entries]: The original list of entries to sort. A new sorted list is returned,
  ///   and the input list remains unmodified.
  /// - [sortOrder]: A list of [SortState] objects indicating which columns to sort by
  ///   and in which direction (ascending or descending). An empty [sortOrder] returns
  ///   the data in its original order.
  ///
  /// Returns a new `List<FormEntry>` sorted according to the specified order.
  List<FormEntry> applySort({
    required List<FormEntry> entries,
    required List<SortState> sortOrder,
  }) {
    // Copy state (follow rules for keeping state immutable)
    final newEntries = List<FormEntry>.from(entries);

    // Apply cascading sort based on the provided sort order.
    newEntries.sort((a, b) {
      for (final sort in sortOrder) {
        final aVal = a[sort.column];
        final bVal = b[sort.column];
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
