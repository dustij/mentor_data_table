/// Module: MentorSession Model
///
/// Defines the data model for a mentor session, capturing the mentor’s name,
/// the student’s name, session details, and any additional notes.
library;

import "package:flutter/foundation.dart";

// See: https://pub.dev/documentation/freezed/latest/#run-the-generator
import "package:freezed_annotation/freezed_annotation.dart";

part "mentor_session.freezed.dart";

part "mentor_session.g.dart";

/// A data class representing a single mentor session record.
///
/// This class is generated via Freezed and includes JSON serialization
/// support. It holds the following fields:
/// - `mentorName` (`String`): Full name of the mentor.
/// - `studentName` (`String`): Full name of the student.
/// - `sessionDetails` (`String`): Description of the session content.
/// - `notes` (`String`): Any supplementary notes for the session.
@freezed
abstract class MentorSession with _$MentorSession {
  const factory MentorSession({
    /// The mentor's full name.
    required String mentorName,

    /// The student's full name.
    required String studentName,

    /// A description of what occurred during the session.
    required String sessionDetails,

    /// Additional notes or observations from the session.
    required String notes,
  }) = _MentorSession;

  /// Constructs a `MentorSession` from a JSON map.
  ///
  /// **Parameters:**
  /// - `json` (`Map<String, Object?>`): The JSON map to deserialize.
  ///
  /// **Returns:** A new `MentorSession` instance.
  ///
  /// **Example:**
  /// ```dart
  /// final session = MentorSession.fromJson(jsonMap);
  /// ```
  factory MentorSession.fromJson(Map<String, Object?> json) =>
      _$MentorSessionFromJson(json);
}
