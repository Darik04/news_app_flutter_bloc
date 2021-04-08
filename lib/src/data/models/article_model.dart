class Article {

  final String title;
  final String descriptions;
  final String urlToImage;
  final String url;
  final String publishedAt;
  final String content;
  final String author;
  

  Article({this.title, this.descriptions, this.urlToImage, this.url, this.publishedAt, this.content, this.author});

  factory Article.fromJson(Map<String,dynamic> json){
    return Article(
 
        title:  json['title'],
        descriptions: json['description'],
        urlToImage: json['urlToImage'],
        url: json['url'],
        publishedAt: json['publishedAt'],
        content: json['content'],
        author: json['author']
    );
  }
} 