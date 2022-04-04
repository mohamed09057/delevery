import 'package:deleveryapp/data/reposotory/recommended_product_repository.dart';
import 'package:get/get.dart';

import '../models/popular_product_model.dart';


class RecommendedProductController extends GetxController {
  final RecommendedProductRepository recommendedProductRepository;

  RecommendedProductController({required this.recommendedProductRepository});
  List<ProductModel> _recommendedProductList = [];
  List<ProductModel> get recommendedProductList => _recommendedProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  Future<void> getRecommendedProductList() async {
    Response response = await recommendedProductRepository.getRecommendedProductList();
    if (response.statusCode == 200) {
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {}
  }
}
