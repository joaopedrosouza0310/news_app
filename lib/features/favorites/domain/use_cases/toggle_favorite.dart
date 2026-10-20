import 'package:injectable/injectable.dart';
import 'package:news_app/core/domain/entities/article.dart';
import 'package:news_app/core/errors/app_failure.dart';
import 'package:news_app/core/result/result.dart';
import 'package:news_app/features/favorites/domain/repositories/favorites_repository.dart';

@injectable
class ToggleFavorite {
  const ToggleFavorite(this._repository);

  final FavoritesRepository _repository;

  Future<Result<List<Article>, AppFailure>> call(Article article) =>
      _repository.toggleFavorite(article);
}
