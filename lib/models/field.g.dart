// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Field _$FieldFromJson(Map<String, dynamic> json) => Field(
      json['id'] as int,
      json['label'] as String,
      json['length'] as int,
      json['value'] as String,
    );

Map<String, dynamic> _$FieldToJson(Field instance) => <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'length': instance.length,
      'value': instance.value,
    };
