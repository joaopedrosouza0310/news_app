import 'package:news_app/core/domain/entities/article.dart';
import 'package:news_app/core/errors/app_failure.dart';
import 'package:news_app/core/result/result.dart';

abstract interface class NewsRepository {
  Future<Result<List<Article>, AppFailure>> fetchNews(
    String query, {
    required int page,
  });
}
