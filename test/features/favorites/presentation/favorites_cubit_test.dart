import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/core/domain/entities/article.dart';
import 'package:news_app/core/errors/app_failure.dart';
import 'package:news_app/core/result/result.dart';
import 'package:news_app/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:news_app/features/favorites/domain/use_cases/load_favorites.dart';
import 'package:news_app/features/favorites/domain/use_cases/toggle_favorite.dart';
import 'package:news_app/features/favorites/presentation/cubit/favorites_cubit.dart';

void main() {
  const article = Article(title: 'Story', url: 'https://example.com/story');

  test('loads and toggles favorites through use cases', () async {
    final repository = _FakeFavoritesRepository([article]);
    final cubit = FavoritesCubit(
      LoadFavorites(repository),
      ToggleFavorite(repository),
    );

    await cubit.loadFavorites();
    expect(cubit.isFavorite(article.url), isTrue);

    await cubit.toggleFavorite(article);
    expect(cubit.state.favorites, isEmpty);
    expect(cubit.state.isUpdating, isFalse);
    await cubit.close();
  });
}

class _FakeFavoritesRepository implements FavoritesRepository {
  _FakeFavoritesRepository(this.values);

  List<Article> values;

  @override
  Future<Result<List<Article>, AppFailure>> loadFavorites() async =>
      Result.data([...values]);

  @override
  Future<Result<List<Article>, AppFailure>> toggleFavorite(
    Article article,
  ) async {
    values = values.any((item) => item.url == article.url) ? [] : [article];
    return Result.data([...values]);
  }
}
