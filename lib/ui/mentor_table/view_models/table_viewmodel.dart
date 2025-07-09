/// Module: Table ViewModel
///
/// Provides a Riverpod AsyncNotifier (`TableViewModel`) for managing the
/// mentor sessions table state. Responsibilities include:
/// - Loading initial session data from the local repository.
/// - Handling search term updates.
/// - Toggling and applying filters.
/// - Managing sort criteria.
/// - Exporting table data to XLS via `ExportXlsService`.
///
/// **Setup:**
/// - Ensure `MentorSessionRepositoryLocal` and `ExportXlsService` are available.
library;

import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../data/repositories/mentor_session/mentor_session_repository_local.dart";
import "../../../data/services/export_xls/export_xls_service.dart";
import "../../../domain/models/filter/filter.dart";
import "../../../domain/models/filter/filter_extension.dart";
import "../../../domain/models/mentor_session/mentor_session.dart";
import "../../../domain/models/mentor_session/mentor_session_extension.dart";
import "../../../domain/models/sort/sort.dart";

import "table_state/table_state.dart";

part "table_viewmodel.g.dart";

/// A `AsyncNotifier<TableState>` that encapsulates the table UI logic.
///
/// Initializes with raw session data and exposes methods for search,
/// filter, sort, and export operations. All state modifications trigger
/// a private `_recompute` to update the visible data.
@riverpod
class TableViewModel extends _$TableViewModel {
  /// Loads mentor session data and returns the initial table state.
  ///
  /// **Returns:** `Future<TableState>` with `data` from the repository,
  /// empty `filters`, `sorts`, and `searchTerm`.
  ///
  /// **Example:**
  /// ```dart
  /// final state = await ref.read(tableViewModelProvider.future);
  /// ```
  @override
  Future<TableState> build() async {
    final raw = await ref.watch(mentorSessionRepositoryLocalProvider.future);
    return TableState(data: raw, filters: [], sorts: [], searchTerm: "");
  }

  /// Updates the search term and refreshes the table data.
  ///
  /// **Parameters:**
  /// - `text` (`String`): The new search query.
  void setSearchTerm(String text) {
    state = state.whenData((prev) => prev.copyWith(searchTerm: text));
    _recompute();
  }

  /// Toggles the visibility of the filter menu and refreshes data.
  void toggleFilterMenu() {
    state = state.whenData(
      (prev) => prev.copyWith(isFilterMenuOpen: !prev.isFilterMenuOpen),
    );
    _recompute();
  }

  /// Applies the provided list of filters and refreshes the table data.
  ///
  /// **Parameters:**
  /// - `filters` (`List<Filter>`): Active filter criteria.
  void setFilters(List<Filter> filters) {
    state = state.whenData((prev) => prev.copyWith(filters: filters));
    _recompute();
  }

  /// Clears all filters and refreshes the table data.
  void clearFilters() {
    state = state.whenData((prev) => prev.copyWith(filters: <Filter>[]));
    _recompute();
  }

  /// Toggles sort direction for the given field and refreshes data.
  ///
  /// Cycles through `none`→`asc`→`desc`→`none`.
  ///
  /// **Parameters:**
  /// - `field` (`Field`): The column to sort by.
  void updateSorts(Field field) {
    state = state.whenData((prev) {
      final existingIndex = prev.sorts.indexWhere((s) => s.field == field);
      final currentDirection = existingIndex == -1
          ? SortDirection.none
          : prev.sorts[existingIndex].sortDirection;

      final nextDirection = switch (currentDirection) {
        SortDirection.none => SortDirection.asc,
        SortDirection.asc => SortDirection.desc,
        SortDirection.desc => SortDirection.none,
      };

      final newSorts = List<Sort>.from(prev.sorts);

      // If already in list, then remove it
      if (existingIndex != -1) {
        newSorts.removeAt(existingIndex);
      }

      // If a direction is declared, then insert into old position
      if (nextDirection != SortDirection.none) {
        final index = existingIndex != -1 ? existingIndex : newSorts.length;
        newSorts.insert(
          index,
          Sort(field: field, sortDirection: nextDirection),
        );
      }

      return prev.copyWith(sorts: newSorts);
    });
    _recompute();
  }

  /// Exports current table rows to an XLS file using `ExportXlsService`.
  ///
  /// **Returns:** `Future<bool>` indicating success (`true`) or failure (`false`).
  Future<bool> exportToXls() async {
    final table = state.requireValue;
    final rows = table.data;

    try {
      final isSuccess = await ExportXlsService.exec(
        fileName: "mentor_session_table",
        data: rows,
      );
      return isSuccess;
    } catch (_) {
      return false;
    }
  }

  /// Recomputes visible table data by applying filters, search, and sorts.
  ///
  /// Uses raw data from the repository and updates `state.data`.
  void _recompute() {
    final rawAsync = ref.read(mentorSessionRepositoryLocalProvider);
    // Use valueOrNull to safely extract the loaded list, or empty if not ready
    final rawList = rawAsync.valueOrNull ?? [];
    final filtered = _applyFilters(rawList, state.requireValue.filters);
    final searched = _applySearch(filtered, state.requireValue.searchTerm);
    final sorted = _applySort(searched, state.requireValue.sorts);
    state = state.whenData((current) => current.copyWith(data: sorted));
  }

  /// Filters the raw session list by the active filters specification.
  ///
  /// **Parameters:**
  /// - `raw` (`List<MentorSession>`): Original session list.
  /// - `filters` (`List<Filter>`): Filters to apply.
  ///
  /// **Returns:** A filtered list of `MentorSession`.
  List<MentorSession> _applyFilters(
    List<MentorSession> raw,
    List<Filter> filters,
  ) {
    if (filters.isEmpty) return List.from(raw);

    final spec = filters
        .map((f) => f.toSpecification())
        .reduce((acc, spec) => acc.and(spec));

    return raw.where(spec.isSatisfiedBy).toList();
  }

  /// Filters sessions by the search term across all text fields.
  ///
  /// **Parameters:**
  /// - `filtered` (`List<MentorSession>`): Sessions after filter step.
  /// - `s` (`String`): Current search term.
  ///
  /// **Returns:** A list of sessions matching the search query.
  List<MentorSession> _applySearch(List<MentorSession> filtered, String s) {
    if (s.isEmpty) return List.from(filtered);

    final other = s.toLowerCase();
    return filtered.where((session) {
      return session.mentorName.toLowerCase().contains(other) ||
          session.studentName.toLowerCase().contains(other) ||
          session.sessionDetails.toLowerCase().contains(other) ||
          session.notes.toLowerCase().contains(other);
    }).toList();
  }

  /// Sorts the session list according to the active sort criteria.
  ///
  /// **Parameters:**
  /// - `data` (`List<MentorSession>`): Sessions after search step.
  /// - `sorts` (`List<Sort>`): Sort specifications.
  ///
  /// **Returns:** A sorted list of `MentorSession`.
  List<MentorSession> _applySort(List<MentorSession> data, List<Sort> sorts) {
    // If no sorts defined, return a shallow copy
    if (sorts.isEmpty) return List.from(data);

    final newData = List<MentorSession>.from(data);

    newData.sort((a, b) {
      for (final sort in sorts) {
        final aVal = a[sort.field];
        final bVal = b[sort.field];
        final result = aVal.compareTo(bVal);
        if (result != 0) {
          return sort.sortDirection == SortDirection.asc ? result : -result;
        }
      }
      return 0;
    });

    return newData;
  }
}
