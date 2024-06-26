import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:news_application/models/article_model.dart';
import 'package:news_application/models/category_model.dart';
import 'package:news_application/models/slider_model.dart';
import 'package:news_application/pages/article_view.dart';
import 'package:news_application/pages/category_news.dart';
import 'package:news_application/pages/saved_article_page.dart';
import 'package:news_application/services/data.dart';
import 'package:news_application/services/news.dart';
import 'package:news_application/services/slider_data.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = [];
  List<SliderModel> sliders = [];
  List<ArticleModel> articles = [];
  bool _loading = true;

  int activeIndex = 0;
  String weather = ''; // Weather information

  @override
  void initState() {
    categories = getCategories();
    getSlider();
    getNews();
    fetchWeather();
    super.initState();
  }

  Future<void> fetchWeather() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://api.open-meteo.com/v1/forecast?latitude=12.9716&longitude=77.5946&current=temperature_2m',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final temperature = data['current']['temperature_2m'];
        setState(() {
          weather = 'Temperature: ${temperature.toString()}°C';
        });
      } else {
        setState(() {
          weather = 'Failed to fetch weather data';
        });
      }
    } catch (e) {
      setState(() {
        weather = 'Error: $e';
      });
    }
  }

  getNews() async {
    News newsclass = News();
    await newsclass.getNews();

    setState(() {
      _loading = false;
      articles = newsclass.news;
    });
  }

  getSlider() async {
    SliderRepo slider = SliderRepo();
    await slider.getSlider();
    sliders = slider.sliders;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "DailyInfo",
              style: TextStyle(
                  color: Color.fromARGB(255, 13, 14, 15),
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(weather), // Display weather information here
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10.0),
                    height: 50,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return CategoryTile(
                          image: categories[index].image,
                          categoryName: categories[index].categoryName,
                          url: categories[index].apiEndpoint,
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Breaking News!",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  CarouselSlider.builder(
                    itemCount: sliders.length,
                    itemBuilder: (context, index, realIndex) {
                      if (sliders.isNotEmpty && index < sliders.length) {
                        String? res = sliders[index].urlToImage;
                        String? res1 = sliders[index].title;

                        return buildImage(res!, index, res1!);
                      } else {
                        return Container();
                      }
                    },
                    options: CarouselOptions(
                      height: 200,
                      viewportFraction: 0.7,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      onPageChanged: (index, reason) {
                        setState(() {
                          activeIndex = index;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: buildIndicator(),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Trending News!",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: 20,
                    itemBuilder: ((context, index) {
                      return BlogTile(
                        articleModel: articles[index],
                      );
                    }),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
    );
  }

  Widget buildImage(String image, int index, String name) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Stack(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              height: 250,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              imageUrl: image,
            ),
          ),
          Container(
            height: 250,
            padding: const EdgeInsets.only(left: 10.0),
            margin: const EdgeInsets.only(top: 130.0),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                )),
            child: Text(
              name,
              maxLines: 2,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ]),
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: 5,
        effect: const ScaleEffect(
            dotWidth: 10, dotHeight: 10, activeDotColor: Colors.blue),
      );
}

class CategoryTile extends StatelessWidget {
  final String? image;
  final categoryName;
  final String? url;

  const CategoryTile({
    Key? key,
    required this.categoryName,
    required this.image,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryNews(
                      url: url!,
                      name: '',
                    )));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                image!,
                width: 120,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: 120,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black38,
              ),
              child: Center(
                child: Text(
                  categoryName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('image', image));
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
                          articleModel.title ?? "",
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
                          articleModel.content ?? "",
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
                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.save),
                        onPressed: () {
                          _saveArticle(context, articleModel);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.share),
                        onPressed: () {
                          _shareArticle(
                            context,
                            articleModel.url,
                            articleModel.title,
                          );
                        },
                      ),
                    ],
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

  void _saveArticle(BuildContext context, ArticleModel articleModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<ArticleModel> savedArticles = prefs
            .getStringList('saved_articles')
            ?.map((e) => ArticleModel.fromJson(jsonDecode(e)))
            .toList() ??
        [];
    if (!(savedArticles.any((e) => e.urlToImage == articleModel.urlToImage))) {
      savedArticles?.add(articleModel);
      prefs.setStringList('saved_articles',
          savedArticles!.map((e) => jsonEncode(e.toJson())).toList());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Article saved for later.'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Article is already saved.'),
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SavedArticlesPage()),
      );
    }
  }
}
