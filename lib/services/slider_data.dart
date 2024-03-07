import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_application/models/slider_model.dart';

class SliderRepo {
  List<SliderModel> sliders = [];

  Future<void> getSlider() async {
    String url =
        "https://saurav.tech/NewsAPI/top-headlines/category/health/in.json";
    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      // Clear the news list before adding new articles
      sliders.clear();

      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element['description'] != null) {
          SliderModel sliderModel = SliderModel(
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
            author: element["author"],
          );
          sliders.add(sliderModel);
        }
      });
    }
  }
}
