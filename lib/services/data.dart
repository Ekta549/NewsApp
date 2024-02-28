import 'package:news_application/models/category_model.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> category = [];
  CategoryModel categoryModel = CategoryModel();

  categoryModel.categoryName = "Business";
  categoryModel.image = "assets/images/business.jpeg";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.categoryName = "Entertainment";
  categoryModel.image = "assets/images/entertainment.jpeg";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.categoryName = "General";
  categoryModel.image = "assets/images/general.jpeg";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.categoryName = "Health";
  categoryModel.image = "assets/images/health.jpeg";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.categoryName = "Sports";
  categoryModel.image = "assets/images/sports.jpeg";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  return category;
}
