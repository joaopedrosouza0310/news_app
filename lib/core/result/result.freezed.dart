// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Result<T,E> {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Result<T, E>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Result<$T, $E>()';
}


}

/// @nodoc
class $ResultCopyWith<T,E,$Res>  {
$ResultCopyWith(Result<T, E> _, $Res Function(Result<T, E>) __);
}


/// Adds pattern-matching-related methods to [Result].
extension ResultPatterns<T,E> on Result<T, E> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ResultData<T, E> value)?  data,TResult Function( ResponseError<T, E> value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ResultData() when data != null:
return data(_that);case ResponseError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ResultData<T, E> value)  data,required TResult Function( ResponseError<T, E> value)  error,}){
final _that = this;
switch (_that) {
case ResultData():
return data(_that);case ResponseError():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ResultData<T, E> value)?  data,TResult? Function( ResponseError<T, E> value)?  error,}){
final _that = this;
switch (_that) {
case ResultData() when data != null:
return data(_that);case ResponseError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( T value)?  data,TResult Function( E error)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ResultData() when data != null:
return data(_that.value);case ResponseError() when error != null:
return error(_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( T value)  data,required TResult Function( E error)  error,}) {final _that = this;
switch (_that) {
case ResultData():
return data(_that.value);case ResponseError():
return error(_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( T value)?  data,TResult? Function( E error)?  error,}) {final _that = this;
switch (_that) {
case ResultData() when data != null:
return data(_that.value);case ResponseError() when error != null:
return error(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class ResultData<T,E> implements Result<T, E> {
   ResultData(this.value);


 final  T value;

/// Create a copy of Result
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResultDataCopyWith<T, E, ResultData<T, E>> get copyWith => _$ResultDataCopyWithImpl<T, E, ResultData<T, E>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResultData<T, E>&&const DeepCollectionEquality().equals(other.value, value));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(value));

@override
String toString() {
  return 'Result<$T, $E>.data(value: $value)';
}


}

/// @nodoc
abstract mixin class $ResultDataCopyWith<T,E,$Res> implements $ResultCopyWith<T, E, $Res> {
  factory $ResultDataCopyWith(ResultData<T, E> value, $Res Function(ResultData<T, E>) _then) = _$ResultDataCopyWithImpl;
@useResult
$Res call({
 T value
});




}
/// @nodoc
class _$ResultDataCopyWithImpl<T,E,$Res>
    implements $ResultDataCopyWith<T, E, $Res> {
  _$ResultDataCopyWithImpl(this._self, this._then);

  final ResultData<T, E> _self;
  final $Res Function(ResultData<T, E>) _then;

/// Create a copy of Result
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = freezed,}) {
  return _then(ResultData<T, E>(
freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as T,
  ));
}


}

/// @nodoc


class ResponseError<T,E> implements Result<T, E> {
   ResponseError(this.error);


 final  E error;

/// Create a copy of Result
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResponseErrorCopyWith<T, E, ResponseError<T, E>> get copyWith => _$ResponseErrorCopyWithImpl<T, E, ResponseError<T, E>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResponseError<T, E>&&const DeepCollectionEquality().equals(other.error, error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(error));

@override
String toString() {
  return 'Result<$T, $E>.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $ResponseErrorCopyWith<T,E,$Res> implements $ResultCopyWith<T, E, $Res> {
  factory $ResponseErrorCopyWith(ResponseError<T, E> value, $Res Function(ResponseError<T, E>) _then) = _$ResponseErrorCopyWithImpl;
@useResult
$Res call({
 E error
});




}
/// @nodoc
class _$ResponseErrorCopyWithImpl<T,E,$Res>
    implements $ResponseErrorCopyWith<T, E, $Res> {
  _$ResponseErrorCopyWithImpl(this._self, this._then);

  final ResponseError<T, E> _self;
  final $Res Function(ResponseError<T, E>) _then;

/// Create a copy of Result
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = freezed,}) {
  return _then(ResponseError<T, E>(
freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as E,
  ));
}


}

// dart format on
