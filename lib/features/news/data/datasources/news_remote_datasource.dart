import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:news_app/core/config/news_api_config.dart';
import 'package:news_app/core/errors/app_failure.dart';
import 'package:news_app/core/result/result.dart';
import 'package:news_app/features/news/data/models/article_model.dart';

abstract interface class NewsRemoteDatasource {
  Future<Result<List<ArticleModel>, AppFailure>> fetchNews(
    String query, {
    required int page,
  });
}

@LazySingleton(as: NewsRemoteDatasource)
class NewsRemoteDatasourceImpl implements NewsRemoteDatasource {
  NewsRemoteDatasourceImpl(this._client, this._config);

  static const _host = 'newsapi.org';
  final http.Client _client;
  final NewsApiConfig _config;

  @override
  Future<Result<List<ArticleModel>, AppFailure>> fetchNews(
    String query, {
    required int page,
  }) async {
    if (!_config.isConfigured) {
      return Result.error(const AppFailure(FailureType.configuration));
    }

    final uri = Uri.https(_host, '/v2/everything', {
      'apiKey': _config.apiKey,
      'q': query,
      'page': '$page',
      'pageSize': '20',
      'sortBy': 'publishedAt',
    });

    try {
      final response = await _client
          .get(uri)
          .timeout(const Duration(seconds: 20));
      if (response.statusCode < 200 || response.statusCode >= 300) {
        return Result.error(const AppFailure(FailureType.server));
      }

      final body = jsonDecode(response.body) as Map<String, dynamic>;
      final articles = (body['articles'] as List<dynamic>? ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(ArticleModel.fromJson)
          .where(
            (article) => article.title.isNotEmpty && article.url.isNotEmpty,
          )
          .toList(growable: false);
      return Result.data(articles);
    } on SocketException {
      return Result.error(const AppFailure(FailureType.network));
    } on http.ClientException {
      return Result.error(const AppFailure(FailureType.network));
    } on HttpException {
      return Result.error(const AppFailure(FailureType.network));
    } on FormatException {
      return Result.error(const AppFailure(FailureType.parsing));
    } on TimeoutException {
      return Result.error(const AppFailure(FailureType.timeout));
    } catch (_) {
      return Result.error(const AppFailure(FailureType.unknown));
    }
  }
}
