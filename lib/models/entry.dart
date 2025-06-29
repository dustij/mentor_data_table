enum EntryField {
  mentorName("Mentor Name"),
  studentName("Student Name"),
  sessionDetails("Session Details"),
  notes("Notes");

  final String text;
  const EntryField(this.text);

  @override
  String toString() => text;
}

class Entry {
  final String mentorName;
  final String studentName;
  final String sessionDetails;
  final String notes;

  static const List<EntryField> fields = EntryField.values;

  Entry({
    required this.mentorName,
    required this.studentName,
    required this.sessionDetails,
    required this.notes,
  });

  String operator [](EntryField field) {
    switch (field) {
      case EntryField.mentorName:
        return mentorName;
      case EntryField.studentName:
        return studentName;
      case EntryField.sessionDetails:
        return sessionDetails;
      case EntryField.notes:
        return notes;
    }
  }

  factory Entry.fromJson(Map<String, dynamic> data) {
    return Entry(
      mentorName: data["mentorName"] ?? "",
      studentName: data["studentName"] ?? "",
      sessionDetails: data["sessionDetails"] ?? "",
      notes: data["notes"] ?? "",
    );
  }
}
