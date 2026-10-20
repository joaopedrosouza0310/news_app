class Article {
  const Article({
    required this.title,
    required this.url,
    this.imageUrl,
    this.description,
    this.source,
    this.publishedAt,
  });

  final String title;
  final String url;
  final String? imageUrl;
  final String? description;
  final String? source;
  final DateTime? publishedAt;
}
