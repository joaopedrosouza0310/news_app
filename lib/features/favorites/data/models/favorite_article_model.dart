import 'package:json_annotation/json_annotation.dart';

part 'favorite_article_model.g.dart';

@JsonSerializable()
class FavoriteArticleModel {
  const FavoriteArticleModel({
    required this.title,
    required this.url,
    this.imageUrl,
    this.description,
    this.source,
    this.publishedAt,
  });

  final String title;
  final String url;
  @JsonKey(readValue: _readImageUrl)
  final String? imageUrl;
  final String? description;
  final String? source;
  final DateTime? publishedAt;

  factory FavoriteArticleModel.fromJson(Map<String, dynamic> json) =>
      _$FavoriteArticleModelFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteArticleModelToJson(this);
}

Object? _readImageUrl(Map<dynamic, dynamic> json, String key) {
  return json[key] ?? json['urlToImage'];
}
