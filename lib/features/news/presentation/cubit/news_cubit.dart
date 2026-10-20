import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/core/result/result.dart';
import 'package:news_app/features/news/domain/use_cases/fetch_news.dart';
import 'package:news_app/features/news/presentation/cubit/news_state.dart';

@injectable
class NewsCubit extends Cubit<NewsState> {
  NewsCubit(this._fetchNews) : super(const NewsState());

  final FetchNews _fetchNews;
  int _page = 1;

  Future<void> loadNews({String? query}) async {
    if (state.isLoading) return;
    final nextQuery = query?.trim().isNotEmpty == true
        ? query!.trim()
        : state.query;
    _page = 1;
    emit(
      state.copyWith(
        isLoading: true,
        query: nextQuery,
        failure: null,
        hasMore: true,
      ),
    );

    final result = await _fetchNews(nextQuery, page: _page);
    result.when(
      data: (articles) => emit(
        state.copyWith(
          articles: articles,
          isLoading: false,
          hasMore: articles.length == 20,
        ),
      ),
      error: (failure) =>
          emit(state.copyWith(isLoading: false, failure: failure)),
    );
  }

  Future<void> refreshNews() async {
    if (state.isRefreshing || state.isLoading) return;
    emit(state.copyWith(isRefreshing: true, failure: null));
    final result = await _fetchNews(state.query, page: 1);
    result.when(
      data: (articles) {
        _page = 1;
        emit(
          state.copyWith(
            articles: articles,
            isRefreshing: false,
            hasMore: articles.length == 20,
          ),
        );
      },
      error: (failure) =>
          emit(state.copyWith(isRefreshing: false, failure: failure)),
    );
  }

  Future<void> loadMoreNews() async {
    if (state.isLoading || state.isLoadingMore || !state.hasMore) return;
    emit(state.copyWith(isLoadingMore: true));
    final nextPage = _page + 1;
    final result = await _fetchNews(state.query, page: nextPage);
    result.when(
      data: (articles) {
        _page = nextPage;
        final knownUrls = state.articles.map((article) => article.url).toSet();
        final unique = articles.where((article) => knownUrls.add(article.url));
        emit(
          state.copyWith(
            articles: [...state.articles, ...unique],
            isLoadingMore: false,
            hasMore: articles.length == 20,
          ),
        );
      },
      error: (failure) =>
          emit(state.copyWith(isLoadingMore: false, failure: failure)),
    );
  }
}
