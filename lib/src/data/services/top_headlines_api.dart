import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:top_news_app/constants/constants.dart';
import 'package:top_news_app/src/data/models/article_model.dart';
import 'dart:convert' as convert;

class TopHeadlinesApi {
 

  List<Article> newsList = [];
  

  Future<List<Article>> getNews(int page) async {
    try{
      newsList = [];
      final res = await http.get('https://newsapi.org/v2/top-headlines?country=us&apiKey=${Constants.apiToken}&pageSize=${Constants.pageSize}&page=${page}');

      if (res.statusCode != 200) {
        print('error');
        
        return null;
      }else{
        final Map<String, dynamic> decodeData = convert.jsonDecode(res.body);
       
        if(decodeData['status'] != 'ok') return null;
       
        for(var data in decodeData['articles']){
              newsList.add(Article.fromJson(data));
              print('data: ${data['title']}');
        }
        
        return newsList;
        
      }
    }catch(e){
      print(e.toString());
    }
  }
}



// List<Article> list = [Article(author: 'Daryn aki', title: 'Title bla bla', descriptions: 'Description bla bla bla! dasda adsad a dsd sad a da sda dsdad a', url: 'asdasda', content: 'adsad dasdsad dasdsada adsadsad adsasda  dasdas d  dasdadadsdas dasdada', publishedAt: '2021.03.03 12:22'), Article(author: 'Daryn aki', title: 'Title bla bla', descriptions: 'Description bla bla bla!', url: 'asdasda', content: 'lorem ipsum fsdklfokfs sfdsdf s', publishedAt: '2021.03.03 12:22'), Article(author: 'Daryn aki', title: 'Title bla bla', descriptions: 'Description bla bla bla!', url: 'asdasda', content: 'dasdsadas adasd ad ad da sdas da dad asd  adsas d da', publishedAt: '2021.03.03 12:22'), Article(author: 'Daryn aki', title: 'Title bla bla', descriptions: 'Description bla bla bla!', url: 'asdasda', publishedAt: '2021.03.03 12:22', content: 'dfsfsfs sdf  sfs fsf d sfsd fsf sfsfs fsdf sd fsdf sf')];
// return list;