/// Defines each column in a [FormEntry] and its display label.
enum Field {
  mentorName("Mentor Name"),
  studentName("Student Name"),
  sessionDetails("Session Details"),
  notes("Notes");

  final String text;
  const Field(this.text);

  /// Returns the human-readable label for this field.
  @override
  String toString() => text;
}

/// Represents a form entry with mentor and student details, session information, and notes.
class FormEntry {
  final String mentorName;
  final String studentName;
  final String sessionDetails;
  final String notes;

  /// A list of all [Field]s in their defined order, for dynamic table columns.
  static const List<Field> fields = Field.values;

  /// Creates a [FormEntry] with the given values for each field.
  FormEntry({
    required this.mentorName,
    required this.studentName,
    required this.sessionDetails,
    required this.notes,
  });

  /// Returns the value for [field] in this entry.
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

  /// Deserializes a JSON map into a [FormEntry].
  factory FormEntry.fromJson(Map<String, dynamic> json) {
    return FormEntry(
      mentorName: json["mentorName"] ?? "",
      studentName: json["studentName"] ?? "",
      sessionDetails: json["sessionDetails"] ?? "",
      notes: json["notes"] ?? "",
    );
  }
}
