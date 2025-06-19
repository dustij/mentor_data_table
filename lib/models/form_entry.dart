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

class FormEntry {
  final String mentorName;
  final String studentName;
  final String sessionDetails;
  final String notes;

  static const List<Field> fields = Field.values;

  /// Allow dynamic access to fields by name
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

  FormEntry({
    required this.mentorName,
    required this.studentName,
    required this.sessionDetails,
    required this.notes,
  });

  factory FormEntry.fromJson(Map<String, dynamic> json) {
    return FormEntry(
      mentorName: json["mentorName"] ?? "",
      studentName: json["studentName"] ?? "",
      sessionDetails: json["sessionDetails"] ?? "",
      notes: json["notes"] ?? "",
    );
  }
}
