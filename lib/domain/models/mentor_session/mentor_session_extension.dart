/// Module: MentorSession Extension Adapter
///
/// Provides an extension on `MentorSession` to allow accessing its
/// properties via the `Field` enum, facilitating generic field-based
/// operations (e.g., filtering or sorting).
library;

import "../filter/filter.dart";

import "mentor_session.dart";

/// An extension on `MentorSession` for indexed property access.
///
/// Adds `operator []` to retrieve property values by `Field`.
extension MentorSessionIndex on MentorSession {
  /// Retrieves the value of the specified field from this session.
  ///
  /// **Parameters:**
  /// - `field` (`Field`): The session property to access.
  ///
  /// **Returns:** `String` value of the property.
  ///
  /// **Example:**
  /// ```dart
  /// final mentorName = session[Field.mentorName];
  /// ```
  String operator [](Field field) {
    switch (field) {
      case Field.mentorName:
        return mentorName;
      case Field.studentName:
        return studentName;
      case Field.sessionDetails:
        return sessionDetails;
      case Field.notes:
        return notes;
    }
  }
}
