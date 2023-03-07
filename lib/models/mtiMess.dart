import 'package:json_annotation/json_annotation.dart';
part 'mtiMess.g.dart';

@JsonSerializable(explicitToJson: true)
class MtiMess {
  String isoVersion;
  String messageClass;
  String messageFunction;
  String messageOrigin;
  MtiMess(this.isoVersion, this.messageClass, this.messageFunction,
      this.messageOrigin);
  factory MtiMess.fromJson(Map<String, dynamic> json) =>
      _$MtiMessFromJson(json);
  Map<String, dynamic> toJson() => _$MtiMessToJson(this);
}
