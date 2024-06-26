import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_application/models/show_category.dart';
import 'package:news_application/pages/article_view.dart';
import 'package:news_application/services/show_category_news.dart';

class CategoryNews extends StatefulWidget {
  final String url, name;

  const CategoryNews({super.key, required this.url, required this.name});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ShowCategoryModel> categories = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    getNews();
  }

  getNews() async {
    ShowCategoryNews showCategoryNews = ShowCategoryNews();
    await showCategoryNews.getCategoriesNews(widget.url, widget.name);
    categories = showCategoryNews.categories;

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'NewsUpdates',
          style: TextStyle(
              color: Color.fromARGB(255, 21, 22, 23),
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: categories.length,
          itemBuilder: ((context, index) {
            return ShowCategory(
              image: categories[index].urlToImage!,
              desc: categories[index].description!,
              title: categories[index].title!,
              url: categories[index].url!,
            );
          }),
        ),
      ),
    );
  }
}

class ShowCategory extends StatelessWidget {
  String image, desc, title, url;
  ShowCategory(
      {super.key,
      required this.image,
      required this.desc,
      required this.title,
      required this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                      blogUrl: url,
                      url: '',
                    )));
      },
      child: Container(
          child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: image,
              width: MediaQuery.of(context).size.width,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            title,
            maxLines: 2,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 10.0,
                fontWeight: FontWeight.bold),
          ),
          Text(
            desc,
            maxLines: 3,
          ),
          const SizedBox(
            height: 20.0,
          ),
        ],
      )),
    );
  }
}
