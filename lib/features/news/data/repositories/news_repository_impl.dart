import 'package:injectable/injectable.dart';
import 'package:news_app/core/domain/entities/article.dart';
import 'package:news_app/core/errors/app_failure.dart';
import 'package:news_app/core/result/result.dart';
import 'package:news_app/features/news/data/datasources/news_remote_datasource.dart';
import 'package:news_app/features/news/data/mappers/article_mapper.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';

@LazySingleton(as: NewsRepository)
class NewsRepositoryImpl implements NewsRepository {
  NewsRepositoryImpl(this._datasource);

  final NewsRemoteDatasource _datasource;

  @override
  Future<Result<List<Article>, AppFailure>> fetchNews(
    String query, {
    required int page,
  }) async {
    final result = await _datasource.fetchNews(query, page: page);
    return result.when(
      data: (models) => Result.data(
        models.map((model) => model.toEntity()).toList(growable: false),
      ),
      error: Result.error,
    );
  }
}
