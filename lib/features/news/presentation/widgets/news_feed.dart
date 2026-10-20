import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/domain/entities/article.dart';
import 'package:news_app/core/errors/app_failure.dart';
import 'package:news_app/core/presentation/widgets/article_card.dart';
import 'package:news_app/core/presentation/widgets/empty_state.dart';
import 'package:news_app/core/presentation/widgets/section_title.dart';
import 'package:news_app/core/theme/app_colors.dart';
import 'package:news_app/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:news_app/features/favorites/presentation/cubit/favorites_state.dart';
import 'package:news_app/features/news/presentation/cubit/news_cubit.dart';
import 'package:news_app/features/news/presentation/cubit/news_state.dart';
import 'package:news_app/features/news/presentation/widgets/featured_article.dart';
import 'package:news_app/features/news/presentation/widgets/news_header.dart';
import 'package:news_app/features/news/presentation/widgets/news_search_field.dart';
import 'package:news_app/features/news/presentation/widgets/topic_selector.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsFeed extends StatefulWidget {
  const NewsFeed({super.key});

  @override
  State<NewsFeed> createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  static const _topics = [
    'Space',
    'Technology',
    'Science',
    'Business',
    'Health',
  ];

  final _searchController = TextEditingController(text: 'Space');
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    if (_scrollController.position.extentAfter < 500) {
      context.read<NewsCubit>().loadMoreNews();
    }
  }

  void _search([String? value]) {
    FocusManager.instance.primaryFocus?.unfocus();
    context.read<NewsCubit>().loadNews(query: value ?? _searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, newsState) {
        return BlocBuilder<FavoritesCubit, FavoritesState>(
          builder: (context, favoritesState) => RefreshIndicator(
            color: AppColors.accent,
            onRefresh: context.read<NewsCubit>().refreshNews,
            child: CustomScrollView(
              key: const PageStorageKey('discover'),
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: _buildSlivers(newsState, favoritesState),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildSlivers(NewsState state, FavoritesState favoritesState) {
    return [
      SliverToBoxAdapter(
        child: NewsHeader(favoriteCount: favoritesState.favorites.length),
      ),
      SliverToBoxAdapter(
        child: NewsSearchField(
          controller: _searchController,
          onSubmitted: _search,
        ),
      ),
      SliverToBoxAdapter(
        child: TopicSelector(
          topics: _topics,
          selected: state.query,
          onSelected: (topic) {
            _searchController.text = topic;
            _search(topic);
          },
        ),
      ),
      if (state.isLoading && state.articles.isEmpty)
        const SliverFillRemaining(
          child: Center(
            child: CircularProgressIndicator(color: AppColors.accent),
          ),
        )
      else if (state.failure != null && state.articles.isEmpty)
        SliverFillRemaining(
          child: EmptyState(
            icon: Icons.wifi_off_rounded,
            title: 'Connection lost',
            message: _failureMessage(state.failure!),
            action: FilledButton.icon(
              onPressed: context.read<NewsCubit>().loadNews,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Try again'),
            ),
          ),
        )
      else if (state.articles.isEmpty)
        const SliverFillRemaining(
          child: EmptyState(
            icon: Icons.article_outlined,
            title: 'No stories found',
            message: 'Try searching for another topic.',
          ),
        )
      else
        ..._articleSlivers(state, favoritesState),
    ];
  }

  List<Widget> _articleSlivers(NewsState state, FavoritesState favoritesState) {
    final firstArticle = state.articles.first;
    return [
      SliverToBoxAdapter(
        child: SectionTitle(
          eyebrow: 'TOP STORY',
          title: 'Fresh perspectives',
          trailing: '${state.articles.length} stories',
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 18),
          child: FeaturedArticle(
            article: firstArticle,
            isFavorite: _isFavorite(favoritesState, firstArticle.url),
            onFavorite: () => _toggleFavorite(firstArticle),
            onTap: () => _openArticle(firstArticle),
          ),
        ),
      ),
      if (state.articles.length > 1)
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          sliver: SliverList.separated(
            itemCount: state.articles.length - 1,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final article = state.articles[index + 1];
              return ArticleCard(
                article: article,
                isFavorite: _isFavorite(favoritesState, article.url),
                onFavorite: () => _toggleFavorite(article),
                onTap: () => _openArticle(article),
              );
            },
          ),
        ),
      SliverToBoxAdapter(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: state.isLoadingMore
              ? const Padding(
                  padding: EdgeInsets.only(bottom: 24),
                  child: Center(child: CircularProgressIndicator()),
                )
              : const SizedBox(height: 24),
        ),
      ),
    ];
  }

  bool _isFavorite(FavoritesState state, String url) =>
      state.favorites.any((article) => article.url == url);

  void _toggleFavorite(Article article) {
    context.read<FavoritesCubit>().toggleFavorite(article);
  }

  Future<void> _openArticle(Article article) async {
    final uri = Uri.tryParse(article.url);
    final opened =
        uri != null &&
        await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!opened && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open this story.')),
      );
    }
  }

  String _failureMessage(AppFailure failure) {
    return switch (failure.type) {
      FailureType.configuration =>
        'Add NEWS_API_KEY with --dart-define to load stories.',
      FailureType.network => 'Check your connection and try again.',
      FailureType.timeout => 'The request took too long. Please try again.',
      FailureType.server => 'The news service is unavailable right now.',
      FailureType.parsing =>
        'The news service returned an unexpected response.',
      FailureType.storage => 'Saved stories could not be accessed.',
      FailureType.unknown => 'Something went wrong. Please try again.',
    };
  }
}
