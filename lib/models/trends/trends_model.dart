import 'package:aps_5p/models/search_meta_data/search_meta_data_model.dart';
import 'package:aps_5p/models/status_es/status_es_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'trends_model.g.dart';

@JsonSerializable()
class Trend {
  String name;
  String url;
  String query;
  int tweetVolume;

  Trend({this.name, this.url, this.query, this.tweetVolume});

  Trend.padrao();

  factory Trend.fromJson(Map<String, dynamic> json) => _$TrendsFromJson(json);

  Map<String, dynamic> toJson() => _$TrendsToJson(this);
}
