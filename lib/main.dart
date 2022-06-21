import 'package:deleveryapp/controllers/cart_controller.dart';
import 'package:deleveryapp/controllers/order_controller.dart';
import 'package:deleveryapp/controllers/popular_product_controller.dart';
import 'package:deleveryapp/controllers/user_controller.dart';
import 'package:deleveryapp/routes/route_helper.dart';
import 'package:deleveryapp/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/recommended_product_controller.dart';
import 'helper/dependances.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  Get.find<UserController>().getUserInfo();
  Get.find<OrderController>().orderList();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(
      builder: (_) {
        return GetBuilder<RecommendedProductController>(builder: (_) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'DELFOO',
            initialRoute: RouteHelper.getSplashPage(),
            getPages: RouteHelper.routes,
            theme: ThemeData(
              primaryColor: AppColors.mainColor,
              fontFamily: "Cairo",
            ),
          );
        });
      },
    );
  }
}
