import 'package:flutter/material.dart';
import 'package:news_app/core/domain/entities/article.dart';
import 'package:news_app/core/presentation/widgets/article_image.dart';
import 'package:news_app/core/presentation/widgets/article_meta.dart';
import 'package:news_app/core/presentation/widgets/favorite_button.dart';
import 'package:news_app/core/theme/app_colors.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({
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
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: SizedBox(
                  width: 112,
                  height: 112,
                  child: ArticleImage(url: article.imageUrl),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: SizedBox(
                  height: 112,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ArticleMeta(article: article),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Text(
                          article.title,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.ink,
                            fontSize: 16,
                            height: 1.22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              FavoriteButton(selected: isFavorite, onPressed: onFavorite),
            ],
          ),
        ),
      ),
    );
  }
}
