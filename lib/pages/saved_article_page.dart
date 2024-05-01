import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_application/models/article_model.dart';
import 'package:news_application/pages/article_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedArticlesPage extends StatefulWidget {
  const SavedArticlesPage({Key? key}) : super(key: key);

  @override
  _SavedArticlesPageState createState() => _SavedArticlesPageState();
}

class _SavedArticlesPageState extends State<SavedArticlesPage> {
  List<ArticleModel> savedArticles = [];

  @override
  void initState() {
    super.initState();
    _getSavedArticles();
  }

  Future<void> _getSavedArticles() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      savedArticles = prefs
          .getStringList('saved_articles')!
          .map((e) => ArticleModel.fromJson(jsonDecode(e)))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Articles'),
      ),
      body: ListView.builder(
        itemCount: savedArticles.length,
        itemBuilder: (context, index) {
          // Here you can display the saved articles however you like
          return BlogTile(
            articleModel: savedArticles[index],
          );
        },
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final ArticleModel articleModel;

  const BlogTile({
    Key? key,
    required this.articleModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleView(
              blogUrl: articleModel.url!,
              url: '',
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Material(
            elevation: 3.0,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 5.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: articleModel.urlToImage!,
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          articleModel.title!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          articleModel.content!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () {
                      _shareArticle(
                          context, articleModel.url, articleModel.title);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _shareArticle(BuildContext context, String? url, String? title) {
    Share.share(url ?? '', subject: title);
  }
}
