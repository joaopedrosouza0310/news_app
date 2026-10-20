import 'package:flutter/material.dart';
import 'package:news_app/core/domain/entities/article.dart';
import 'package:news_app/core/theme/app_colors.dart';

class ArticleMeta extends StatelessWidget {
  const ArticleMeta({required this.article, this.onDark = false, super.key});

  final Article article;
  final bool onDark;

  @override
  Widget build(BuildContext context) {
    final color = onDark ? Colors.white70 : AppColors.muted;
    return Row(
      children: [
        Flexible(
          child: Text(
            (article.source?.isNotEmpty == true ? article.source! : 'News')
                .toUpperCase(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: onDark ? const Color(0xFFFFB2A6) : AppColors.accent,
              fontSize: 10,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.8,
            ),
          ),
        ),
        if (article.publishedAt != null) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text('•', style: TextStyle(color: color)),
          ),
          Text(
            _timeAgo(article.publishedAt!),
            style: TextStyle(color: color, fontSize: 11),
          ),
        ],
      ],
    );
  }

  String _timeAgo(DateTime date) {
    final difference = DateTime.now().difference(date);
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes.clamp(1, 59)}m';
    }
    if (difference.inHours < 24) return '${difference.inHours}h';
    return '${difference.inDays}d';
  }
}
