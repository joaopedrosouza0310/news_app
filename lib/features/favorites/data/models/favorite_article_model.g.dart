// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_article_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteArticleModel _$FavoriteArticleModelFromJson(
  Map<String, dynamic> json,
) => FavoriteArticleModel(
  title: json['title'] as String,
  url: json['url'] as String,
  imageUrl: _readImageUrl(json, 'imageUrl') as String?,
  description: json['description'] as String?,
  source: json['source'] as String?,
  publishedAt: json['publishedAt'] == null
      ? null
      : DateTime.parse(json['publishedAt'] as String),
);

Map<String, dynamic> _$FavoriteArticleModelToJson(
  FavoriteArticleModel instance,
) => <String, dynamic>{
  'title': instance.title,
  'url': instance.url,
  'imageUrl': instance.imageUrl,
  'description': instance.description,
  'source': instance.source,
  'publishedAt': instance.publishedAt?.toIso8601String(),
};
