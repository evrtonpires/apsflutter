import 'package:aps_5p/models/search_meta_data/search_meta_data_model.dart';
import 'package:aps_5p/models/status_es/status_es_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'twitter_model.g.dart';

@JsonSerializable()
class Twitter {
  List<Statuses> statuses;
  SearchMetadata searchMetadata;

  Twitter({this.statuses, this.searchMetadata});

  Twitter.padrao();

  factory Twitter.fromJson(Map<String, dynamic> json) =>
      _$TwitterFromJson(json);

  Map<String, dynamic> toJson() => _$TwitterToJson(this);
}
