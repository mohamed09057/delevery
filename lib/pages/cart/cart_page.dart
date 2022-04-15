import 'package:deleveryapp/controllers/auth_controller.dart';
import 'package:deleveryapp/controllers/cart_controller.dart';
import 'package:deleveryapp/controllers/popular_product_controller.dart';
import 'package:deleveryapp/controllers/recommended_product_controller.dart';
import 'package:deleveryapp/routes/route_helper.dart';
import 'package:deleveryapp/utils/app_constants.dart';
import 'package:deleveryapp/utils/colors.dart';
import 'package:deleveryapp/utils/daimentions.dart';
import 'package:deleveryapp/widgets/app_icon.dart';
import 'package:deleveryapp/widgets/big_text.dart';
import 'package:deleveryapp/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/no_data_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Dimentions.height20 * 3,
            left: Dimentions.width20,
            right: Dimentions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AppIcon(
                  iconData: Icons.arrow_back_ios,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  // size: Dimentions.iconSize,
                ),
                SizedBox(
                  width: Dimentions.width20 * 5,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.initial);
                  },
                  child: const AppIcon(
                    iconData: Icons.home_outlined,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                  ),
                ),
                const AppIcon(
                  iconData: Icons.shopping_cart_outlined,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                )
              ],
            ),
          ),
          GetBuilder<CartController>(builder: (_cartController) {
            return _cartController.getItems.isNotEmpty
                ? Positioned(
                    top: Dimentions.height20 * 6.5,
                    left: Dimentions.width20,
                    right: Dimentions.width20,
                    child: Container(
                      height: Dimentions.height45 * 21,
                      margin: EdgeInsets.only(top: Dimentions.height15),
                      child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: GetBuilder<CartController>(
                            builder: (cartController) {
                              return ListView.builder(
                                  itemCount: cartController.getItems.length,
                                  itemBuilder: (_, index) {
                                    //print(cartController.getItems);
                                    return SizedBox(
                                      height: Dimentions.height20 * 5,
                                      width: double.maxFinite,
                                      child: Row(children: [
                                        GestureDetector(
                                          onTap: () {
                                            var popularIndex = Get.find<
                                                    PopularProductController>()
                                                .popularProductList
                                                .indexOf(cartController
                                                    .getItems[index].product!);
                                            if (popularIndex >= 0) {
                                              Get.toNamed(
                                                  RouteHelper.getPopularProduct(
                                                      popularIndex,
                                                      "cartPage"));
                                            } else {
                                              var recommendedIndex = Get.find<
                                                      RecommendedProductController>()
                                                  .recommendedProductList
                                                  .indexOf(cartController
                                                      .getItems[index]
                                                      .product!);

                                              if (recommendedIndex < 0) {
                                                Get.snackbar("History Product",
                                                    "Correct Not Avalable",
                                                    backgroundColor:
                                                        AppColors.mainColor,
                                                    colorText: Colors.white);
                                              } else {
                                                Get.toNamed(RouteHelper
                                                    .getRecommendedProduct(
                                                        recommendedIndex,
                                                        "cartPage"));
                                              }
                                            }
                                          },
                                          child: Container(
                                            width: Dimentions.height20 * 5,
                                            height: Dimentions.height20 * 5,
                                            margin: EdgeInsets.only(
                                                bottom: Dimentions.height10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimentions.radius15),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      AppConstant.BASE_URL +
                                                          AppConstant
                                                              .UPLOAD_URL +
                                                          cartController
                                                              .getItems[index]
                                                              .img!)),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: Dimentions.width10,
                                        ),
                                        Expanded(
                                            child: SizedBox(
                                          height: Dimentions.height20 * 5,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              BigText(
                                                text: cartController
                                                    .getItems[index].name!,
                                                color: Colors.black54,
                                              ),
                                              const SmallText(text: "spicy"),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SmallText(
                                                      text: "\$ " +
                                                          cartController
                                                              .getItems[index]
                                                              .price
                                                              .toString(),
                                                      color: Colors.redAccent),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                Dimentions
                                                                    .radius20)),
                                                    child: Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            cartController.addItem(
                                                                cartController
                                                                    .getItems[
                                                                        index]
                                                                    .product!,
                                                                -1);
                                                          },
                                                          child: const Icon(
                                                            Icons.remove,
                                                            color: AppColors
                                                                .signColor,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              Dimentions.width5,
                                                        ),
                                                        BigText(
                                                          text: cartController
                                                              .getItems[index]
                                                              .quantity!
                                                              .toString(), //popularFoood.inCartItems.toString(),
                                                          color: AppColors
                                                              .signColor,
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              Dimentions.width5,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            cartController.addItem(
                                                                cartController
                                                                    .getItems[
                                                                        index]
                                                                    .product!,
                                                                1);
                                                          },
                                                          child: const Icon(
                                                            Icons.add,
                                                            color: AppColors
                                                                .signColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ))
                                      ]),
                                    );
                                  });
                            },
                          )),
                    ))
                : const NoDataPage(text: "Your Cart is Empty");
          }),
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (popularFoood) {
          return Container(
            height: Dimentions.bottomHeightBar,
            padding: EdgeInsets.only(
              top: Dimentions.height20,
              bottom: Dimentions.height20,
              left: Dimentions.width20,
              right: Dimentions.width20,
            ),
            decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimentions.radius20 * 2),
                    topRight: Radius.circular(Dimentions.radius20 * 2))),
            child: popularFoood.getItems.isNotEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimentions.width20,
                            vertical: Dimentions.height20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(Dimentions.radius20)),
                        child: Row(
                          children: [
                            SizedBox(
                              width: Dimentions.width5,
                            ),
                            BigText(
                              text: "\$ " + popularFoood.totalAmount.toString(),
                              color: AppColors.signColor,
                            ),
                            SizedBox(
                              width: Dimentions.width5,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimentions.width20,
                            vertical: Dimentions.height20),
                        decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius:
                                BorderRadius.circular(Dimentions.radius20)),
                        child: GestureDetector(
                          onTap: () {
                            if (Get.find<AuthController>().userIsLogined()) {
                              popularFoood.addToHistory(); 
                            } else {
                              Get.toNamed(RouteHelper.getSignInPage());
                            }
                          },
                          child: const BigText(
                            text: "Check out",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
          );
        },
      ),
    );
  }
}
