import "dart:convert";

import "package:flutter/services.dart";

// to generate run: `dart run build_runner build --delete-conflicting-outputs`
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../domain/models/mentor_session/mentor_session.dart";

part "mentor_session_repository_local.g.dart";

@riverpod
class MentorSessionRepositoryLocal extends _$MentorSessionRepositoryLocal {
  @override
  Future<List<MentorSession>> build() async {
    final source = await rootBundle.loadString("examples/example.json");
    final List<dynamic> jsonList = json.decode(source);
    return jsonList.map((json) => MentorSession.fromJson(json)).toList();
  }
}
