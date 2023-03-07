import 'package:json_annotation/json_annotation.dart';

import 'bitmap.dart';
import 'field.dart';
import 'mtiMess.dart';
part 'data.g.dart';

@JsonSerializable(explicitToJson: true)
class Data {
  String header;
  String mti;
  MtiMess mtiMess;
  Bitmap bitmap;
  List<Field> dataElement;
  Data(this.header, this.mti, this.mtiMess, this.bitmap, this.dataElement);
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}
