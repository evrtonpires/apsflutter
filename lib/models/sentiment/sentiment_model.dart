import 'package:json_annotation/json_annotation.dart';

part 'sentiment_model.g.dart';

@JsonSerializable()
class Sentiment {
  double score;
  String label;

  Sentiment({this.score, this.label});

  Sentiment.padrao();

  factory Sentiment.fromJson(Map<String, dynamic> json) =>
      _$SentimentFromJson(json);

  Map<String, dynamic> toJson() => _$SentimentToJson(this);
}
