import 'package:json_annotation/json_annotation.dart';

part 'url_model.g.dart';

@JsonSerializable()
class Urls {
  String url;
  String expandedUrl;
  String displayUrl;
  List<int> indices;

  Urls({this.url, this.expandedUrl, this.displayUrl, this.indices});

  Urls.padrao();

  factory Urls.fromJson(Map<String, dynamic> json) => _$UrlsFromJson(json);

  Map<String, dynamic> toJson() => _$UrlsToJson(this);
}
