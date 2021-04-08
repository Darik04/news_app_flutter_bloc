
import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_news_app/src/bloc/news_bloc.dart';
import 'package:top_news_app/src/bloc/news_event.dart';
import 'package:top_news_app/src/bloc/news_state.dart';
import 'package:top_news_app/src/data/models/article_model.dart';
import 'package:top_news_app/src/data/repositories/news_repository.dart';
import 'package:top_news_app/src/data/services/everything_api.dart';
import 'package:http/http.dart' as http;
import 'package:top_news_app/src/ui/components/article_card.dart';
import 'package:top_news_app/src/ui/screens/detail_screen/detail_screen.dart';



class FavoriteContent extends StatefulWidget {
  final NewsBloc newsBloc;

  FavoriteContent({this.newsBloc});

  @override
  _FavoriteContentState createState() => _FavoriteContentState();
}

class _FavoriteContentState extends State<FavoriteContent> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: BlocBuilder<NewsBloc, NewsBlocState>(
        
        builder: (BuildContext context, NewsBlocState state) {
          if (state is IsEmptyFavoriteState) {
            return Center(
              child: Text('У вас здесь пусто!', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w400)),
            );
          }
          if (state is LoadedFavoriteState) {
            return RefreshIndicator(
              onRefresh: (){
                widget.newsBloc.add(FetchEveryStart());
              },
              child: NotificationListener<ScrollNotification>(
              // onNotification: _handleScrollNotification,
              child: _builtArticles(state.favoriteArticles)
            )
            );
          } else if (state is ErrorFavoriteState) {
            return Center(
              child: Text("Error State"),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
    )
  );
}

  Widget _builtArticles(List<Article> e) {
    print('List length in page: ${e.length.toString()}');
    return ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: e.length,
          itemBuilder: (context, index) {
            if(index >= e.length){
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(child: CircularProgressIndicator()),
              ); 
            }
            return ArticleCard(article: e[index],newsBloc: widget.newsBloc);
          },
        
      
    );
  }


 
 
}

