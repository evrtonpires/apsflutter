// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tendencia_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tendencia _$TendenciaFromJson(Map<String, dynamic> json) {
  return Tendencia(
    locations: (json['locations'] as List)
        ?.map((e) =>
            e == null ? null : Location.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    trends: (json['trends'] as List)
        ?.map(
            (e) => e == null ? null : Trend.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TendenciaToJson(Tendencia instance) => <String, dynamic>{
      'trends': instance.trends,
      'locations': instance.locations,
    };
