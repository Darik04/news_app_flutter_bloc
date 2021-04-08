import 'package:flutter/material.dart';
import 'package:top_news_app/src/data/models/article_model.dart';

class DetailContent extends StatelessWidget {
  final Article article;

  const DetailContent({this.article});

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
            child: Column(
              children: [
                
                SizedBox(height: 10.0),
                Container(
                  alignment: Alignment.topLeft,
                  child: article.title == null ? Text('Not title') : Text(article.title, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w800),),
                ),
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Divider(height: 40, thickness: 1.0, color: Colors.grey[400],),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text('Описание', style: TextStyle(fontSize:18.0, fontWeight: FontWeight.w600),),
                ),
                SizedBox(height: 10.0),
                Container(
                  alignment: Alignment.topLeft,
                  child: article.descriptions == null ? Text('Not descriptions') : Text(article.descriptions, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),),
                ),
                SizedBox(height: 10.0),
                Image(
                  width: MediaQuery.of(context).size.width,
                  image: article.urlToImage == null ? AssetImage('assets/images/not_img.jpg') : NetworkImage(article.urlToImage) 
                ),
                SizedBox(height: 20.0),
                Container(
                  alignment: Alignment.center,
                  child: Text('Контент', style: TextStyle(fontSize:18.0, fontWeight: FontWeight.w600),),
                ),
                SizedBox(height: 10.0),
                Container(
                  alignment: Alignment.topLeft,
                  child: article.content == null ? Text('Not content!') : Text(article.content, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),),
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      article.author != null ? Text(article.author, style: TextStyle(fontSize:18.0, fontWeight: FontWeight.w600),) : Text('Автор', style: TextStyle(fontSize:18.0, fontWeight: FontWeight.w600),),
                      article.publishedAt != null ? Text(article.publishedAt, style: TextStyle(fontSize:18.0, fontWeight: FontWeight.w600),) : Text('Время', style: TextStyle(fontSize:18.0, fontWeight: FontWeight.w600),)
                    ],
                  ),
                )
              ],
            )
          )
        ],
      );
  }
}