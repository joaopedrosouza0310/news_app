import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/domain/entities/article.dart';
import 'package:news_app/core/presentation/widgets/article_card.dart';
import 'package:news_app/core/presentation/widgets/empty_state.dart';
import 'package:news_app/core/presentation/widgets/section_title.dart';
import 'package:news_app/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:news_app/features/favorites/presentation/cubit/favorites_state.dart';
import 'package:url_launcher/url_launcher.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) => CustomScrollView(
        key: const PageStorageKey('saved'),
        slivers: [
          const SliverToBoxAdapter(
            child: SectionTitle(
              eyebrow: 'YOUR LIBRARY',
              title: 'Saved stories',
              trailing: 'On this device',
              large: true,
            ),
          ),
          if (state.favorites.isEmpty)
            const SliverFillRemaining(
              hasScrollBody: false,
              child: EmptyState(
                icon: Icons.bookmark_add_outlined,
                title: 'Build your reading list',
                message: 'Tap the bookmark on any story to keep it here.',
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
              sliver: SliverList.separated(
                itemCount: state.favorites.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final article = state.favorites[index];
                  return ArticleCard(
                    article: article,
                    isFavorite: true,
                    onFavorite: () =>
                        context.read<FavoritesCubit>().toggleFavorite(article),
                    onTap: () => _openArticle(context, article),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _openArticle(BuildContext context, Article article) async {
    final messenger = ScaffoldMessenger.of(context);
    final uri = Uri.tryParse(article.url);
    final opened =
        uri != null &&
        await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!opened) {
      messenger.showSnackBar(
        const SnackBar(content: Text('Could not open this story.')),
      );
    }
  }
}
