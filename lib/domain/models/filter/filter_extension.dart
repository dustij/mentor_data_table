/// Module: Filter to Specification Adapter
///
/// Defines an extension on `Filter` that converts filter criteria into
/// a `Specification<MentorSession>`, enabling the filtering of session lists
/// based on mentor name, student name, session details, or notes.
library;

import "../../../utils/specification.dart";
import "../mentor_session/mentor_session.dart";

import "filter.dart";

/// An extension that adds a `toSpecification` method to `Filter`.
///
/// Converts a `Filter` instance (field, operator, and text) into a
/// domain-specific `Specification<MentorSession>`.
extension FilterSpec on Filter {
  /// Creates a `Specification<MentorSession>` from this `Filter`.
  ///
  /// Examines the `field` to determine which `MentorSession` property to
  /// apply the operator and query against.
  ///
  /// **Returns:**
  /// - A `_StringSpec` configured with the correct getter, operator, and query.
  ///
  /// **Example:**
  /// ```dart
  /// final filter = Filter(field: Field.mentorName, operator: .includes, filterText: "john");
  /// final spec = filter.toSpecification();
  /// final matches = sessions.where(spec.isSatisfiedBy);
  /// ```
  Specification<MentorSession> toSpecification() {
    switch (field) {
      case Field.mentorName:
        return _StringSpec(
          (m) => m.mentorName,
          operator: filterOperator,
          query: filterText,
        );
      case Field.studentName:
        return _StringSpec(
          (m) => m.studentName,
          operator: filterOperator,
          query: filterText,
        );
      case Field.sessionDetails:
        return _StringSpec(
          (m) => m.sessionDetails,
          operator: filterOperator,
          query: filterText,
        );
      case Field.notes:
        return _StringSpec(
          (m) => m.notes,
          operator: filterOperator,
          query: filterText,
        );
    }
  }
}

/// A `Specification` implementation for string-based filtering on `MentorSession`.
///
/// Uses a getter function to extract a string property from `MentorSession`,
/// then applies the `FilterOperator` and query text.
class _StringSpec extends Specification<MentorSession> {
  final String Function(MentorSession) getter;
  final FilterOperator operator;
  final String query;

  /// Constructs a `_StringSpec`.
  ///
  /// **Parameters:**
  /// - `getter` (`String Function(MentorSession)`): Function to extract the field.
  /// - `operator` (`FilterOperator`): The comparison operator.
  /// - `query` (`String`): The text to compare against.
  _StringSpec(this.getter, {required this.operator, required this.query});

  /// Evaluates whether the given `MentorSession` satisfies the filter.
  ///
  /// **Parameters:**
  /// - `m` (`MentorSession`): The session to test.
  ///
  /// **Returns:** `true` if the session's field satisfies the operator and query.
  ///
  /// **Example:**
  /// ```dart
  /// final spec = Filter(field: Field.notes, operator: .includes, filterText: "error")
  ///     .toSpecification();
  /// spec.isSatisfiedBy(session); // true if session.notes contains "error"
  /// ```
  @override
  bool isSatisfiedBy(MentorSession m) {
    final value = getter(m).toLowerCase();
    final q = query.toLowerCase();
    switch (operator) {
      case FilterOperator.equals:
        return value == q;
      case FilterOperator.includes:
        return value.contains(q);
    }
  }
}
