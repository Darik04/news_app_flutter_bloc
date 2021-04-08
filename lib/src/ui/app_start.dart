import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_news_app/src/bloc/bloc.dart';
import 'package:top_news_app/src/data/repositories/news_repository.dart';
import 'package:top_news_app/src/data/services/everything_api.dart';
import 'package:top_news_app/src/data/services/top_headlines_api.dart';
import 'package:top_news_app/src/ui/screens/main_screen/main_screen.dart';
import 'package:http/http.dart' as http;

import 'screens/favorite_screen/favorite_screen.dart';



//Start app! and main bottom nav bar!
class AppStart extends StatefulWidget {

  @override
  _AppStartState createState() => _AppStartState();
}

class _AppStartState extends State<AppStart> {
  final NewsRepository newsRepository = NewsRepository(newsEveryhingApi: NewsEveryhingApi(), topHeadlinesApi: TopHeadlinesApi());

  NewsBloc newsBloc;

  List<Widget> screens = [MainScreen(), FavoriteScreen()];
  int currentPage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newsBloc = NewsBloc(newsRepository: newsRepository);
  }

  

  @override
  Widget build(BuildContext context) {
    
    return BlocProvider<NewsBloc>(
      create: (context) => NewsBloc(newsRepository: newsRepository),
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Top news',
        themeMode: ThemeMode.light,
        theme: ThemeData(
          primaryColor: Colors.deepPurpleAccent[800],
          primaryColorLight: Colors.deepPurpleAccent[800]
        ),
        home: Scaffold(
          body: screens[currentPage],


          // Bottom Nav Bar
          bottomNavigationBar: BottomNavigationBar(
          onTap: (int index){
            setState(() {
              currentPage = index;
            });
          },
          elevation: 15.0,
          currentIndex: currentPage,
          backgroundColor: Theme.of(context).bottomAppBarColor,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_outlined),
              title: Text('Новости'),
              
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border_outlined),
              title: Text('Закладки'),
              
            )
          ],
        ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    newsBloc.close();
  }
}