// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bovine.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BovineImpl _$$BovineImplFromJson(Map<String, dynamic> json) => _$BovineImpl(
      id: json['id'] as String?,
      status: json['status'] as String,
      gender: json['gender'] as String,
      breed: json['breed'] as String?,
      herd: json['herd'] == null
          ? null
          : Herd.fromJson(json['herd'] as Map<String, dynamic>),
      weight: json['weight'] as num?,
      birth: DateTime.parse(json['birth'] as String),
      dad: json['dad'] == null
          ? null
          : Bovine.fromJson(json['dad'] as Map<String, dynamic>),
      mom: json['mom'] == null
          ? null
          : Bovine.fromJson(json['mom'] as Map<String, dynamic>),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$BovineImplToJson(_$BovineImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'gender': instance.gender,
      'breed': instance.breed,
      'herd': instance.herd,
      'weight': instance.weight,
      'birth': instance.birth.toIso8601String(),
      'dad': instance.dad,
      'mom': instance.mom,
      'description': instance.description,
    };
