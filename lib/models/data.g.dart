// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      json['header'] as String,
      json['mti'] as String,
      MtiMess.fromJson(json['mtiMess'] as Map<String, dynamic>),
      Bitmap.fromJson(json['bitmap'] as Map<String, dynamic>),
      (json['dataElement'] as List<dynamic>)
          .map((e) => Field.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'header': instance.header,
      'mti': instance.mti,
      'mtiMess': instance.mtiMess.toJson(),
      'bitmap': instance.bitmap.toJson(),
      'dataElement': instance.dataElement.map((e) => e.toJson()).toList(),
    };
