import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:top_news_app/src/data/models/article_model.dart';
import 'package:top_news_app/src/data/repositories/news_repository.dart';
import './bloc.dart';
import 'news_event.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsBlocEvent, NewsBlocState> {
  NewsRepository newsRepository;

  NewsBloc({@required this.newsRepository}) : assert(newsRepository != null), super(null);
  Timer timer;
  @override
  NewsBlocState get initialState => InitialNewsBlocState();

  int _pageEveryNews = 0;
  int _pageTopNews = 0;

  List<Article> _listEveryNews = [];
  List<Article> _listTopHeadlinesNews = [];

  List<Article> _listFavoriteNews = [];
 


  @override
  Stream<NewsBlocState> mapEventToState(NewsBlocEvent event) async* {
    if (event is FetchEveryStart) {
      yield LoadingEveryNewsState();
      try {    
        _listEveryNews = [];
        final List<Article> everyArticles = await newsRepository.getEveryNewsRepo(1);

        print('List length FetchEveryStart: ${_listEveryNews.length.toString()}');
     
        yield LoadedEveryNewsState(everyArticles: everyArticles);
      } catch (_) {
        yield ErrorEveryState();
      }
    }if(event is FetchEveryAdditional){
      try {    
        _pageEveryNews++;
        final List<Article> everyArticles = await newsRepository.getEveryNewsRepo(_pageEveryNews);
        _listEveryNews = _listEveryNews + everyArticles;
        print('List length: ${_listEveryNews.length.toString()}');
        yield LoadedEveryNewsState(everyArticles: _listEveryNews);
      } catch (_) {
        yield ErrorEveryState();
      }
    }
    if (event is FetchTopHeadlinesStart) {
      yield LoadingTopHeadlinesNewsState();
      try {    
        _listTopHeadlinesNews = [];
        final List<Article> everyArticles = await newsRepository.getTopHeadNewsRepo(1);

        print('List length FetchTopHeadlinesStart: ${_listTopHeadlinesNews.length.toString()}');
     
        yield LoadedTopHeadlinesNewsState(topHeadArticles: everyArticles);
      } catch (_) {
        yield ErrorTopHeadlinesState();
      }
    }if(event is FetchTopHeadlinesAdditional){
      try {    
        _pageTopNews++;
        final List<Article> topHeadlinesArticles = await newsRepository.getTopHeadNewsRepo(_pageTopNews);
        _listTopHeadlinesNews = _listTopHeadlinesNews + topHeadlinesArticles;
        print('List length: ${_listTopHeadlinesNews.length.toString()}');
        yield LoadedTopHeadlinesNewsState(topHeadArticles: _listTopHeadlinesNews);
      } catch (_) {
        yield ErrorTopHeadlinesState();
      }
    }if(event is AdditionRemoveArticleToFavorites){
      if(_listFavoriteNews.contains(event.article)){
        _listFavoriteNews.remove(event.article);
      }else{
        _listFavoriteNews.add(event.article);
        
      }
      
      print(_listFavoriteNews);
    }if(event is FetchFavoriteArticles){
      if(_listFavoriteNews.isEmpty){
        yield IsEmptyFavoriteState();
      }else if(_listFavoriteNews.isNotEmpty){
        yield LoadedFavoriteState(favoriteArticles: _listFavoriteNews);
      }else{
        yield ErrorFavoriteState();
      }
      
    }
  }
}