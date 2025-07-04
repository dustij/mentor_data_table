import "package:riverpod_annotation/riverpod_annotation.dart";

// to generate run: `dart run build_runner build --delete-conflicting-outputs`
part "filter_menu_open_notifier.g.dart";

@riverpod
class FilterMenuOpenNotifier extends _$FilterMenuOpenNotifier {
  @override
  bool build() => false;

  void toggle() => state = !state;
}
