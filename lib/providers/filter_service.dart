import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../services/filter_service.dart";

// Generated code lives in part
// to generate run: `flutter pub run build_runner build --delete-conflicting-outputs`
part "filter_service.g.dart";

@riverpod
FilterService filterService(Ref ref) {
  return FilterServiceImpl();
}
