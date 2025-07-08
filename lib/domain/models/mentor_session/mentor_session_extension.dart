import "../filter/filter.dart";

import "mentor_session.dart";

extension MentorSessionIndex on MentorSession {
  /// Allows accessing MentorSession properties via a Field enum.
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
