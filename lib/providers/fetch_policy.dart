import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../data/example_policy.dart";
import "../data/fetch_policy.dart";

// Generated code lives in part
// to generate run: `flutter pub run build_runner build --delete-conflicting-outputs`
part "fetch_policy.g.dart";

@riverpod
FetchPolicy fetchPolicy(Ref ref) {
  return ExamplePolicy();
}
