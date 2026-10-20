import 'package:json_annotation/json_annotation.dart';

part 'article_model.g.dart';

@JsonSerializable()
class ArticleModel {
  const ArticleModel({
    required this.title,
    required this.url,
    this.urlToImage,
    this.description,
    this.source,
    this.publishedAt,
  });

  final String title;
  final String url;
  final String? urlToImage;
  final String? description;
  @JsonKey(readValue: _readSource)
  final String? source;
  final DateTime? publishedAt;

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);
}

Object? _readSource(Map<dynamic, dynamic> json, String key) {
  final source = json[key];
  return source is Map ? source['name'] : source;
}
