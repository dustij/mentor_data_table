// See: https://pub.dev/documentation/freezed/latest/#run-the-generator
import "package:freezed_annotation/freezed_annotation.dart";

import "../../../../domain/models/filter/filter.dart";
import "../../../../domain/models/mentor_session/mentor_session.dart";
import "../../../../domain/models/sort/sort.dart";

part "table_state.freezed.dart";

@freezed
abstract class TableState with _$TableState {
  const factory TableState({
    @Default([]) List<MentorSession> data,
    @Default([]) List<Filter> filters,
    @Default([]) List<Sort> sorts,
    @Default("") String searchTerm,
    @Default(false) bool isFilterMenuOpen,
  }) = _TableState;
}
