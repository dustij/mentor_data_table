class FormEntry {
  final String mentorName;
  final String studentName;
  final String sessionDetails;
  final String notes;

  static const List<String> fields = [
    "Mentor Name",
    "Student Name",
    "Session Details",
    "Notes",
  ];

  /// Allow dynamic access to fields by name
  dynamic operator [](String key) {
    switch (key) {
      case 'Mentor Name':
        return mentorName;
      case 'Student Name':
        return studentName;
      case 'Session Details':
        return sessionDetails;
      case 'Notes':
        return notes;
      default:
        throw ArgumentError('Invalid field name: $key');
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
