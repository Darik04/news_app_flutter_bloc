import 'package:flutter/material.dart';
import 'package:top_news_app/src/bloc/bloc.dart';
import 'package:top_news_app/src/data/models/article_model.dart';
import 'package:top_news_app/src/ui/screens/detail_screen/detail_screen.dart';

class FavoriteCard extends StatelessWidget {
  final Article article;
  final NewsBloc newsBloc;

  const FavoriteCard({this.article, this.newsBloc});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => DetailScreen(article: article, newsBloc: newsBloc,)));
              },
              child: Card(
                color: Colors.white,
                elevation: 4.0,
                margin: EdgeInsets.all(5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Padding(
                  padding: const EdgeInsets.symmetric( vertical: 6.0),
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(article.title != null ? article.title : 'Title of article!', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),),
                        
                        GestureDetector(
                          onTap: (){
                            newsBloc.add(AdditionRemoveArticleToFavorites(article));
                          },
                          child: Icon(Icons.star, color: Colors.yellow[800], size: 28.0))

                      ]
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(article.descriptions != null ? article.descriptions : 'Here is descriptions. Like it !', style: TextStyle(fontSize: 14.0),),
                        ),
                        SizedBox(height: 6.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(article.publishedAt != null ? article.publishedAt : 'time', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600),),
                            ),
                            Container(
                              
                              child: Text(article.author != null ? article.author : 'author', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600),),
                            ),
                          ],
                        )

                      ],
                    ),
                    leading: Container(
                      width: 100.0,
                      child: Image(
                        image: article.urlToImage != null ? NetworkImage(article.urlToImage) : AssetImage('assets/images/not_img.jpg'),
                      )
                    ),
                    
                  ),
                )
              ),
            );
  }
}