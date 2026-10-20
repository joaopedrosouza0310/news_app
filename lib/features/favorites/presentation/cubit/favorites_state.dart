import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:news_app/core/domain/entities/article.dart';
import 'package:news_app/core/errors/app_failure.dart';

part 'favorites_state.freezed.dart';

@freezed
abstract class FavoritesState with _$FavoritesState {
  const factory FavoritesState({
    @Default([]) List<Article> favorites,
    @Default(false) bool isLoading,
    @Default(false) bool isUpdating,
    AppFailure? failure,
  }) = _FavoritesState;
}
