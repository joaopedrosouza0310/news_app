import 'package:news_app/core/domain/entities/article.dart';
import 'package:news_app/features/news/data/models/article_model.dart';

extension ArticleModelMapper on ArticleModel {
  Article toEntity() => Article(
    title: title,
    url: url,
    imageUrl: urlToImage,
    description: description,
    source: source,
    publishedAt: publishedAt,
  );
}
