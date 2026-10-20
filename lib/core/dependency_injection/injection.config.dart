// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:get_it/get_it.dart' as _i174;
import 'package:http/http.dart' as _i519;
import 'package:injectable/injectable.dart' as _i526;
import 'package:news_app/core/config/news_api_config.dart' as _i841;
import 'package:news_app/core/dependency_injection/app_module.dart' as _i625;
import 'package:news_app/features/favorites/data/datasources/favorites_local_datasource.dart'
    as _i978;
import 'package:news_app/features/favorites/data/repositories/favorites_repository_impl.dart'
    as _i885;
import 'package:news_app/features/favorites/domain/repositories/favorites_repository.dart'
    as _i84;
import 'package:news_app/features/favorites/domain/use_cases/load_favorites.dart'
    as _i9;
import 'package:news_app/features/favorites/domain/use_cases/toggle_favorite.dart'
    as _i841;
import 'package:news_app/features/favorites/presentation/cubit/favorites_cubit.dart'
    as _i768;
import 'package:news_app/features/news/data/datasources/news_remote_datasource.dart'
    as _i520;
import 'package:news_app/features/news/data/repositories/news_repository_impl.dart'
    as _i634;
import 'package:news_app/features/news/domain/repositories/news_repository.dart'
    as _i975;
import 'package:news_app/features/news/domain/use_cases/fetch_news.dart'
    as _i451;
import 'package:news_app/features/news/presentation/cubit/news_cubit.dart'
    as _i472;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    gh.lazySingleton<_i841.NewsApiConfig>(() => appModule.newsApiConfig);
    gh.lazySingleton<_i519.Client>(() => appModule.httpClient);
    gh.lazySingleton<_i460.SharedPreferencesAsync>(() => appModule.preferences);
    gh.lazySingleton<_i978.FavoritesLocalDatasource>(
      () => _i978.FavoritesLocalDatasourceImpl(
        gh<_i460.SharedPreferencesAsync>(),
      ),
    );
    gh.lazySingleton<_i520.NewsRemoteDatasource>(
      () => _i520.NewsRemoteDatasourceImpl(
        gh<_i519.Client>(),
        gh<_i841.NewsApiConfig>(),
      ),
    );
    gh.lazySingleton<_i84.FavoritesRepository>(
      () => _i885.FavoritesRepositoryImpl(gh<_i978.FavoritesLocalDatasource>()),
    );
    gh.lazySingleton<_i975.NewsRepository>(
      () => _i634.NewsRepositoryImpl(gh<_i520.NewsRemoteDatasource>()),
    );
    gh.factory<_i9.LoadFavorites>(
      () => _i9.LoadFavorites(gh<_i84.FavoritesRepository>()),
    );
    gh.factory<_i841.ToggleFavorite>(
      () => _i841.ToggleFavorite(gh<_i84.FavoritesRepository>()),
    );
    gh.factory<_i451.FetchNews>(
      () => _i451.FetchNews(gh<_i975.NewsRepository>()),
    );
    gh.factory<_i768.FavoritesCubit>(
      () => _i768.FavoritesCubit(
        gh<_i9.LoadFavorites>(),
        gh<_i841.ToggleFavorite>(),
      ),
    );
    gh.factory<_i472.NewsCubit>(() => _i472.NewsCubit(gh<_i451.FetchNews>()));
    return this;
  }
}

class _$AppModule extends _i625.AppModule {}
