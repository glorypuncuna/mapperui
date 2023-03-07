import 'package:json_annotation/json_annotation.dart';

import 'data.dart';
import 'meta.dart';
part 'res.g.dart';

@JsonSerializable(explicitToJson: true)
class Res {
  Meta meta;
  Data data;
  Res(this.meta, this.data);

  factory Res.fromJson(Map<String, dynamic> json) => _$ResFromJson(json);
  Map<String, dynamic> toJson() => _$ResToJson(this);
}
