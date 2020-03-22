// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'twitter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Twitter _$TwitterFromJson(Map<String, dynamic> json) {
  return Twitter(
    statuses: (json['statuses'] as List)
        ?.map((e) =>
            e == null ? null : Statuses.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    searchMetadata: json['searchMetadata'] == null
        ? null
        : SearchMetadata.fromJson(
            json['searchMetadata'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TwitterToJson(Twitter instance) => <String, dynamic>{
      'statuses': instance.statuses,
      'searchMetadata': instance.searchMetadata,
    };
