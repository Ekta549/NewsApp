import 'package:news_application/models/slider_model.dart';

List<SliderModel> getSlider() {
  List<SliderModel> slider = [];
  SliderModel categoryModel = SliderModel();

  categoryModel.image = "assets/images/business.jpeg";
  categoryModel.name = "Bow To The Authority of Silenforce";
  slider.add(categoryModel);
  categoryModel = SliderModel();

  categoryModel.image = "assets/images/entertainment.jpeg";
  categoryModel.name = "Bow To The Authority of Silenforce";
  slider.add(categoryModel);
  categoryModel = SliderModel();

  categoryModel.image = "assets/images/health.jpeg";
  categoryModel.name = "Bow To The Authority of Silenforce";
  slider.add(categoryModel);
  categoryModel = SliderModel();

  categoryModel.image = "assets/images/sports.jpeg";
  categoryModel.name = "Bow To The Authority of Silenforce";
  slider.add(categoryModel);
  categoryModel = SliderModel();

  return slider;
}
