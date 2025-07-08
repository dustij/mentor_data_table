// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mentor_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MentorSession _$MentorSessionFromJson(Map<String, dynamic> json) =>
    _MentorSession(
      mentorName: json['mentorName'] as String,
      studentName: json['studentName'] as String,
      sessionDetails: json['sessionDetails'] as String,
      notes: json['notes'] as String,
    );

Map<String, dynamic> _$MentorSessionToJson(_MentorSession instance) =>
    <String, dynamic>{
      'mentorName': instance.mentorName,
      'studentName': instance.studentName,
      'sessionDetails': instance.sessionDetails,
      'notes': instance.notes,
    };
