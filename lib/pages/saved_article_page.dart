import 'package:flutter/material.dart';
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
        title: Text('Saved Articles'),
      ),
      body: ListView.builder(
        itemCount: savedArticles.length,
        itemBuilder: (context, index) {
          // Here you can display the saved articles however you like
          return ListTile(
            title: Text(savedArticles[index]),
            // You can also implement actions like sharing or deleting articles
            // based on your requirements
          );
        },
      ),
    );
  }
}
