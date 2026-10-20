import 'package:flutter/material.dart';

class ArticleImage extends StatelessWidget {
  const ArticleImage({this.url, super.key});

  final String? url;

  @override
  Widget build(BuildContext context) {
    if (url == null || url!.isEmpty) return const ArticleImageFallback();
    return Image.network(
      url!,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => const ArticleImageFallback(),
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return const ColoredBox(
          color: Color(0xFFE9E6DF),
          child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
        );
      },
    );
  }
}

class ArticleImageFallback extends StatelessWidget {
  const ArticleImageFallback({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Color(0xFFDDE5E7),
      child: Center(
        child: Icon(
          Icons.newspaper_rounded,
          color: Color(0xFF8A979D),
          size: 38,
        ),
      ),
    );
  }
}
