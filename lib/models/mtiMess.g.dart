// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mtiMess.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MtiMess _$MtiMessFromJson(Map<String, dynamic> json) => MtiMess(
      json['isoVersion'] as String,
      json['messageClass'] as String,
      json['messageFunction'] as String,
      json['messageOrigin'] as String,
    );

Map<String, dynamic> _$MtiMessToJson(MtiMess instance) => <String, dynamic>{
      'isoVersion': instance.isoVersion,
      'messageClass': instance.messageClass,
      'messageFunction': instance.messageFunction,
      'messageOrigin': instance.messageOrigin,
    };
