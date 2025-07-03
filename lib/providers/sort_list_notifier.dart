import "package:mentor_data_table/models/entry.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../models/sort.dart";

// to generate run: `dart run build_runner build --delete-conflicting-outputs`
part "sort_list_notifier.g.dart";

@riverpod
class SortListNotifier extends _$SortListNotifier {
  @override
  List<Sort> build() => [];

  void updateSort(EntryField field) {
    final existingIndex = state.indexWhere((s) => s.field == field);
    final currentDirection = existingIndex == -1
        ? SortDirection.none
        : state[existingIndex].direction;

    final nextDirection = switch (currentDirection) {
      SortDirection.none => SortDirection.asc,
      SortDirection.asc => SortDirection.desc,
      SortDirection.desc => SortDirection.none,
    };

    final newState = List<Sort>.from(state);

    // If already in list, then remove it
    if (existingIndex != -1) {
      newState.removeAt(existingIndex);
    }

    // If a direction is declared, then insert into old position
    if (nextDirection != SortDirection.none) {
      final index = existingIndex != -1 ? existingIndex : newState.length;
      newState.insert(index, Sort(field: field, direction: nextDirection));
    }

    state = newState;
  }
}
