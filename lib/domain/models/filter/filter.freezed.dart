// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Filter implements DiagnosticableTreeMixin {

 Field get field; FilterOperator get filterOperator; String get filterText;
/// Create a copy of Filter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FilterCopyWith<Filter> get copyWith => _$FilterCopyWithImpl<Filter>(this as Filter, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Filter'))
    ..add(DiagnosticsProperty('field', field))..add(DiagnosticsProperty('filterOperator', filterOperator))..add(DiagnosticsProperty('filterText', filterText));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Filter&&(identical(other.field, field) || other.field == field)&&(identical(other.filterOperator, filterOperator) || other.filterOperator == filterOperator)&&(identical(other.filterText, filterText) || other.filterText == filterText));
}


@override
int get hashCode => Object.hash(runtimeType,field,filterOperator,filterText);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Filter(field: $field, filterOperator: $filterOperator, filterText: $filterText)';
}


}

/// @nodoc
abstract mixin class $FilterCopyWith<$Res>  {
  factory $FilterCopyWith(Filter value, $Res Function(Filter) _then) = _$FilterCopyWithImpl;
@useResult
$Res call({
 Field field, FilterOperator filterOperator, String filterText
});




}
/// @nodoc
class _$FilterCopyWithImpl<$Res>
    implements $FilterCopyWith<$Res> {
  _$FilterCopyWithImpl(this._self, this._then);

  final Filter _self;
  final $Res Function(Filter) _then;

/// Create a copy of Filter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? field = null,Object? filterOperator = null,Object? filterText = null,}) {
  return _then(_self.copyWith(
field: null == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as Field,filterOperator: null == filterOperator ? _self.filterOperator : filterOperator // ignore: cast_nullable_to_non_nullable
as FilterOperator,filterText: null == filterText ? _self.filterText : filterText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Filter].
extension FilterPatterns on Filter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Filter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Filter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Filter value)  $default,){
final _that = this;
switch (_that) {
case _Filter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Filter value)?  $default,){
final _that = this;
switch (_that) {
case _Filter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Field field,  FilterOperator filterOperator,  String filterText)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Filter() when $default != null:
return $default(_that.field,_that.filterOperator,_that.filterText);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Field field,  FilterOperator filterOperator,  String filterText)  $default,) {final _that = this;
switch (_that) {
case _Filter():
return $default(_that.field,_that.filterOperator,_that.filterText);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Field field,  FilterOperator filterOperator,  String filterText)?  $default,) {final _that = this;
switch (_that) {
case _Filter() when $default != null:
return $default(_that.field,_that.filterOperator,_that.filterText);case _:
  return null;

}
}

}

/// @nodoc


class _Filter with DiagnosticableTreeMixin implements Filter {
  const _Filter({required this.field, required this.filterOperator, required this.filterText});
  

@override final  Field field;
@override final  FilterOperator filterOperator;
@override final  String filterText;

/// Create a copy of Filter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FilterCopyWith<_Filter> get copyWith => __$FilterCopyWithImpl<_Filter>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Filter'))
    ..add(DiagnosticsProperty('field', field))..add(DiagnosticsProperty('filterOperator', filterOperator))..add(DiagnosticsProperty('filterText', filterText));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Filter&&(identical(other.field, field) || other.field == field)&&(identical(other.filterOperator, filterOperator) || other.filterOperator == filterOperator)&&(identical(other.filterText, filterText) || other.filterText == filterText));
}


@override
int get hashCode => Object.hash(runtimeType,field,filterOperator,filterText);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Filter(field: $field, filterOperator: $filterOperator, filterText: $filterText)';
}


}

/// @nodoc
abstract mixin class _$FilterCopyWith<$Res> implements $FilterCopyWith<$Res> {
  factory _$FilterCopyWith(_Filter value, $Res Function(_Filter) _then) = __$FilterCopyWithImpl;
@override @useResult
$Res call({
 Field field, FilterOperator filterOperator, String filterText
});




}
/// @nodoc
class __$FilterCopyWithImpl<$Res>
    implements _$FilterCopyWith<$Res> {
  __$FilterCopyWithImpl(this._self, this._then);

  final _Filter _self;
  final $Res Function(_Filter) _then;

/// Create a copy of Filter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? field = null,Object? filterOperator = null,Object? filterText = null,}) {
  return _then(_Filter(
field: null == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as Field,filterOperator: null == filterOperator ? _self.filterOperator : filterOperator // ignore: cast_nullable_to_non_nullable
as FilterOperator,filterText: null == filterText ? _self.filterText : filterText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
