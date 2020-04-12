// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trends_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trend _$TrendsFromJson(Map<String, dynamic> json) {
  return Trend(
      name: json['name'] as String,
      url: json['url'] as String,
      query: json['query'] as String,
      tweetVolume: json['tweet_volume'] as int);
}

Map<String, dynamic> _$TrendsToJson(Trend instance) => <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
      'query': instance.query,
      'tweet_volume': instance.tweetVolume,
    };
