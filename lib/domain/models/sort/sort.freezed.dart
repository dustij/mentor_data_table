// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sort.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Sort implements DiagnosticableTreeMixin {

 Field get field; SortDirection get sortDirection;
/// Create a copy of Sort
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SortCopyWith<Sort> get copyWith => _$SortCopyWithImpl<Sort>(this as Sort, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Sort'))
    ..add(DiagnosticsProperty('field', field))..add(DiagnosticsProperty('sortDirection', sortDirection));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Sort&&(identical(other.field, field) || other.field == field)&&(identical(other.sortDirection, sortDirection) || other.sortDirection == sortDirection));
}


@override
int get hashCode => Object.hash(runtimeType,field,sortDirection);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Sort(field: $field, sortDirection: $sortDirection)';
}


}

/// @nodoc
abstract mixin class $SortCopyWith<$Res>  {
  factory $SortCopyWith(Sort value, $Res Function(Sort) _then) = _$SortCopyWithImpl;
@useResult
$Res call({
 Field field, SortDirection sortDirection
});




}
/// @nodoc
class _$SortCopyWithImpl<$Res>
    implements $SortCopyWith<$Res> {
  _$SortCopyWithImpl(this._self, this._then);

  final Sort _self;
  final $Res Function(Sort) _then;

/// Create a copy of Sort
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? field = null,Object? sortDirection = null,}) {
  return _then(_self.copyWith(
field: null == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as Field,sortDirection: null == sortDirection ? _self.sortDirection : sortDirection // ignore: cast_nullable_to_non_nullable
as SortDirection,
  ));
}

}


/// Adds pattern-matching-related methods to [Sort].
extension SortPatterns on Sort {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Sort value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Sort() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Sort value)  $default,){
final _that = this;
switch (_that) {
case _Sort():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Sort value)?  $default,){
final _that = this;
switch (_that) {
case _Sort() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Field field,  SortDirection sortDirection)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Sort() when $default != null:
return $default(_that.field,_that.sortDirection);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Field field,  SortDirection sortDirection)  $default,) {final _that = this;
switch (_that) {
case _Sort():
return $default(_that.field,_that.sortDirection);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Field field,  SortDirection sortDirection)?  $default,) {final _that = this;
switch (_that) {
case _Sort() when $default != null:
return $default(_that.field,_that.sortDirection);case _:
  return null;

}
}

}

/// @nodoc


class _Sort with DiagnosticableTreeMixin implements Sort {
  const _Sort({required this.field, required this.sortDirection});
  

@override final  Field field;
@override final  SortDirection sortDirection;

/// Create a copy of Sort
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SortCopyWith<_Sort> get copyWith => __$SortCopyWithImpl<_Sort>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Sort'))
    ..add(DiagnosticsProperty('field', field))..add(DiagnosticsProperty('sortDirection', sortDirection));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Sort&&(identical(other.field, field) || other.field == field)&&(identical(other.sortDirection, sortDirection) || other.sortDirection == sortDirection));
}


@override
int get hashCode => Object.hash(runtimeType,field,sortDirection);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Sort(field: $field, sortDirection: $sortDirection)';
}


}

/// @nodoc
abstract mixin class _$SortCopyWith<$Res> implements $SortCopyWith<$Res> {
  factory _$SortCopyWith(_Sort value, $Res Function(_Sort) _then) = __$SortCopyWithImpl;
@override @useResult
$Res call({
 Field field, SortDirection sortDirection
});




}
/// @nodoc
class __$SortCopyWithImpl<$Res>
    implements _$SortCopyWith<$Res> {
  __$SortCopyWithImpl(this._self, this._then);

  final _Sort _self;
  final $Res Function(_Sort) _then;

/// Create a copy of Sort
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? field = null,Object? sortDirection = null,}) {
  return _then(_Sort(
field: null == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as Field,sortDirection: null == sortDirection ? _self.sortDirection : sortDirection // ignore: cast_nullable_to_non_nullable
as SortDirection,
  ));
}


}

// dart format on
