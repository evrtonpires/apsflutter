import 'package:json_annotation/json_annotation.dart';

part 'meta_data_model.g.dart';

@JsonSerializable()
class Metadata {
  String isoLanguageCode;
  String resultType;

  Metadata({this.isoLanguageCode, this.resultType});

  Metadata.padrao();

  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);

  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}
