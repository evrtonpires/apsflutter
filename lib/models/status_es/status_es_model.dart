import 'package:aps_5p/models/entities/entities_model.dart';
import 'package:aps_5p/models/meta_data/meta_data_model.dart';
import 'package:aps_5p/models/user/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'status_es_model.g.dart';

@JsonSerializable()
class Statuses {
  String createdAt;
  int id;
  String idStr;
  String text;
  bool truncated;
  Entities entities;
  Metadata metadata;
  String source;
  User user;
  bool isQuoteStatus;
  int retweetCount;
  int favoriteCount;
  bool favorited;
  bool retweeted;
  String lang;

  Statuses(
      {this.createdAt,
      this.id,
      this.idStr,
      this.text,
      this.truncated,
      this.entities,
      this.metadata,
      this.source,
      this.user,
      this.isQuoteStatus,
      this.retweetCount,
      this.favoriteCount,
      this.favorited,
      this.retweeted,
      this.lang});

  Statuses.padrao();

  factory Statuses.fromJson(Map<String, dynamic> json) =>
      _$StatusesFromJson(json);

  Map<String, dynamic> toJson() => _$StatusesToJson(this);
}
