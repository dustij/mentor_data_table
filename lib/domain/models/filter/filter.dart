import "package:flutter/foundation.dart";

// See: https://pub.dev/documentation/freezed/latest/#run-the-generator
import "package:freezed_annotation/freezed_annotation.dart";

part "filter.freezed.dart";

enum Field {
  mentorName("Mentor Name"),
  studentName("Student Name"),
  sessionDetails("Session Details"),
  notes("Notes");

  final String text;
  const Field(this.text);

  @override
  String toString() => text;
}

enum FilterOperator { includes, equals }

@freezed
abstract class Filter with _$Filter {
  const factory Filter({
    required Field field,
    required FilterOperator filterOperator,
    required String filterText,
  }) = _Filter;
}
