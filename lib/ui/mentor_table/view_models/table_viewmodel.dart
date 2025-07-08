// to generate run: `dart run build_runner build --delete-conflicting-outputs`
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

@riverpod
class TableViewModel extends _$TableViewModel {
  @override
  Future<TableState> build() async {
    final raw = await ref.watch(mentorSessionRepositoryLocalProvider.future);
    return TableState(data: raw, filters: [], sorts: [], searchTerm: "");
  }

  void setSearchTerm(String text) {
    state = state.whenData((prev) => prev.copyWith(searchTerm: text));
    _recompute();
  }

  void toggleFilterMenu() {
    state = state.whenData(
      (prev) => prev.copyWith(isFilterMenuOpen: !prev.isFilterMenuOpen),
    );
    _recompute();
  }

  void setFilters(List<Filter> filters) {
    state = state.whenData((prev) => prev.copyWith(filters: filters));
    _recompute();
  }

  void clearFilters() {
    state = state.whenData((prev) => prev.copyWith(filters: <Filter>[]));
    _recompute();
  }

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

  void _recompute() {
    final rawAsync = ref.read(mentorSessionRepositoryLocalProvider);
    // Use valueOrNull to safely extract the loaded list, or empty if not ready
    final rawList = rawAsync.valueOrNull ?? [];
    final filtered = _applyFilters(rawList, state.requireValue.filters);
    final searched = _applySearch(filtered, state.requireValue.searchTerm);
    final sorted = _applySort(searched, state.requireValue.sorts);
    state = state.whenData((current) => current.copyWith(data: sorted));
  }

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
