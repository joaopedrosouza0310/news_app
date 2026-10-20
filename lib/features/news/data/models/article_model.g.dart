// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleModel _$ArticleModelFromJson(Map<String, dynamic> json) => ArticleModel(
  title: json['title'] as String,
  url: json['url'] as String,
  urlToImage: json['urlToImage'] as String?,
  description: json['description'] as String?,
  source: _readSource(json, 'source') as String?,
  publishedAt: json['publishedAt'] == null
      ? null
      : DateTime.parse(json['publishedAt'] as String),
);

Map<String, dynamic> _$ArticleModelToJson(ArticleModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'url': instance.url,
      'urlToImage': instance.urlToImage,
      'description': instance.description,
      'source': instance.source,
      'publishedAt': instance.publishedAt?.toIso8601String(),
    };
