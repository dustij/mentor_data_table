enum Field {
  mentorName("Mentor Name"),
  studentName("Student Name"),
  sessionDetails("Session Details"),
  notes("Notes");

  final String field;
  const Field(this.field);

  @override
  String toString() => field;
}

/// Represents a form entry with mentor and student details, session information, and notes.
class FormEntry {
  final String mentorName;
  final String studentName;
  final String sessionDetails;
  final String notes;

  static const List<Field> fields = Field.values;

  /// Returns the value of the given [field] for this entry.
  ///
  /// Example:
  /// ```dart
  /// final entry = FormEntry(
  ///   mentorName: 'Alice',
  ///   studentName: 'Bob',
  ///   sessionDetails: 'Math tutoring',
  ///   notes: 'Needs extra practice',
  /// );
  /// final mentor = entry[Field.mentorName]; // 'Alice'
  /// final notes  = entry[Field.notes];      // 'Needs extra practice'
  /// ```
  dynamic operator [](Field field) {
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

  /// Creates a new FormEntry instance with the given values.
  FormEntry({
    required this.mentorName,
    required this.studentName,
    required this.sessionDetails,
    required this.notes,
  });

  /// Creates a FormEntry instance from a JSON map.
  factory FormEntry.fromJson(Map<String, dynamic> json) {
    return FormEntry(
      mentorName: json["mentorName"] ?? "",
      studentName: json["studentName"] ?? "",
      sessionDetails: json["sessionDetails"] ?? "",
      notes: json["notes"] ?? "",
    );
  }
}
