import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/core/domain/entities/article.dart';
import 'package:news_app/core/result/result.dart';
import 'package:news_app/features/favorites/domain/use_cases/load_favorites.dart';
import 'package:news_app/features/favorites/domain/use_cases/toggle_favorite.dart';
import 'package:news_app/features/favorites/presentation/cubit/favorites_state.dart';

@injectable
class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit(this._loadFavorites, this._toggleFavorite)
    : super(const FavoritesState());

  final LoadFavorites _loadFavorites;
  final ToggleFavorite _toggleFavorite;

  Future<void> loadFavorites() async {
    if (state.isLoading) return;
    emit(state.copyWith(isLoading: true, failure: null));
    final result = await _loadFavorites();
    result.when(
      data: (favorites) =>
          emit(state.copyWith(favorites: favorites, isLoading: false)),
      error: (failure) =>
          emit(state.copyWith(isLoading: false, failure: failure)),
    );
  }

  Future<void> toggleFavorite(Article article) async {
    if (state.isUpdating) return;
    emit(state.copyWith(isUpdating: true, failure: null));
    final result = await _toggleFavorite(article);
    result.when(
      data: (favorites) =>
          emit(state.copyWith(favorites: favorites, isUpdating: false)),
      error: (failure) =>
          emit(state.copyWith(isUpdating: false, failure: failure)),
    );
  }

  bool isFavorite(String url) =>
      state.favorites.any((article) => article.url == url);
}
