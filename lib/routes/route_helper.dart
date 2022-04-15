import 'package:deleveryapp/pages/auth/login_page.dart';
import 'package:deleveryapp/pages/cart/cart_page.dart';
import 'package:deleveryapp/pages/home/home_page.dart';
import 'package:get/get.dart';
import '../pages/product/popular_product_detail.dart';
import '../pages/product/recomanded_product_detail.dart';
import '../pages/splash/splash_page.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String popularProduct = "/popular-product";
  static const String recommendedProduct = "/recommended-product";
  static const String cartPage = "/cart-page";
  static const String signInPage = "/signin-page";

  static String getSplashPage() => splashPage;
  static String getInitial() => initial;
  static String getPopularProduct(int pageId, String page) =>
      "$popularProduct?pageId=$pageId&page=$page";
  static String getRecommendedProduct(int pageId, String page) =>
      "$recommendedProduct?pageId=$pageId&page=$page";
  static String getCartPage() => cartPage;
  static String getSignInPage() => signInPage;

  static List<GetPage> routes = [
    GetPage(
        name: splashPage,
        page: () => const SplashPage(),
        transition: Transition.fadeIn),

        GetPage(
        name: signInPage,
        page: () => const LoginPage(),
        transition: Transition.fadeIn),

    GetPage(
        name: initial,
        page: () => const HomePage(),
        transition: Transition.fadeIn),
    GetPage(
        name: popularProduct,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return PopularProductDetail(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendedProduct,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return RecomandedProductDetail(
              pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: cartPage,
        page: () => const CartPage(),
        transition: Transition.fadeIn),
  ];
}
