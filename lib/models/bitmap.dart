import 'package:json_annotation/json_annotation.dart';

part 'bitmap.g.dart';

@JsonSerializable(explicitToJson: true)
class Bitmap {
  List<int> field;
  String bit;
  Bitmap(this.field, this.bit);
  factory Bitmap.fromJson(Map<String, dynamic> json) => _$BitmapFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$BitmapToJson(this);
}
