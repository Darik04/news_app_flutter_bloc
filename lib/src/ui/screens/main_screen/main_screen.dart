import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_news_app/src/bloc/bloc.dart';


import 'components/everything_tab.dart';
import 'components/top_headlines_tab.dart';

class MainScreen extends StatefulWidget {

  @override
  _MainScreenState createState() => _MainScreenState();
}


class _MainScreenState extends State<MainScreen> {
  NewsBloc newsBloc;

  
  @override
  void initState() { 
    super.initState();
    newsBloc = BlocProvider.of<NewsBloc>(context);
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: DefaultTabController(
        
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            bottom: TabBar(
              
              tabs: [
                Tab(icon: Icon(Icons.list_alt_outlined,)),
                Tab(icon: Icon(Icons.view_list)),
         
              ],
            ),
            title: Text('Top news'),
          ),
          body: TabBarView(
            children: [
              
              TopHeadlinesTab(newsBloc: newsBloc),
              EverythingTab(newsBloc: newsBloc),
            ],
          ),
        ),
      ),
    );
  }
}