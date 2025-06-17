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

  FormEntry({
    required this.mentorName,
    required this.studentName,
    required this.sessionDetails,
    required this.notes,
  });
}
