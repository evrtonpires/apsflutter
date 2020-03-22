// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_meta_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchMetadata _$SearchMetadataFromJson(Map<String, dynamic> json) {
  return SearchMetadata(
    completedIn: (json['completed_in'] as num)?.toDouble(),
    maxId: json['max_id'] as int,
    maxIdStr: json['max_id_str'] as String,
    nextResults: json['next_results'] as String,
    query: json['query'] as String,
    refreshUrl: json['refresh_url'] as String,
    count: json['count'] as int,
    sinceId: json['since_id'] as int,
    sinceIdStr: json['since_id_str'] as String,
  );
}

Map<String, dynamic> _$SearchMetadataToJson(SearchMetadata instance) =>
    <String, dynamic>{
      'completedIn': instance.completedIn,
      'maxId': instance.maxId,
      'maxIdStr': instance.maxIdStr,
      'nextResults': instance.nextResults,
      'query': instance.query,
      'refreshUrl': instance.refreshUrl,
      'count': instance.count,
      'sinceId': instance.sinceId,
      'sinceIdStr': instance.sinceIdStr,
    };
