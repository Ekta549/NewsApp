import 'package:news_application/pages/category_news.dart';

class ShowCategoryModel {
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? content;

  ShowCategoryModel(
      {this.author,
      this.content,
      this.description,
      this.title,
      this.url,
      this.urlToImage});
}
