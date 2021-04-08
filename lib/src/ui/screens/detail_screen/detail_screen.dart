import 'package:flutter/material.dart';
import 'package:top_news_app/src/bloc/bloc.dart';
import 'package:top_news_app/src/data/models/article_model.dart';
import 'package:top_news_app/src/ui/screens/detail_screen/components/detail_content.dart';


//Detail Screen Просмотр новости!
class DetailScreen extends StatelessWidget {

  final Article article;
  final NewsBloc newsBloc;

  const DetailScreen({this.article, this.newsBloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: article.title == null ? Text('Not title') : Text(article.title, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w800),),
        actions: [
          GestureDetector(
            onTap: (){
              newsBloc.add(AdditionRemoveArticleToFavorites(article));
              newsBloc.add(FetchFavoriteArticles());
            },
            child: Icon(Icons.star_border_outlined, color: Colors.yellow[700], size: 36.0)),
          SizedBox(width: 14.0),
        ],
      ),
      body: DetailContent(article: article,)
    );
  }
}