import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:news_app/core/domain/entities/article.dart';
import 'package:news_app/core/errors/app_failure.dart';

part 'news_state.freezed.dart';

@freezed
abstract class NewsState with _$NewsState {
  const factory NewsState({
    @Default([]) List<Article> articles,
    @Default(false) bool isLoading,
    @Default(false) bool isRefreshing,
    @Default(false) bool isLoadingMore,
    @Default(true) bool hasMore,
    @Default('Space') String query,
    AppFailure? failure,
  }) = _NewsState;
}
