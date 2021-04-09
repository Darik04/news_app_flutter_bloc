
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


class TopHeadlinesTab extends StatefulWidget {
  final NewsBloc newsBloc;

  TopHeadlinesTab({this.newsBloc});

  @override
  _TopHeadlinesTabState createState() => _TopHeadlinesTabState();
}

class _TopHeadlinesTabState extends State<TopHeadlinesTab> {
  
  Timer timer;
  @override
  void initState() { 
    super.initState();
    widget.newsBloc.add(FetchTopHeadlinesStart());
    
  }
  ScrollController _scrollController = new ScrollController(); 
  @override
  Widget build(BuildContext context) {
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => {
      widget.newsBloc.add(FetchTopHeadlinesStart())
    });
    return Scaffold(
      
      body: BlocBuilder<NewsBloc, NewsBlocState>(
        
        builder: (BuildContext context, NewsBlocState state) {
          if (state is LoadingTopHeadlinesNewsState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is LoadedTopHeadlinesNewsState) {
            return NotificationListener<ScrollNotification>(
              // onNotification: _handleScrollNotification,
              child: _builtArticles(state.topHeadArticles)
            );
            
          } else if (state is ErrorTopHeadlinesState) {
            return Center(
              child: Text("Error State"),
            );
          } else {
            return Center(
              child: Text("Error "),
            );
          }
        },
    )
  );
}

  Widget _builtArticles(List<Article> e) {
    print('List length in page: ${e.length.toString()}');
    return NotificationListener<ScrollNotification>(
              onNotification: _handleScrollNotification,
              child: ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            controller: _scrollController,
            itemCount: e.length + 1,
            itemBuilder: (context, index) {
              if(index >= e.length){
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(child: CircularProgressIndicator()),
                ); 
              }
              return ArticleCard(article: e[index], newsBloc: widget.newsBloc);
            },
          )
        
     
    );
  }


  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0) {
      widget.newsBloc.add(FetchTopHeadlinesAdditional());
      print('bottom');
    }

    return false;
  }

 
}

