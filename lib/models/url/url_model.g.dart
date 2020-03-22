// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'url_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Urls _$UrlsFromJson(Map<String, dynamic> json) {
  return Urls(
    url: json['url'] as String,
    expandedUrl: json['expandedUrl'] as String,
    displayUrl: json['displayUrl'] as String,
    indices: (json['indices'] as List)?.map((e) => e as int)?.toList(),
  );
}

Map<String, dynamic> _$UrlsToJson(Urls instance) => <String, dynamic>{
      'url': instance.url,
      'expandedUrl': instance.expandedUrl,
      'displayUrl': instance.displayUrl,
      'indices': instance.indices,
    };
