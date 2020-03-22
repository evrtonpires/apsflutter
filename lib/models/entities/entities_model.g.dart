// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entities_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Entities _$EntitiesFromJson(Map<String, dynamic> json) {
  return Entities(
    urls: (json['urls'] as List)
        ?.map(
            (e) => e == null ? null : Urls.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$EntitiesToJson(Entities instance) => <String, dynamic>{
      'urls': instance.urls,
    };
