// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'form_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FormState {

 FormEntity? get form; Map<String, dynamic> get values; Map<String, String> get errors; Map<String, bool> get visibility; Map<String, bool> get requiredFlags; Map<String, List<String>> get optionsOverrides; bool get isLoading; String? get loadError; SubmissionPayload? get submissionResult; Set<String> get touchedFields; bool get submittedOnce;
/// Create a copy of FormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormStateCopyWith<FormState> get copyWith => _$FormStateCopyWithImpl<FormState>(this as FormState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormState&&(identical(other.form, form) || other.form == form)&&const DeepCollectionEquality().equals(other.values, values)&&const DeepCollectionEquality().equals(other.errors, errors)&&const DeepCollectionEquality().equals(other.visibility, visibility)&&const DeepCollectionEquality().equals(other.requiredFlags, requiredFlags)&&const DeepCollectionEquality().equals(other.optionsOverrides, optionsOverrides)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.loadError, loadError) || other.loadError == loadError)&&(identical(other.submissionResult, submissionResult) || other.submissionResult == submissionResult)&&const DeepCollectionEquality().equals(other.touchedFields, touchedFields)&&(identical(other.submittedOnce, submittedOnce) || other.submittedOnce == submittedOnce));
}


@override
int get hashCode => Object.hash(runtimeType,form,const DeepCollectionEquality().hash(values),const DeepCollectionEquality().hash(errors),const DeepCollectionEquality().hash(visibility),const DeepCollectionEquality().hash(requiredFlags),const DeepCollectionEquality().hash(optionsOverrides),isLoading,loadError,submissionResult,const DeepCollectionEquality().hash(touchedFields),submittedOnce);

@override
String toString() {
  return 'FormState(form: $form, values: $values, errors: $errors, visibility: $visibility, requiredFlags: $requiredFlags, optionsOverrides: $optionsOverrides, isLoading: $isLoading, loadError: $loadError, submissionResult: $submissionResult, touchedFields: $touchedFields, submittedOnce: $submittedOnce)';
}


}

/// @nodoc
abstract mixin class $FormStateCopyWith<$Res>  {
  factory $FormStateCopyWith(FormState value, $Res Function(FormState) _then) = _$FormStateCopyWithImpl;
@useResult
$Res call({
 FormEntity? form, Map<String, dynamic> values, Map<String, String> errors, Map<String, bool> visibility, Map<String, bool> requiredFlags, Map<String, List<String>> optionsOverrides, bool isLoading, String? loadError, SubmissionPayload? submissionResult, Set<String> touchedFields, bool submittedOnce
});




}
/// @nodoc
class _$FormStateCopyWithImpl<$Res>
    implements $FormStateCopyWith<$Res> {
  _$FormStateCopyWithImpl(this._self, this._then);

  final FormState _self;
  final $Res Function(FormState) _then;

/// Create a copy of FormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? form = freezed,Object? values = null,Object? errors = null,Object? visibility = null,Object? requiredFlags = null,Object? optionsOverrides = null,Object? isLoading = null,Object? loadError = freezed,Object? submissionResult = freezed,Object? touchedFields = null,Object? submittedOnce = null,}) {
  return _then(_self.copyWith(
form: freezed == form ? _self.form : form // ignore: cast_nullable_to_non_nullable
as FormEntity?,values: null == values ? _self.values : values // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,errors: null == errors ? _self.errors : errors // ignore: cast_nullable_to_non_nullable
as Map<String, String>,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,requiredFlags: null == requiredFlags ? _self.requiredFlags : requiredFlags // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,optionsOverrides: null == optionsOverrides ? _self.optionsOverrides : optionsOverrides // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,loadError: freezed == loadError ? _self.loadError : loadError // ignore: cast_nullable_to_non_nullable
as String?,submissionResult: freezed == submissionResult ? _self.submissionResult : submissionResult // ignore: cast_nullable_to_non_nullable
as SubmissionPayload?,touchedFields: null == touchedFields ? _self.touchedFields : touchedFields // ignore: cast_nullable_to_non_nullable
as Set<String>,submittedOnce: null == submittedOnce ? _self.submittedOnce : submittedOnce // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [FormState].
extension FormStatePatterns on FormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FormState value)  $default,){
final _that = this;
switch (_that) {
case _FormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FormState value)?  $default,){
final _that = this;
switch (_that) {
case _FormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( FormEntity? form,  Map<String, dynamic> values,  Map<String, String> errors,  Map<String, bool> visibility,  Map<String, bool> requiredFlags,  Map<String, List<String>> optionsOverrides,  bool isLoading,  String? loadError,  SubmissionPayload? submissionResult,  Set<String> touchedFields,  bool submittedOnce)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FormState() when $default != null:
return $default(_that.form,_that.values,_that.errors,_that.visibility,_that.requiredFlags,_that.optionsOverrides,_that.isLoading,_that.loadError,_that.submissionResult,_that.touchedFields,_that.submittedOnce);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( FormEntity? form,  Map<String, dynamic> values,  Map<String, String> errors,  Map<String, bool> visibility,  Map<String, bool> requiredFlags,  Map<String, List<String>> optionsOverrides,  bool isLoading,  String? loadError,  SubmissionPayload? submissionResult,  Set<String> touchedFields,  bool submittedOnce)  $default,) {final _that = this;
switch (_that) {
case _FormState():
return $default(_that.form,_that.values,_that.errors,_that.visibility,_that.requiredFlags,_that.optionsOverrides,_that.isLoading,_that.loadError,_that.submissionResult,_that.touchedFields,_that.submittedOnce);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( FormEntity? form,  Map<String, dynamic> values,  Map<String, String> errors,  Map<String, bool> visibility,  Map<String, bool> requiredFlags,  Map<String, List<String>> optionsOverrides,  bool isLoading,  String? loadError,  SubmissionPayload? submissionResult,  Set<String> touchedFields,  bool submittedOnce)?  $default,) {final _that = this;
switch (_that) {
case _FormState() when $default != null:
return $default(_that.form,_that.values,_that.errors,_that.visibility,_that.requiredFlags,_that.optionsOverrides,_that.isLoading,_that.loadError,_that.submissionResult,_that.touchedFields,_that.submittedOnce);case _:
  return null;

}
}

}

/// @nodoc


class _FormState extends FormState {
  const _FormState({this.form, final  Map<String, dynamic> values = const <String, dynamic>{}, final  Map<String, String> errors = const <String, String>{}, final  Map<String, bool> visibility = const <String, bool>{}, final  Map<String, bool> requiredFlags = const <String, bool>{}, final  Map<String, List<String>> optionsOverrides = const <String, List<String>>{}, this.isLoading = false, this.loadError, this.submissionResult, final  Set<String> touchedFields = const <String>{}, this.submittedOnce = false}): _values = values,_errors = errors,_visibility = visibility,_requiredFlags = requiredFlags,_optionsOverrides = optionsOverrides,_touchedFields = touchedFields,super._();
  

@override final  FormEntity? form;
 final  Map<String, dynamic> _values;
@override@JsonKey() Map<String, dynamic> get values {
  if (_values is EqualUnmodifiableMapView) return _values;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_values);
}

 final  Map<String, String> _errors;
@override@JsonKey() Map<String, String> get errors {
  if (_errors is EqualUnmodifiableMapView) return _errors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_errors);
}

 final  Map<String, bool> _visibility;
@override@JsonKey() Map<String, bool> get visibility {
  if (_visibility is EqualUnmodifiableMapView) return _visibility;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_visibility);
}

 final  Map<String, bool> _requiredFlags;
@override@JsonKey() Map<String, bool> get requiredFlags {
  if (_requiredFlags is EqualUnmodifiableMapView) return _requiredFlags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_requiredFlags);
}

 final  Map<String, List<String>> _optionsOverrides;
@override@JsonKey() Map<String, List<String>> get optionsOverrides {
  if (_optionsOverrides is EqualUnmodifiableMapView) return _optionsOverrides;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_optionsOverrides);
}

@override@JsonKey() final  bool isLoading;
@override final  String? loadError;
@override final  SubmissionPayload? submissionResult;
 final  Set<String> _touchedFields;
@override@JsonKey() Set<String> get touchedFields {
  if (_touchedFields is EqualUnmodifiableSetView) return _touchedFields;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_touchedFields);
}

@override@JsonKey() final  bool submittedOnce;

/// Create a copy of FormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FormStateCopyWith<_FormState> get copyWith => __$FormStateCopyWithImpl<_FormState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FormState&&(identical(other.form, form) || other.form == form)&&const DeepCollectionEquality().equals(other._values, _values)&&const DeepCollectionEquality().equals(other._errors, _errors)&&const DeepCollectionEquality().equals(other._visibility, _visibility)&&const DeepCollectionEquality().equals(other._requiredFlags, _requiredFlags)&&const DeepCollectionEquality().equals(other._optionsOverrides, _optionsOverrides)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.loadError, loadError) || other.loadError == loadError)&&(identical(other.submissionResult, submissionResult) || other.submissionResult == submissionResult)&&const DeepCollectionEquality().equals(other._touchedFields, _touchedFields)&&(identical(other.submittedOnce, submittedOnce) || other.submittedOnce == submittedOnce));
}


@override
int get hashCode => Object.hash(runtimeType,form,const DeepCollectionEquality().hash(_values),const DeepCollectionEquality().hash(_errors),const DeepCollectionEquality().hash(_visibility),const DeepCollectionEquality().hash(_requiredFlags),const DeepCollectionEquality().hash(_optionsOverrides),isLoading,loadError,submissionResult,const DeepCollectionEquality().hash(_touchedFields),submittedOnce);

@override
String toString() {
  return 'FormState(form: $form, values: $values, errors: $errors, visibility: $visibility, requiredFlags: $requiredFlags, optionsOverrides: $optionsOverrides, isLoading: $isLoading, loadError: $loadError, submissionResult: $submissionResult, touchedFields: $touchedFields, submittedOnce: $submittedOnce)';
}


}

/// @nodoc
abstract mixin class _$FormStateCopyWith<$Res> implements $FormStateCopyWith<$Res> {
  factory _$FormStateCopyWith(_FormState value, $Res Function(_FormState) _then) = __$FormStateCopyWithImpl;
@override @useResult
$Res call({
 FormEntity? form, Map<String, dynamic> values, Map<String, String> errors, Map<String, bool> visibility, Map<String, bool> requiredFlags, Map<String, List<String>> optionsOverrides, bool isLoading, String? loadError, SubmissionPayload? submissionResult, Set<String> touchedFields, bool submittedOnce
});




}
/// @nodoc
class __$FormStateCopyWithImpl<$Res>
    implements _$FormStateCopyWith<$Res> {
  __$FormStateCopyWithImpl(this._self, this._then);

  final _FormState _self;
  final $Res Function(_FormState) _then;

/// Create a copy of FormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? form = freezed,Object? values = null,Object? errors = null,Object? visibility = null,Object? requiredFlags = null,Object? optionsOverrides = null,Object? isLoading = null,Object? loadError = freezed,Object? submissionResult = freezed,Object? touchedFields = null,Object? submittedOnce = null,}) {
  return _then(_FormState(
form: freezed == form ? _self.form : form // ignore: cast_nullable_to_non_nullable
as FormEntity?,values: null == values ? _self._values : values // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,errors: null == errors ? _self._errors : errors // ignore: cast_nullable_to_non_nullable
as Map<String, String>,visibility: null == visibility ? _self._visibility : visibility // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,requiredFlags: null == requiredFlags ? _self._requiredFlags : requiredFlags // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,optionsOverrides: null == optionsOverrides ? _self._optionsOverrides : optionsOverrides // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,loadError: freezed == loadError ? _self.loadError : loadError // ignore: cast_nullable_to_non_nullable
as String?,submissionResult: freezed == submissionResult ? _self.submissionResult : submissionResult // ignore: cast_nullable_to_non_nullable
as SubmissionPayload?,touchedFields: null == touchedFields ? _self._touchedFields : touchedFields // ignore: cast_nullable_to_non_nullable
as Set<String>,submittedOnce: null == submittedOnce ? _self.submittedOnce : submittedOnce // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
