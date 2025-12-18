import 'package:day01/model/news.dart';
import 'package:dio/dio.dart';

class NewsAPI {
  final String apiKey = '63497e3306404d7188ab2c99f8b0df16';
  final String baseUrl = 'https://newsapi.org/v2';

  Future<List<News>> getNews() async {
    var dio = Dio();
    var response = await dio.get(
      '$baseUrl/everything',
      queryParameters: {
        'q': 'tesla',
        // 'from': '2025-11-05', // Removed to fetch latest news
        'sortBy': 'publishedAt',
        'apiKey': apiKey,
      },
    );

    List<News> newsList = [];

    if (response.statusCode == 200) {
      List articles = response.data['articles'];
      newsList = articles.map((x) => News.fromJson(x)).toList();
    }

    return newsList;
  }
}

var newsAPI = NewsAPI();