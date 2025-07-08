// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mentor_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MentorSession implements DiagnosticableTreeMixin {

 String get mentorName; String get studentName; String get sessionDetails; String get notes;
/// Create a copy of MentorSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MentorSessionCopyWith<MentorSession> get copyWith => _$MentorSessionCopyWithImpl<MentorSession>(this as MentorSession, _$identity);

  /// Serializes this MentorSession to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MentorSession'))
    ..add(DiagnosticsProperty('mentorName', mentorName))..add(DiagnosticsProperty('studentName', studentName))..add(DiagnosticsProperty('sessionDetails', sessionDetails))..add(DiagnosticsProperty('notes', notes));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MentorSession&&(identical(other.mentorName, mentorName) || other.mentorName == mentorName)&&(identical(other.studentName, studentName) || other.studentName == studentName)&&(identical(other.sessionDetails, sessionDetails) || other.sessionDetails == sessionDetails)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mentorName,studentName,sessionDetails,notes);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MentorSession(mentorName: $mentorName, studentName: $studentName, sessionDetails: $sessionDetails, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $MentorSessionCopyWith<$Res>  {
  factory $MentorSessionCopyWith(MentorSession value, $Res Function(MentorSession) _then) = _$MentorSessionCopyWithImpl;
@useResult
$Res call({
 String mentorName, String studentName, String sessionDetails, String notes
});




}
/// @nodoc
class _$MentorSessionCopyWithImpl<$Res>
    implements $MentorSessionCopyWith<$Res> {
  _$MentorSessionCopyWithImpl(this._self, this._then);

  final MentorSession _self;
  final $Res Function(MentorSession) _then;

/// Create a copy of MentorSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mentorName = null,Object? studentName = null,Object? sessionDetails = null,Object? notes = null,}) {
  return _then(_self.copyWith(
mentorName: null == mentorName ? _self.mentorName : mentorName // ignore: cast_nullable_to_non_nullable
as String,studentName: null == studentName ? _self.studentName : studentName // ignore: cast_nullable_to_non_nullable
as String,sessionDetails: null == sessionDetails ? _self.sessionDetails : sessionDetails // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MentorSession].
extension MentorSessionPatterns on MentorSession {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MentorSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MentorSession() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MentorSession value)  $default,){
final _that = this;
switch (_that) {
case _MentorSession():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MentorSession value)?  $default,){
final _that = this;
switch (_that) {
case _MentorSession() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String mentorName,  String studentName,  String sessionDetails,  String notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MentorSession() when $default != null:
return $default(_that.mentorName,_that.studentName,_that.sessionDetails,_that.notes);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String mentorName,  String studentName,  String sessionDetails,  String notes)  $default,) {final _that = this;
switch (_that) {
case _MentorSession():
return $default(_that.mentorName,_that.studentName,_that.sessionDetails,_that.notes);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String mentorName,  String studentName,  String sessionDetails,  String notes)?  $default,) {final _that = this;
switch (_that) {
case _MentorSession() when $default != null:
return $default(_that.mentorName,_that.studentName,_that.sessionDetails,_that.notes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MentorSession with DiagnosticableTreeMixin implements MentorSession {
  const _MentorSession({required this.mentorName, required this.studentName, required this.sessionDetails, required this.notes});
  factory _MentorSession.fromJson(Map<String, dynamic> json) => _$MentorSessionFromJson(json);

@override final  String mentorName;
@override final  String studentName;
@override final  String sessionDetails;
@override final  String notes;

/// Create a copy of MentorSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MentorSessionCopyWith<_MentorSession> get copyWith => __$MentorSessionCopyWithImpl<_MentorSession>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MentorSessionToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MentorSession'))
    ..add(DiagnosticsProperty('mentorName', mentorName))..add(DiagnosticsProperty('studentName', studentName))..add(DiagnosticsProperty('sessionDetails', sessionDetails))..add(DiagnosticsProperty('notes', notes));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MentorSession&&(identical(other.mentorName, mentorName) || other.mentorName == mentorName)&&(identical(other.studentName, studentName) || other.studentName == studentName)&&(identical(other.sessionDetails, sessionDetails) || other.sessionDetails == sessionDetails)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mentorName,studentName,sessionDetails,notes);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MentorSession(mentorName: $mentorName, studentName: $studentName, sessionDetails: $sessionDetails, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$MentorSessionCopyWith<$Res> implements $MentorSessionCopyWith<$Res> {
  factory _$MentorSessionCopyWith(_MentorSession value, $Res Function(_MentorSession) _then) = __$MentorSessionCopyWithImpl;
@override @useResult
$Res call({
 String mentorName, String studentName, String sessionDetails, String notes
});




}
/// @nodoc
class __$MentorSessionCopyWithImpl<$Res>
    implements _$MentorSessionCopyWith<$Res> {
  __$MentorSessionCopyWithImpl(this._self, this._then);

  final _MentorSession _self;
  final $Res Function(_MentorSession) _then;

/// Create a copy of MentorSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mentorName = null,Object? studentName = null,Object? sessionDetails = null,Object? notes = null,}) {
  return _then(_MentorSession(
mentorName: null == mentorName ? _self.mentorName : mentorName // ignore: cast_nullable_to_non_nullable
as String,studentName: null == studentName ? _self.studentName : studentName // ignore: cast_nullable_to_non_nullable
as String,sessionDetails: null == sessionDetails ? _self.sessionDetails : sessionDetails // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
