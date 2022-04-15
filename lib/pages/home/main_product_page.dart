import 'package:deleveryapp/pages/home/product_page_body.dart';
import 'package:deleveryapp/utils/colors.dart';
import 'package:deleveryapp/utils/daimentions.dart';
import 'package:deleveryapp/widgets/big_text.dart';
import 'package:deleveryapp/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';

class MainProductPage extends StatefulWidget {
  const MainProductPage({Key? key}) : super(key: key);

  @override
  State<MainProductPage> createState() => _MainProductPageState();
}

class _MainProductPageState extends State<MainProductPage> {

    Future<void> _loadResources() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }
  @override
  Widget build(BuildContext context) {
    // var productPageBody = ProductPageBody;
    return RefreshIndicator(
        child: Column(
          children: [
            // Main Page Header
            Container(
              margin: EdgeInsets.only(
                  top: Dimentions.height45, bottom: Dimentions.width15),
              padding: EdgeInsets.only(
                  left: Dimentions.width20, right: Dimentions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const BigText(
                          text: "KHARTOUM", color: AppColors.mainColor),
                      Row(
                        children: [
                          SmallText(
                            text: "bahry",
                            color: Colors.black54,
                            size: Dimentions.font15,
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            size: Dimentions.iconSize24,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      width: Dimentions.height45,
                      height: Dimentions.height45,
                      decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius:
                              BorderRadius.circular(Dimentions.radius15)),
                      child: Icon(
                        Icons.search,
                        color: AppColors.buttonBackgroundColor,
                        size: Dimentions.iconSize24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Main Page Body
            const Expanded(
                child: SingleChildScrollView(
              child: ProductPageBody(),
            ))
          ],
        ),
        onRefresh: _loadResources);
  }
}
