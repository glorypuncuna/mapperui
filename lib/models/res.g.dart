// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Res _$ResFromJson(Map<String, dynamic> json) => Res(
      Meta.fromJson(json['meta'] as Map<String, dynamic>),
      Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResToJson(Res instance) => <String, dynamic>{
      'meta': instance.meta.toJson(),
      'data': instance.data.toJson(),
    };
