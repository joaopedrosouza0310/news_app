import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:news_app/core/errors/app_failure.dart';
import 'package:news_app/core/result/result.dart';
import 'package:news_app/features/favorites/data/models/favorite_article_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class FavoritesLocalDatasource {
  Future<Result<List<FavoriteArticleModel>, AppFailure>> loadFavorites();

  Future<Result<void, AppFailure>> saveFavorites(
    List<FavoriteArticleModel> favorites,
  );
}

@LazySingleton(as: FavoritesLocalDatasource)
class FavoritesLocalDatasourceImpl implements FavoritesLocalDatasource {
  FavoritesLocalDatasourceImpl(this._preferences);

  static const _storageKey = 'favorite_articles';
  final SharedPreferencesAsync _preferences;

  @override
  Future<Result<List<FavoriteArticleModel>, AppFailure>> loadFavorites() async {
    try {
      final stored = await _preferences.getStringList(_storageKey) ?? const [];
      final favorites = stored
          .map(
            (value) => FavoriteArticleModel.fromJson(
              jsonDecode(value) as Map<String, dynamic>,
            ),
          )
          .toList(growable: false);
      return Result.data(favorites);
    } catch (_) {
      return Result.error(const AppFailure(FailureType.storage));
    }
  }

  @override
  Future<Result<void, AppFailure>> saveFavorites(
    List<FavoriteArticleModel> favorites,
  ) async {
    try {
      final encoded = favorites
          .map((favorite) => jsonEncode(favorite.toJson()))
          .toList(growable: false);
      await _preferences.setStringList(_storageKey, encoded);
      return Result.data(null);
    } catch (_) {
      return Result.error(const AppFailure(FailureType.storage));
    }
  }
}
