import 'package:json_annotation/json_annotation.dart';
part 'field.g.dart';

@JsonSerializable(explicitToJson: true)
class Field {
  int id;
  String label;
  int length;
  String value;
  Field(this.id, this.label, this.length, this.value);
  factory Field.fromJson(Map<String, dynamic> json) => _$FieldFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$FieldToJson`.
  Map<String, dynamic> toJson() => _$FieldToJson(this);
}
