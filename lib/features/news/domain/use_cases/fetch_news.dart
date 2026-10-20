import 'package:injectable/injectable.dart';
import 'package:news_app/core/domain/entities/article.dart';
import 'package:news_app/core/errors/app_failure.dart';
import 'package:news_app/core/result/result.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';

@injectable
class FetchNews {
  const FetchNews(this._repository);

  final NewsRepository _repository;

  Future<Result<List<Article>, AppFailure>> call(
    String query, {
    required int page,
  }) => _repository.fetchNews(query, page: page);
}
