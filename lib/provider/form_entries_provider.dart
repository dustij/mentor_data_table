import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'fetch_policy.dart';
import 'form_entry.dart';

// Generated code lives in part
// to generate run: `flutter pub run build_runner build --delete-conflicting-outputs`
part 'form_entries_provider.g.dart';

final sortFieldProvider = StateProvider<String?>((ref) => null);

@riverpod
class FormEntries extends _$FormEntries {
  List<FormEntry> _original = [];
  bool isAscending = true;
  String? _lastSortedField;

  @override
  Future<List<FormEntry>> build() async {
    final field = ref.watch(sortFieldProvider);

    // simulated delay, remove later
    // await Future.delayed(const Duration(seconds: 2));

    final fetched = await activeFetchPolicy.fetch();
    _original = fetched;

    if (field != null) {
      if (_lastSortedField == field) {
        isAscending = !isAscending;
      } else {
        isAscending = true;
        _lastSortedField = field;
      }

      int compareFn(FormEntry a, FormEntry b) => a[field].compareTo(b[field]);
      final sorted = [...fetched]
        ..sort((a, b) => isAscending ? compareFn(a, b) : compareFn(b, a));
      return sorted;
    }
    return List.of(fetched);
  }

  void sortBy(String field, Comparator<FormEntry> compareFn) {
    // If sorting the same column again, toggle the sort order.
    // If sorting a new column, reset to ascending and update the last sorted field.
    if (_lastSortedField == field) {
      isAscending = !isAscending;
    } else {
      isAscending = true;
      _lastSortedField = field;
    }

    final sorted = [...?state.value]
      ..sort((a, b) => isAscending ? compareFn(a, b) : compareFn(b, a));

    state = AsyncData(sorted);
  }

  void filterBy(bool Function(FormEntry) filterFn) {
    final filtered = _original.where(filterFn).toList();
    state = AsyncData(filtered);
  }

  void reset() {
    state = AsyncData(List.of(_original));
  }
}
