import 'package:flutter/material.dart';
import 'package:news_application/pages/article_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedArticlesPage extends StatefulWidget {
  const SavedArticlesPage({Key? key}) : super(key: key);

  @override
  _SavedArticlesPageState createState() => _SavedArticlesPageState();
}

class _SavedArticlesPageState extends State<SavedArticlesPage> {
  List<String> savedArticles = [];

  @override
  void initState() {
    super.initState();
    _getSavedArticles();
  }

  Future<void> _getSavedArticles() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      savedArticles = prefs.getStringList('saved_articles') ?? [];
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
          return ListTile(
            title: GestureDetector(
              onTap: () {
                // Check if the URL has a scheme
                if (Uri.parse(savedArticles[index]).scheme.isEmpty) {
                  // If the scheme is missing, add a default scheme (e.g., http)
                  savedArticles[index] = 'http://${savedArticles[index]}';
                }
                // Navigate to a new page to display the article information
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ArticleView(
                      url: savedArticles[index],
                      blogUrl: '',
                    ),
                  ),
                );
              },
              child: Text(
                savedArticles[index],
                style: const TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            // You can also implement actions like sharing or deleting articles
            // based on your requirements
          );
        },
      ),
    );
  }
}
