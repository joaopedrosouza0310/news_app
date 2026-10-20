import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/core/domain/entities/article.dart';
import 'package:news_app/core/errors/app_failure.dart';
import 'package:news_app/core/result/result.dart';
import 'package:news_app/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:news_app/features/favorites/domain/use_cases/load_favorites.dart';
import 'package:news_app/features/favorites/domain/use_cases/toggle_favorite.dart';
import 'package:news_app/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:news_app/features/home/presentation/pages/home_page.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';
import 'package:news_app/features/news/domain/use_cases/fetch_news.dart';
import 'package:news_app/features/news/presentation/cubit/news_cubit.dart';

void main() {
  testWidgets('saves a story and displays it in the Saved tab', (tester) async {
    const article = Article(
      title: 'Architecture makes apps maintainable',
      url: 'https://example.com/architecture',
      source: 'Example News',
    );
    final newsCubit = NewsCubit(FetchNews(_NewsRepository([article])));
    final favoritesRepository = _FavoritesRepository();
    final favoritesCubit = FavoritesCubit(
      LoadFavorites(favoritesRepository),
      ToggleFavorite(favoritesRepository),
    );
    await newsCubit.loadNews();
    await favoritesCubit.loadFavorites();

    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider.value(value: newsCubit),
            BlocProvider.value(value: favoritesCubit),
          ],
          child: const HomePage(),
        ),
      ),
    );

    expect(find.text(article.title), findsOneWidget);
    await tester.tap(find.byTooltip('Save story').first);
    await tester.pump();
    await tester.tap(find.text('Saved'));
    await tester.pumpAndSettle();

    expect(find.text('Saved stories'), findsOneWidget);
    expect(find.text(article.title), findsOneWidget);
    expect(find.byTooltip('Remove from saved'), findsOneWidget);

    await newsCubit.close();
    await favoritesCubit.close();
  });
}

class _NewsRepository implements NewsRepository {
  _NewsRepository(this.articles);

  final List<Article> articles;

  @override
  Future<Result<List<Article>, AppFailure>> fetchNews(
    String query, {
    required int page,
  }) async => Result.data(articles);
}

class _FavoritesRepository implements FavoritesRepository {
  List<Article> values = [];

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
