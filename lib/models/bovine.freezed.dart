// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bovine.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Bovine _$BovineFromJson(Map<String, dynamic> json) {
  return _Bovine.fromJson(json);
}

/// @nodoc
mixin _$Bovine {
  String? get id => throw _privateConstructorUsedError;
  set id(String? value) => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  set name(String? value) => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  set status(String value) => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  set gender(String value) => throw _privateConstructorUsedError;
  String? get breed => throw _privateConstructorUsedError;
  set breed(String? value) => throw _privateConstructorUsedError;
  Herd? get herd => throw _privateConstructorUsedError;
  set herd(Herd? value) => throw _privateConstructorUsedError;
  num? get weight => throw _privateConstructorUsedError;
  set weight(num? value) => throw _privateConstructorUsedError;
  DateTime get birth => throw _privateConstructorUsedError;
  set birth(DateTime value) => throw _privateConstructorUsedError;
  Bovine? get dad => throw _privateConstructorUsedError;
  set dad(Bovine? value) => throw _privateConstructorUsedError;
  Bovine? get mom => throw _privateConstructorUsedError;
  set mom(Bovine? value) => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  set description(String? value) => throw _privateConstructorUsedError;

  /// Serializes this Bovine to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Bovine
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BovineCopyWith<Bovine> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BovineCopyWith<$Res> {
  factory $BovineCopyWith(Bovine value, $Res Function(Bovine) then) =
      _$BovineCopyWithImpl<$Res, Bovine>;
  @useResult
  $Res call(
      {String? id,
      String? name,
      String status,
      String gender,
      String? breed,
      Herd? herd,
      num? weight,
      DateTime birth,
      Bovine? dad,
      Bovine? mom,
      String? description});

  $BovineCopyWith<$Res>? get dad;
  $BovineCopyWith<$Res>? get mom;
}

/// @nodoc
class _$BovineCopyWithImpl<$Res, $Val extends Bovine>
    implements $BovineCopyWith<$Res> {
  _$BovineCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Bovine
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? status = null,
    Object? gender = null,
    Object? breed = freezed,
    Object? herd = freezed,
    Object? weight = freezed,
    Object? birth = null,
    Object? dad = freezed,
    Object? mom = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      breed: freezed == breed
          ? _value.breed
          : breed // ignore: cast_nullable_to_non_nullable
              as String?,
      herd: freezed == herd
          ? _value.herd
          : herd // ignore: cast_nullable_to_non_nullable
              as Herd?,
      weight: freezed == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as num?,
      birth: null == birth
          ? _value.birth
          : birth // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dad: freezed == dad
          ? _value.dad
          : dad // ignore: cast_nullable_to_non_nullable
              as Bovine?,
      mom: freezed == mom
          ? _value.mom
          : mom // ignore: cast_nullable_to_non_nullable
              as Bovine?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of Bovine
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BovineCopyWith<$Res>? get dad {
    if (_value.dad == null) {
      return null;
    }

    return $BovineCopyWith<$Res>(_value.dad!, (value) {
      return _then(_value.copyWith(dad: value) as $Val);
    });
  }

  /// Create a copy of Bovine
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BovineCopyWith<$Res>? get mom {
    if (_value.mom == null) {
      return null;
    }

    return $BovineCopyWith<$Res>(_value.mom!, (value) {
      return _then(_value.copyWith(mom: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BovineImplCopyWith<$Res> implements $BovineCopyWith<$Res> {
  factory _$$BovineImplCopyWith(
          _$BovineImpl value, $Res Function(_$BovineImpl) then) =
      __$$BovineImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? name,
      String status,
      String gender,
      String? breed,
      Herd? herd,
      num? weight,
      DateTime birth,
      Bovine? dad,
      Bovine? mom,
      String? description});

  @override
  $BovineCopyWith<$Res>? get dad;
  @override
  $BovineCopyWith<$Res>? get mom;
}

/// @nodoc
class __$$BovineImplCopyWithImpl<$Res>
    extends _$BovineCopyWithImpl<$Res, _$BovineImpl>
    implements _$$BovineImplCopyWith<$Res> {
  __$$BovineImplCopyWithImpl(
      _$BovineImpl _value, $Res Function(_$BovineImpl) _then)
      : super(_value, _then);

  /// Create a copy of Bovine
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? status = null,
    Object? gender = null,
    Object? breed = freezed,
    Object? herd = freezed,
    Object? weight = freezed,
    Object? birth = null,
    Object? dad = freezed,
    Object? mom = freezed,
    Object? description = freezed,
  }) {
    return _then(_$BovineImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      breed: freezed == breed
          ? _value.breed
          : breed // ignore: cast_nullable_to_non_nullable
              as String?,
      herd: freezed == herd
          ? _value.herd
          : herd // ignore: cast_nullable_to_non_nullable
              as Herd?,
      weight: freezed == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as num?,
      birth: null == birth
          ? _value.birth
          : birth // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dad: freezed == dad
          ? _value.dad
          : dad // ignore: cast_nullable_to_non_nullable
              as Bovine?,
      mom: freezed == mom
          ? _value.mom
          : mom // ignore: cast_nullable_to_non_nullable
              as Bovine?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BovineImpl implements _Bovine {
  _$BovineImpl(
      {this.id,
      this.name,
      required this.status,
      required this.gender,
      this.breed,
      this.herd,
      this.weight,
      required this.birth,
      this.dad,
      this.mom,
      this.description});

  factory _$BovineImpl.fromJson(Map<String, dynamic> json) =>
      _$$BovineImplFromJson(json);

  @override
  String? id;
  @override
  String? name;
  @override
  String status;
  @override
  String gender;
  @override
  String? breed;
  @override
  Herd? herd;
  @override
  num? weight;
  @override
  DateTime birth;
  @override
  Bovine? dad;
  @override
  Bovine? mom;
  @override
  String? description;

  @override
  String toString() {
    return 'Bovine(id: $id, name: $name, status: $status, gender: $gender, breed: $breed, herd: $herd, weight: $weight, birth: $birth, dad: $dad, mom: $mom, description: $description)';
  }

  /// Create a copy of Bovine
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BovineImplCopyWith<_$BovineImpl> get copyWith =>
      __$$BovineImplCopyWithImpl<_$BovineImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BovineImplToJson(
      this,
    );
  }
}

abstract class _Bovine implements Bovine {
  factory _Bovine(
      {String? id,
      String? name,
      required String status,
      required String gender,
      String? breed,
      Herd? herd,
      num? weight,
      required DateTime birth,
      Bovine? dad,
      Bovine? mom,
      String? description}) = _$BovineImpl;

  factory _Bovine.fromJson(Map<String, dynamic> json) = _$BovineImpl.fromJson;

  @override
  String? get id;
  set id(String? value);
  @override
  String? get name;
  set name(String? value);
  @override
  String get status;
  set status(String value);
  @override
  String get gender;
  set gender(String value);
  @override
  String? get breed;
  set breed(String? value);
  @override
  Herd? get herd;
  set herd(Herd? value);
  @override
  num? get weight;
  set weight(num? value);
  @override
  DateTime get birth;
  set birth(DateTime value);
  @override
  Bovine? get dad;
  set dad(Bovine? value);
  @override
  Bovine? get mom;
  set mom(Bovine? value);
  @override
  String? get description;
  set description(String? value);

  /// Create a copy of Bovine
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BovineImplCopyWith<_$BovineImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
