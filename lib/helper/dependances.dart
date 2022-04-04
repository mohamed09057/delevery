import 'package:deleveryapp/controllers/popular_product_controller.dart';
import 'package:deleveryapp/data/reposotory/cart_reposotory.dart';
import 'package:deleveryapp/data/reposotory/popular_product_repository.dart';
import 'package:deleveryapp/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/cart_controller.dart';
import '../controllers/recommended_product_controller.dart';
import '../data/api/api_client.dart';
import '../data/reposotory/recommended_product_repository.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);

// Api Client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstant.BASE_URL));

// Reposotories
  Get.lazyPut(() => PopularProductRepository(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepository(apiClient: Get.find()));
  Get.lazyPut(() => CartRepository(sharedPreferences:Get.find()));

// Controllers
  Get.lazyPut(
      () => PopularProductController(popularProductRepository: Get.find()));
  Get.lazyPut(() =>
      RecommendedProductController(recommendedProductRepository: Get.find()));
  Get.lazyPut(() => CartController(cartRepository: Get.find()));
}
