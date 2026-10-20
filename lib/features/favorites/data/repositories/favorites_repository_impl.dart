import 'package:injectable/injectable.dart';
import 'package:news_app/core/domain/entities/article.dart';
import 'package:news_app/core/errors/app_failure.dart';
import 'package:news_app/core/result/result.dart';
import 'package:news_app/features/favorites/data/datasources/favorites_local_datasource.dart';
import 'package:news_app/features/favorites/data/mappers/favorite_article_mapper.dart';
import 'package:news_app/features/favorites/domain/repositories/favorites_repository.dart';

@LazySingleton(as: FavoritesRepository)
class FavoritesRepositoryImpl implements FavoritesRepository {
  FavoritesRepositoryImpl(this._datasource);

  final FavoritesLocalDatasource _datasource;

  @override
  Future<Result<List<Article>, AppFailure>> loadFavorites() async {
    final result = await _datasource.loadFavorites();
    return result.when(
      data: (models) => Result.data(
        models.map((model) => model.toEntity()).toList(growable: false),
      ),
      error: Result.error,
    );
  }

  @override
  Future<Result<List<Article>, AppFailure>> toggleFavorite(
    Article article,
  ) async {
    final loaded = await loadFavorites();
    return loaded.when(
      data: (current) async {
        final updated = [...current];
        final index = updated.indexWhere((item) => item.url == article.url);
        index >= 0 ? updated.removeAt(index) : updated.insert(0, article);

        final saved = await _datasource.saveFavorites(
          updated.map((item) => item.toFavoriteModel()).toList(growable: false),
        );
        return saved.when(
          data: (_) => Result.data(updated),
          error: Result.error,
        );
      },
      error: (failure) async => Result.error(failure),
    );
  }
}
