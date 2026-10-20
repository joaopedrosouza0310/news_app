import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/core/domain/entities/article.dart';
import 'package:news_app/core/errors/app_failure.dart';
import 'package:news_app/core/result/result.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';
import 'package:news_app/features/news/domain/use_cases/fetch_news.dart';
import 'package:news_app/features/news/presentation/cubit/news_cubit.dart';

void main() {
  const article = Article(title: 'Story', url: 'https://example.com/story');

  test('loads news through the use case', () async {
    final repository = _FakeNewsRepository(Result.data([article]));
    final cubit = NewsCubit(FetchNews(repository));

    await cubit.loadNews(query: 'Technology');

    expect(cubit.state.articles, [article]);
    expect(cubit.state.query, 'Technology');
    expect(cubit.state.isLoading, isFalse);
    expect(repository.requestedPages, [1]);
    await cubit.close();
  });

  test('exposes a typed failure and finishes loading', () async {
    const failure = AppFailure(FailureType.network);
    final repository = _FakeNewsRepository(Result.error(failure));
    final cubit = NewsCubit(FetchNews(repository));

    await cubit.loadNews();

    expect(cubit.state.failure, same(failure));
    expect(cubit.state.isLoading, isFalse);
    await cubit.close();
  });
}

class _FakeNewsRepository implements NewsRepository {
  _FakeNewsRepository(this.result);

  final Result<List<Article>, AppFailure> result;
  final requestedPages = <int>[];

  @override
  Future<Result<List<Article>, AppFailure>> fetchNews(
    String query, {
    required int page,
  }) async {
    requestedPages.add(page);
    return result;
  }
}
