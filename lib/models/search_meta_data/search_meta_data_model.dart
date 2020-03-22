import 'package:json_annotation/json_annotation.dart';

part 'search_meta_data_model.g.dart';

@JsonSerializable()
class SearchMetadata {
  double completedIn;
  int maxId;
  String maxIdStr;
  String nextResults;
  String query;
  String refreshUrl;
  int count;
  int sinceId;
  String sinceIdStr;

  SearchMetadata(
      {this.completedIn,
      this.maxId,
      this.maxIdStr,
      this.nextResults,
      this.query,
      this.refreshUrl,
      this.count,
      this.sinceId,
      this.sinceIdStr});

  SearchMetadata.padrao();

  factory SearchMetadata.fromJson(Map<String, dynamic> json) =>
      _$SearchMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$SearchMetadataToJson(this);
}
