import 'package:flutter/material.dart';
import 'package:news_app/core/domain/entities/article.dart';
import 'package:news_app/core/presentation/widgets/article_image.dart';
import 'package:news_app/core/presentation/widgets/article_meta.dart';
import 'package:news_app/core/presentation/widgets/favorite_button.dart';
import 'package:news_app/core/theme/app_colors.dart';

class FeaturedArticle extends StatelessWidget {
  const FeaturedArticle({
    required this.article,
    required this.isFavorite,
    required this.onFavorite,
    required this.onTap,
    super.key,
  });

  final Article article;
  final bool isFavorite;
  final VoidCallback onFavorite;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.ink,
      borderRadius: BorderRadius.circular(26),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 360,
          child: Stack(
            fit: StackFit.expand,
            children: [
              ArticleImage(url: article.imageUrl),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Color(0xE617212B)],
                    stops: [0.25, 0.9],
                  ),
                ),
              ),
              Positioned(
                top: 14,
                right: 14,
                child: FavoriteButton(
                  selected: isFavorite,
                  onPressed: onFavorite,
                  onDark: true,
                ),
              ),
              Positioned(
                left: 20,
                right: 20,
                bottom: 22,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ArticleMeta(article: article, onDark: true),
                    const SizedBox(height: 10),
                    Text(
                      article.title,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        height: 1.1,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.6,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
