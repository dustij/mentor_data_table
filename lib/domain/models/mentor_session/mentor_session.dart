import "package:flutter/foundation.dart";

// See: https://pub.dev/documentation/freezed/latest/#run-the-generator
import "package:freezed_annotation/freezed_annotation.dart";

part "mentor_session.freezed.dart";

part "mentor_session.g.dart";

@freezed
abstract class MentorSession with _$MentorSession {
  const factory MentorSession({
    required String mentorName,
    required String studentName,
    required String sessionDetails,
    required String notes,
  }) = _MentorSession;

  factory MentorSession.fromJson(Map<String, Object?> json) =>
      _$MentorSessionFromJson(json);
}
