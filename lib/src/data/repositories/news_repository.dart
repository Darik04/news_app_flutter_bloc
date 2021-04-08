import 'package:flutter/cupertino.dart';
import 'package:top_news_app/src/data/models/article_model.dart';
import 'package:top_news_app/src/data/services/everything_api.dart';
import 'package:top_news_app/src/data/services/top_headlines_api.dart';


class NewsRepository {
  NewsEveryhingApi newsEveryhingApi;
  TopHeadlinesApi topHeadlinesApi;

  NewsRepository({@required this.newsEveryhingApi, @required this.topHeadlinesApi}) : assert(newsEveryhingApi != null && topHeadlinesApi != null);

  Future<List<Article>> getEveryNewsRepo(int page) async {
    return await newsEveryhingApi.getNews(page);
  }

  Future<List<Article>> getTopHeadNewsRepo(int page) async {
    
    return await topHeadlinesApi.getNews(page);
  }
}