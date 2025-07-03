import "package:riverpod_annotation/riverpod_annotation.dart";

import "package:mentor_data_table/models/filter.dart";

// to generate run: `dart run build_runner build --delete-conflicting-outputs`
part "filter_list_notifier.g.dart";

@riverpod
class FilterListNotifier extends _$FilterListNotifier {
  @override
  List<Filter> build() => [];

  void set(List<Filter> fs) => state = fs;
  void add(Filter f) => state = [...state, f];
  void remove(Filter f) => state = state.where((x) => x != f).toList();
  void clear() => state = [];
}
