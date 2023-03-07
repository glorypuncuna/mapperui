// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bitmap.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bitmap _$BitmapFromJson(Map<String, dynamic> json) => Bitmap(
      (json['field'] as List<dynamic>).map((e) => e as int).toList(),
      json['bit'] as String,
    );

Map<String, dynamic> _$BitmapToJson(Bitmap instance) => <String, dynamic>{
      'field': instance.field,
      'bit': instance.bit,
    };
