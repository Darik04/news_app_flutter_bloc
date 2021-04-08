import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_news_app/src/bloc/bloc.dart';

import 'components/favorite_content.dart';

class FavoriteScreen extends StatefulWidget {

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  NewsBloc newsBloc;
  @override
  void initState() { 
    super.initState();
    newsBloc = BlocProvider.of<NewsBloc>(context);
    newsBloc.add(FetchFavoriteArticles());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Закладки!')
      ),
      body: FavoriteContent(newsBloc: newsBloc,),
    );
  }
}