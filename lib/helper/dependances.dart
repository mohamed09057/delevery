import 'package:deleveryapp/controllers/location_controller.dart';
import 'package:deleveryapp/controllers/order_controller.dart';
import 'package:deleveryapp/controllers/popular_product_controller.dart';
import 'package:deleveryapp/data/reposotory/auth_reposetory.dart';
import 'package:deleveryapp/data/reposotory/cart_reposotory.dart';
import 'package:deleveryapp/data/reposotory/location_reposetory.dart';
import 'package:deleveryapp/data/reposotory/popular_product_repository.dart';
import 'package:deleveryapp/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/auth_controller.dart';
import '../controllers/cart_controller.dart';
import '../controllers/recommended_product_controller.dart';
import '../controllers/user_controller.dart';
import '../data/api/api_client.dart';
import '../data/reposotory/order_repository.dart';
import '../data/reposotory/recommended_product_repository.dart';
import '../data/reposotory/user_repository.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);

// Api Client
  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstant.BASE_URL, sharedPreferences: Get.find()));
  Get.lazyPut(() =>
      AuthReposetory(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepository(apiClient: Get.find()));

// Reposotories
  Get.lazyPut(() => PopularProductRepository(apiClient: Get.find()));
  Get.lazyPut(() => AuthController(authReposetory: Get.find()));

  Get.lazyPut(() => RecommendedProductRepository(apiClient: Get.find()));
  Get.lazyPut(() => CartRepository(sharedPreferences: Get.find()));
  Get.lazyPut(() =>
      LocationReposetory(apiClient: Get.find(), sharedPreferences: Get.find()));

 Get.lazyPut(() =>OrderRepository(apiClient: Get.find()));

// Controllers
  Get.lazyPut(
      () => PopularProductController(popularProductRepository: Get.find()));
  Get.lazyPut(() =>
      RecommendedProductController(recommendedProductRepository: Get.find()));
  Get.lazyPut(() => CartController(cartRepository: Get.find()));
  Get.lazyPut(() => UserController(userRepository: Get.find()));
  Get.lazyPut(() => LocationController(locationReposetory: Get.find()));
  Get.lazyPut(() => OrderController(orderRepository: Get.find()));

}
