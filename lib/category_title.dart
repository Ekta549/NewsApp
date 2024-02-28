import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final image, categoryName;
  const CategoryTile({super.key, this.categoryName, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(
              image,
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
                child: Text(categoryName,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold))),
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
  String imageUrl, title, desc;
  BlogTile(
      {super.key,
      required this.desc,
      required this.imageUrl,
      required this.title});

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
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "assets/images/sports1.jpg",
                      height: 90,
                      width: 100,
                      fit: BoxFit.cover,
                    )),
                const SizedBox(
                  width: 8.0,
                ),
                Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.8,
                      child: const Text(
                          "Rui Costa outsprints breakaway to win stage 15",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                          )),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.8,
                      child:
                          const Text("Then a final kick to beat lennard kamna",
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                                fontSize: 15.0,
                              )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
