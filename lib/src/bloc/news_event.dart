import 'package:meta/meta.dart';
import 'package:top_news_app/src/bloc/bloc.dart';
import 'package:top_news_app/src/data/models/article_model.dart';

@immutable
abstract class NewsBlocEvent {}

class FetchEveryStart extends NewsBlocEvent {}
class FetchEveryAdditional extends NewsBlocEvent {}

class FetchTopHeadlinesStart extends NewsBlocEvent {}
class FetchTopHeadlinesAdditional extends NewsBlocEvent {}


class AdditionRemoveArticleToFavorites extends NewsBlocEvent {
  final Article article;

  AdditionRemoveArticleToFavorites(this.article);
}

class FetchFavoriteArticles extends NewsBlocEvent {}

