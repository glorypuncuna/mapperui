import 'package:json_annotation/json_annotation.dart';
part 'meta.g.dart';

@JsonSerializable(explicitToJson: true)
class Meta {
  String message;
  int code;
  String status;
  Meta(this.message, this.code, this.status);

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
  Map<String, dynamic> toJson() => _$MetaToJson(this);
}
