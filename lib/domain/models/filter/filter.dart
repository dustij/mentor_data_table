/// Module: Filter Model
///
/// Defines the criteria for filtering `MentorSession` records,
/// including which field to examine, the comparison operator,
/// and the text to filter by.
library;

import "package:flutter/foundation.dart";

// See: https://pub.dev/documentation/freezed/latest/#run-the-generator
import "package:freezed_annotation/freezed_annotation.dart";

part "filter.freezed.dart";

/// The session properties that can be filtered.
///
/// - `mentorName`: Filter by the mentor’s name.
/// - `studentName`: Filter by the student's name.
/// - `sessionDetails`: Filter by the session details text.
/// - `notes`: Filter by the notes associated with the session.
enum Field {
  mentorName("Mentor Name"),
  studentName("Student Name"),
  sessionDetails("Session Details"),
  notes("Notes");

  final String text;
  const Field(this.text);

  @override
  String toString() => text;
}

/// The comparison operators for filtering string values.
///
/// - `includes`: True if the field contains the filter text.
/// - `equals`: True if the field exactly matches the filter text.
enum FilterOperator { includes, equals }

/// A value object representing a filter criterion.
///
/// Combines:
/// - `field`: the session property to apply the filter on.
/// - `filterOperator`: the comparison operator.
/// - `filterText`: the text value to compare against.
@freezed
abstract class Filter with _$Filter {
  const factory Filter({
    /// The session property to filter by.
    required Field field,

    /// The operator to apply when comparing field values.
    required FilterOperator filterOperator,

    /// The text value to compare against the session’s field.
    required String filterText,
  }) = _Filter;
}
