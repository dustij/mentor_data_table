// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'table_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TableState {

 List<MentorSession> get data; List<Filter> get filters; List<Sort> get sorts; String get searchTerm; bool get isFilterMenuOpen;
/// Create a copy of TableState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TableStateCopyWith<TableState> get copyWith => _$TableStateCopyWithImpl<TableState>(this as TableState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TableState&&const DeepCollectionEquality().equals(other.data, data)&&const DeepCollectionEquality().equals(other.filters, filters)&&const DeepCollectionEquality().equals(other.sorts, sorts)&&(identical(other.searchTerm, searchTerm) || other.searchTerm == searchTerm)&&(identical(other.isFilterMenuOpen, isFilterMenuOpen) || other.isFilterMenuOpen == isFilterMenuOpen));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data),const DeepCollectionEquality().hash(filters),const DeepCollectionEquality().hash(sorts),searchTerm,isFilterMenuOpen);

@override
String toString() {
  return 'TableState(data: $data, filters: $filters, sorts: $sorts, searchTerm: $searchTerm, isFilterMenuOpen: $isFilterMenuOpen)';
}


}

/// @nodoc
abstract mixin class $TableStateCopyWith<$Res>  {
  factory $TableStateCopyWith(TableState value, $Res Function(TableState) _then) = _$TableStateCopyWithImpl;
@useResult
$Res call({
 List<MentorSession> data, List<Filter> filters, List<Sort> sorts, String searchTerm, bool isFilterMenuOpen
});




}
/// @nodoc
class _$TableStateCopyWithImpl<$Res>
    implements $TableStateCopyWith<$Res> {
  _$TableStateCopyWithImpl(this._self, this._then);

  final TableState _self;
  final $Res Function(TableState) _then;

/// Create a copy of TableState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,Object? filters = null,Object? sorts = null,Object? searchTerm = null,Object? isFilterMenuOpen = null,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as List<MentorSession>,filters: null == filters ? _self.filters : filters // ignore: cast_nullable_to_non_nullable
as List<Filter>,sorts: null == sorts ? _self.sorts : sorts // ignore: cast_nullable_to_non_nullable
as List<Sort>,searchTerm: null == searchTerm ? _self.searchTerm : searchTerm // ignore: cast_nullable_to_non_nullable
as String,isFilterMenuOpen: null == isFilterMenuOpen ? _self.isFilterMenuOpen : isFilterMenuOpen // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TableState].
extension TableStatePatterns on TableState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TableState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TableState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TableState value)  $default,){
final _that = this;
switch (_that) {
case _TableState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TableState value)?  $default,){
final _that = this;
switch (_that) {
case _TableState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<MentorSession> data,  List<Filter> filters,  List<Sort> sorts,  String searchTerm,  bool isFilterMenuOpen)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TableState() when $default != null:
return $default(_that.data,_that.filters,_that.sorts,_that.searchTerm,_that.isFilterMenuOpen);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<MentorSession> data,  List<Filter> filters,  List<Sort> sorts,  String searchTerm,  bool isFilterMenuOpen)  $default,) {final _that = this;
switch (_that) {
case _TableState():
return $default(_that.data,_that.filters,_that.sorts,_that.searchTerm,_that.isFilterMenuOpen);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<MentorSession> data,  List<Filter> filters,  List<Sort> sorts,  String searchTerm,  bool isFilterMenuOpen)?  $default,) {final _that = this;
switch (_that) {
case _TableState() when $default != null:
return $default(_that.data,_that.filters,_that.sorts,_that.searchTerm,_that.isFilterMenuOpen);case _:
  return null;

}
}

}

/// @nodoc


class _TableState implements TableState {
  const _TableState({final  List<MentorSession> data = const [], final  List<Filter> filters = const [], final  List<Sort> sorts = const [], this.searchTerm = "", this.isFilterMenuOpen = false}): _data = data,_filters = filters,_sorts = sorts;
  

 final  List<MentorSession> _data;
@override@JsonKey() List<MentorSession> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}

 final  List<Filter> _filters;
@override@JsonKey() List<Filter> get filters {
  if (_filters is EqualUnmodifiableListView) return _filters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filters);
}

 final  List<Sort> _sorts;
@override@JsonKey() List<Sort> get sorts {
  if (_sorts is EqualUnmodifiableListView) return _sorts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sorts);
}

@override@JsonKey() final  String searchTerm;
@override@JsonKey() final  bool isFilterMenuOpen;

/// Create a copy of TableState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TableStateCopyWith<_TableState> get copyWith => __$TableStateCopyWithImpl<_TableState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TableState&&const DeepCollectionEquality().equals(other._data, _data)&&const DeepCollectionEquality().equals(other._filters, _filters)&&const DeepCollectionEquality().equals(other._sorts, _sorts)&&(identical(other.searchTerm, searchTerm) || other.searchTerm == searchTerm)&&(identical(other.isFilterMenuOpen, isFilterMenuOpen) || other.isFilterMenuOpen == isFilterMenuOpen));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_data),const DeepCollectionEquality().hash(_filters),const DeepCollectionEquality().hash(_sorts),searchTerm,isFilterMenuOpen);

@override
String toString() {
  return 'TableState(data: $data, filters: $filters, sorts: $sorts, searchTerm: $searchTerm, isFilterMenuOpen: $isFilterMenuOpen)';
}


}

/// @nodoc
abstract mixin class _$TableStateCopyWith<$Res> implements $TableStateCopyWith<$Res> {
  factory _$TableStateCopyWith(_TableState value, $Res Function(_TableState) _then) = __$TableStateCopyWithImpl;
@override @useResult
$Res call({
 List<MentorSession> data, List<Filter> filters, List<Sort> sorts, String searchTerm, bool isFilterMenuOpen
});




}
/// @nodoc
class __$TableStateCopyWithImpl<$Res>
    implements _$TableStateCopyWith<$Res> {
  __$TableStateCopyWithImpl(this._self, this._then);

  final _TableState _self;
  final $Res Function(_TableState) _then;

/// Create a copy of TableState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,Object? filters = null,Object? sorts = null,Object? searchTerm = null,Object? isFilterMenuOpen = null,}) {
  return _then(_TableState(
data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<MentorSession>,filters: null == filters ? _self._filters : filters // ignore: cast_nullable_to_non_nullable
as List<Filter>,sorts: null == sorts ? _self._sorts : sorts // ignore: cast_nullable_to_non_nullable
as List<Sort>,searchTerm: null == searchTerm ? _self.searchTerm : searchTerm // ignore: cast_nullable_to_non_nullable
as String,isFilterMenuOpen: null == isFilterMenuOpen ? _self.isFilterMenuOpen : isFilterMenuOpen // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
