import 'package:aps_5p/models/location/location_model.dart';
import 'package:aps_5p/models/trends/trends_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tendencia_model.g.dart';

@JsonSerializable()
class Tendencia {
  List<Trend> trends;
  List<Location> locations;

  Tendencia({this.trends, this.locations});

  Tendencia.padrao();

  factory Tendencia.fromJson(Map<String, dynamic> json) =>
      _$TendenciaFromJson(json);

  Map<String, dynamic> toJson() => _$TendenciaToJson(this);
}
