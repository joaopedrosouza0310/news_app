class NewsApiConfig {
  const NewsApiConfig({required this.apiKey});

  final String apiKey;

  bool get isConfigured => apiKey.isNotEmpty;
}
