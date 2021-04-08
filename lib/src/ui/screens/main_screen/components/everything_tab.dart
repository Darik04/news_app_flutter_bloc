import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_news_app/src/bloc/news_bloc.dart';
import 'package:top_news_app/src/bloc/news_event.dart';
import 'package:top_news_app/src/bloc/news_state.dart';
import 'package:top_news_app/src/data/models/article_model.dart';
import 'package:top_news_app/src/ui/components/article_card.dart';



class EverythingTab extends StatefulWidget {
  final NewsBloc newsBloc;

  EverythingTab({this.newsBloc});

  @override
  _EverythingTabState createState() => _EverythingTabState();
}

class _EverythingTabState extends State<EverythingTab> {
  
  Timer timer;
  @override
  void initState() { 
    super.initState();
    widget.newsBloc.add(FetchEveryStart());
    
  }
  ScrollController _scrollController = new ScrollController(); 
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      body: BlocBuilder<NewsBloc, NewsBlocState>(
        
        builder: (BuildContext context, NewsBlocState state) {
          if (state is LoadingEveryNewsState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is LoadedEveryNewsState) {
            return RefreshIndicator(
              onRefresh: (){
                widget.newsBloc.add(FetchEveryStart());
              },
              child: NotificationListener<ScrollNotification>(
              // onNotification: _handleScrollNotification,
              child: _builtArticles(state.everyArticles)
            )
            );
          } else if (state is ErrorEveryState) {
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
      widget.newsBloc.add(FetchEveryAdditional());
      print('bottom');
    }

    return false;
  }

 
}

