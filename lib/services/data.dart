import 'package:news_application/models/category_model.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> category = [];

  category.add(CategoryModel(
    categoryName: "Business",
    image: "assets/images/business.jpeg",
    apiEndpoint:
        "https://saurav.tech/NewsAPI/top-headlines/category/business/in.json", // Replace with actual API endpoint
  ));

  category.add(CategoryModel(
    categoryName: "General",
    image: "assets/images/general.jpeg",
    apiEndpoint:
        "https://saurav.tech/NewsAPI/top-headlines/category/general/in.json", // Replace with actual API endpoint
  ));

  category.add(CategoryModel(
    categoryName: "Health",
    image: "assets/images/health.jpeg",
    apiEndpoint:
        "https://saurav.tech/NewsAPI/top-headlines/category/health/in.json", // Replace with actual API endpoint
  ));

  category.add(CategoryModel(
    categoryName: "Sports",
    image: "assets/images/sports.jpeg",
    apiEndpoint:
        "https://saurav.tech/NewsAPI/top-headlines/category/sports/in.json", // Replace with actual API endpoint
  ));

  return category;
}
