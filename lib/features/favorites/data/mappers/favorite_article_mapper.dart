import 'package:news_app/core/domain/entities/article.dart';
import 'package:news_app/features/favorites/data/models/favorite_article_model.dart';

extension FavoriteArticleModelMapper on FavoriteArticleModel {
  Article toEntity() => Article(
    title: title,
    url: url,
    imageUrl: imageUrl,
    description: description,
    source: source,
    publishedAt: publishedAt,
  );
}

extension ArticleFavoriteMapper on Article {
  FavoriteArticleModel toFavoriteModel() => FavoriteArticleModel(
    title: title,
    url: url,
    imageUrl: imageUrl,
    description: description,
    source: source,
    publishedAt: publishedAt,
  );
}
