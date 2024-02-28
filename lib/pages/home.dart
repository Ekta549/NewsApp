import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:news_application/models/article_model.dart';
import 'package:news_application/models/category_model.dart';
import 'package:news_application/models/slider_model.dart';
import 'package:news_application/services/data.dart';
import 'package:news_application/services/news.dart';
import 'package:news_application/services/slider_data.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
  @override
  void initState() {
    categories = getCategories();
    sliders = getSlider();
    getNews();
    super.initState();
  }

  getNews() async {
    News newsclass = News();
    await newsclass.getNews();
    setState(() {
      _loading = false;
      articles = newsclass.news;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Flutter"),
          Text(
            "News",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          )
        ]),
        centerTitle: true,
        elevation: 0.0,
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
                          );
                        }),
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
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text("View All",
                                style: TextStyle(
                                  color: Colors.blue,
                                )),
                          ])),
                  const SizedBox(
                    height: 20.0,
                  ),
                  CarouselSlider.builder(
                    itemCount: sliders.length,
                    itemBuilder: (context, index, realIndex) {
                      String? res = sliders[index].image;
                      String? res1 = sliders[index].name;

                      return buildImage(res!, index, res1!);
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
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text("View All",
                              style: TextStyle(
                                color: Color.fromARGB(255, 141, 168, 189),
                              )),
                        ]),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: articles.length,
                      itemBuilder: ((context, index) {
                        return BlogTile(
                            desc: articles[index].description!,
                            imageUrl: articles[index].urlToImage!,
                            title: articles[index].title!);
                      }),
                    ),
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
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                image,
                height: 250,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
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
                ),
              ),
              child: Text(
                name,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      );
  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: sliders.length,
        effect: const ScaleEffect(
            dotWidth: 10, dotHeight: 10, activeDotColor: Colors.blue),
      );
}

class CategoryTile extends StatelessWidget {
  final String? image;
  final categoryName;
  const CategoryTile(
      {Key? key, required this.categoryName, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          )
        ],
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
  final String imageUrl;
  final String title;
  final String desc;
  const BlogTile({
    Key? key,
    required this.desc,
    required this.imageUrl,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      height: 90,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Column(children: [
                  Container(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.8,
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.8,
                      child: Text(
                        desc,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
