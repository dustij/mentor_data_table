class SubmissionEntry {
  final String mentorName;
  final String studentName;
  final String sessionDetails;
  final String notes;

  SubmissionEntry({
    required this.mentorName,
    required this.studentName,
    required this.sessionDetails,
    required this.notes,
  });

  static List<String> fields() {
    return ["Mentor Name", "Student Name", "Session Details", "Notes"];
  }
}
