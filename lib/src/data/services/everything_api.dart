import 'package:http/http.dart' as http;
import 'package:top_news_app/constants/constants.dart';
import 'package:top_news_app/src/data/models/article_model.dart';
import 'dart:convert' as convert;


//News Everything endpoint API
class NewsEveryhingApi {
 

  List<Article> newsList = [];

  Future<List<Article>> getNews(int page) async {
    
    try{
      newsList = [];
      final res = await http.get('https://newsapi.org/v2/everything?q=bitcoin&apiKey=${Constants.apiToken}&pageSize=${Constants.pageSize}&page=${page}');

      if (res.statusCode != 200) {
        print('error');
        
        return null;
      }else{
        final Map<String, dynamic> decodeData = convert.jsonDecode(res.body);
   
        if(decodeData['status'] != 'ok') return null;
       
        for(var data in decodeData['articles']){
              newsList.add(Article.fromJson(data));
       
        }

        
        return newsList;
        
      }
    }catch(e){
      print(e.toString());
    }
  }
}