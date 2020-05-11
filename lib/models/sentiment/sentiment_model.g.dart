// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sentiment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sentiment _$SentimentFromJson(Map<String, dynamic> json) {
  return Sentiment(
    score: json['score'] as double,
    label: json['label'] as String,
  );
}

Map<String, dynamic> _$SentimentToJson(Sentiment instance) => <String, dynamic>{
      'score': instance.score,
      'label': instance.label,
    };
