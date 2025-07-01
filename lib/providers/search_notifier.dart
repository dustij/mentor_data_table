import "package:riverpod_annotation/riverpod_annotation.dart";

// to generate run: `dart run build_runner build --delete-conflicting-outputs`
part "search_notifier.g.dart";

@riverpod
class SearchNotifier extends _$SearchNotifier {
  @override
  String build() => "";

  void set(String text) {
    state = text;
  }

  void clear() {
    state = "";
  }
}
