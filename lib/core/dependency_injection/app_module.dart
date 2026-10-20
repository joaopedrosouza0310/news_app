import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:news_app/core/config/news_api_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class AppModule {
  @lazySingleton
  NewsApiConfig get newsApiConfig =>
      const NewsApiConfig(apiKey: String.fromEnvironment('NEWS_API_KEY'));

  @lazySingleton
  http.Client get httpClient => http.Client();

  @lazySingleton
  SharedPreferencesAsync get preferences => SharedPreferencesAsync();
}
