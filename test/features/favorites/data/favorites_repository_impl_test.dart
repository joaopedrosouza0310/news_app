import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/core/domain/entities/article.dart';
import 'package:news_app/core/errors/app_failure.dart';
import 'package:news_app/core/result/result.dart';
import 'package:news_app/features/favorites/data/datasources/favorites_local_datasource.dart';
import 'package:news_app/features/favorites/data/models/favorite_article_model.dart';
import 'package:news_app/features/favorites/data/repositories/favorites_repository_impl.dart';

void main() {
  const article = Article(
    title: 'Saved story',
    url: 'https://example.com/saved',
    source: 'Example',
  );

  test('adds and removes a favorite through the local datasource', () async {
    final datasource = _MemoryFavoritesDatasource();
    final repository = FavoritesRepositoryImpl(datasource);

    final added = await repository.toggleFavorite(article);
    final removed = await repository.toggleFavorite(article);

    expect(
      added.when(data: (items) => items.single.url, error: (_) => null),
      article.url,
    );
    expect(
      removed.when(data: (items) => items, error: (_) => [article]),
      isEmpty,
    );
    expect(datasource.savedValues, hasLength(2));
  });
}

class _MemoryFavoritesDatasource implements FavoritesLocalDatasource {
  List<FavoriteArticleModel> values = [];
  final savedValues = <List<FavoriteArticleModel>>[];

  @override
  Future<Result<List<FavoriteArticleModel>, AppFailure>>
  loadFavorites() async => Result.data([...values]);

  @override
  Future<Result<void, AppFailure>> saveFavorites(
    List<FavoriteArticleModel> favorites,
  ) async {
    values = [...favorites];
    savedValues.add([...favorites]);
    return Result.data(null);
  }
}
