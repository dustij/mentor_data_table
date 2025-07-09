/// Module: Table State
///
/// Defines the UI state for the mentor sessions table, including:
/// - `data`: the list of sessions to display,
/// - `filters`: the active filter criteria,
/// - `sorts`: the active sorting criteria,
/// - `searchTerm`: the current search string,
/// - `isFilterMenuOpen`: visibility of the filter menu.
library;

// See: https://pub.dev/documentation/freezed/latest/#run-the-generator
import "package:freezed_annotation/freezed_annotation.dart";

import "../../../../domain/models/filter/filter.dart";
import "../../../../domain/models/mentor_session/mentor_session.dart";
import "../../../../domain/models/sort/sort.dart";

part "table_state.freezed.dart";

/// A value object representing the current UI state of the mentor session table.
@freezed
abstract class TableState with _$TableState {
  const factory TableState({
    /// The list of mentor sessions displayed in the table.
    @Default([]) List<MentorSession> data,

    /// The active filter criteria applied to the sessions.
    @Default([]) List<Filter> filters,

    /// The active sort criteria applied to the sessions.
    @Default([]) List<Sort> sorts,

    /// The current search term used to filter sessions by text.
    @Default("") String searchTerm,

    /// Whether the filter menu is currently open in the UI.
    @Default(false) bool isFilterMenuOpen,
  }) = _TableState;
}
