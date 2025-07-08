import "../../../utils/specification.dart";
import "../mentor_session/mentor_session.dart";

import "filter.dart";

extension FilterSpec on Filter {
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

class _StringSpec extends Specification<MentorSession> {
  final String Function(MentorSession) getter;
  final FilterOperator operator;
  final String query;

  _StringSpec(this.getter, {required this.operator, required this.query});

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
