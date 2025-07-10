/// Module: Mentor Session Repository (Local)
///
/// Provides a local implementation of the MentorSession repository using
/// a bundled JSON asset. Reads mentor session data from `examples/example.json`
/// and decodes it into `MentorSession` model instances.
///
/// **Setup:**
/// - Ensure `examples/example.json` exists in your Flutter project's
///   assets and is declared in `pubspec.yaml`.
/// - Run `flutter pub get` to include assets.
/// - To regenerate code, run:
///   `dart run build_runner build --delete-conflicting-outputs`.
library;

import "dart:convert";

import "package:flutter/services.dart";

import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../domain/models/mentor_session/mentor_session.dart";

part "mentor_session_repository_local.g.dart";

/// A Riverpod provider for loading mentor session data locally.
///
/// This class reads a local JSON file from assets and returns a list of
/// `MentorSession` objects.
///
/// Extends the generated `_$MentorSessionRepositoryLocal`.
@riverpod
class MentorSessionRepositoryLocal extends _$MentorSessionRepositoryLocal {
  @override
  /// Loads and parses mentor sessions from the bundled JSON asset.
  ///
  /// Reads the `examples/example.json` file via Flutter's asset bundle,
  /// decodes the JSON array, and maps each entry to a `MentorSession`.
  ///
  /// Returns a `Future` that completes with a list of `MentorSession`.
  ///
  /// **Throws:**
  /// - [FlutterError] if the asset cannot be loaded.
  /// - [FormatException] if the JSON is invalid.
  ///
  /// **Example:**
  /// ```dart
  /// final sessions = await ref.read(mentorSessionRepositoryLocalProvider.future);
  /// ```
  Future<List<MentorSession>> build() async {
    final source = await rootBundle.loadString("examples/example.json");
    final List<dynamic> jsonList = json.decode(source);
    return jsonList.map((json) => MentorSession.fromJson(json)).toList();
  }
}
