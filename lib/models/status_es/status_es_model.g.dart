// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_es_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Statuses _$StatusesFromJson(Map<String, dynamic> json) {
  return Statuses(
    createdAt: json['created_at'] as String,
    id: json['id'] as int,
    idStr: json['idStr'] as String,
    text: json['text'] as String,
    truncated: json['truncated'] as bool,
    entities: json['entities'] == null
        ? null
        : Entities.fromJson(json['entities'] as Map<String, dynamic>),
    metadata: json['metadata'] == null
        ? null
        : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
    source: json['source'] as String,
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    isQuoteStatus: json['isQuoteStatus'] as bool,
    retweetCount: json['retweetCount'] as int,
    favoriteCount: json['favoriteCount'] as int,
    favorited: json['favorited'] as bool,
    retweeted: json['retweeted'] as bool,
    lang: json['lang'] as String,
  );
}

Map<String, dynamic> _$StatusesToJson(Statuses instance) => <String, dynamic>{
      'createdAt': instance.createdAt,
      'id': instance.id,
      'idStr': instance.idStr,
      'text': instance.text,
      'truncated': instance.truncated,
      'entities': instance.entities,
      'metadata': instance.metadata,
      'source': instance.source,
      'user': instance.user,
      'isQuoteStatus': instance.isQuoteStatus,
      'retweetCount': instance.retweetCount,
      'favoriteCount': instance.favoriteCount,
      'favorited': instance.favorited,
      'retweeted': instance.retweeted,
      'lang': instance.lang,
    };
