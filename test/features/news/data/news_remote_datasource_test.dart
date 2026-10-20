import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:news_app/core/config/news_api_config.dart';
import 'package:news_app/core/errors/app_failure.dart';
import 'package:news_app/core/result/result.dart';
import 'package:news_app/features/news/data/datasources/news_remote_datasource.dart';

void main() {
  test('parses a successful NewsAPI response', () async {
    final client = MockClient((request) async {
      expect(request.url.queryParameters['apiKey'], 'test-key');
      expect(request.url.queryParameters['page'], '2');
      return http.Response(
        '{"articles":[{"title":"Story","url":"https://example.com",'
        '"source":{"name":"Example"},"publishedAt":"2026-10-19T12:00:00Z"}]}',
        200,
      );
    });
    final datasource = NewsRemoteDatasourceImpl(
      client,
      const NewsApiConfig(apiKey: 'test-key'),
    );

    final result = await datasource.fetchNews('Space', page: 2);

    result.when(
      data: (articles) {
        expect(articles.single.title, 'Story');
        expect(articles.single.source, 'Example');
      },
      error: (_) => fail('Expected parsed articles'),
    );
  });

  test('returns a configuration failure when the API key is missing', () async {
    final datasource = NewsRemoteDatasourceImpl(
      MockClient((_) async => http.Response('{}', 200)),
      const NewsApiConfig(apiKey: ''),
    );

    final result = await datasource.fetchNews('Space', page: 1);

    expect(
      result.when(data: (_) => null, error: (failure) => failure.type),
      FailureType.configuration,
    );
  });
}
