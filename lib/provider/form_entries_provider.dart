import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'data_policy.dart';
import 'form_entry.dart';

// Generated code lives in part
// to generate run: `flutter pub run build_runner build --delete-conflicting-outputs`
part 'form_entries_provider.g.dart';

@riverpod
class FormEntries extends _$FormEntries {
  List<FormEntry> _original = [];

  @override
  Future<List<FormEntry>> build() async {
    final fetched = await activePolicy.fetchEntries();
    _original = fetched;
    return List.of(fetched);
  }

  void sortBy(Comparator<FormEntry> compareFn) {
    final sorted = [...?state.value]..sort(compareFn);
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
