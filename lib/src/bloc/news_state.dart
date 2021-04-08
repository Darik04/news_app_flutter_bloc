import 'package:meta/meta.dart';
import 'package:top_news_app/src/data/models/article_model.dart';

@immutable
abstract class NewsBlocState {}

class InitialNewsBlocState extends NewsBlocState {}

class LoadingEveryNewsState extends NewsBlocState {}

class LoadingAdditionEveryNewsState extends NewsBlocState {}

class LoadedEveryNewsState extends NewsBlocState {
  final List<Article> everyArticles;

  LoadedEveryNewsState({@required this.everyArticles}) : assert(everyArticles != null);
}

class ErrorEveryState extends NewsBlocState {}

class LoadingTopHeadlinesNewsState extends NewsBlocState {}

class LoadedTopHeadlinesNewsState extends NewsBlocState {
  final List<Article> topHeadArticles;

  LoadedTopHeadlinesNewsState({@required this.topHeadArticles,}) : assert(topHeadArticles !=null);
}

class ErrorTopHeadlinesState extends NewsBlocState {}


class IsEmptyFavoriteState extends NewsBlocState {}

class LoadedFavoriteState extends NewsBlocState {
  final List<Article> favoriteArticles;

  LoadedFavoriteState({@required this.favoriteArticles}) : assert(favoriteArticles != null);
}

class ErrorFavoriteState extends NewsBlocState {}