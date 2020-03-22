import 'package:aps_5p/models/url/url_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'entities_model.g.dart';

@JsonSerializable()
class Entities {
  List<Urls> urls;

  Entities({this.urls});

  Entities.padrao();

  factory Entities.fromJson(Map<String, dynamic> json) =>
      _$EntitiesFromJson(json);

  Map<String, dynamic> toJson() => _$EntitiesToJson(this);
}
