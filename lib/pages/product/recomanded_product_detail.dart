import 'package:deleveryapp/controllers/popular_product_controller.dart';
import 'package:deleveryapp/controllers/recommended_product_controller.dart';
import 'package:deleveryapp/utils/app_constants.dart';
import 'package:deleveryapp/utils/colors.dart';
import 'package:deleveryapp/utils/daimentions.dart';
import 'package:deleveryapp/widgets/app_icon.dart';
import 'package:deleveryapp/widgets/big_text.dart';
import 'package:deleveryapp/widgets/expandable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controller.dart';
import '../../routes/route_helper.dart';

class RecomandedProductDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const RecomandedProductDetail({Key? key, required this.pageId,required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());

    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 80,
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                            if(page=="cartPage"){
                      Get.toNamed(RouteHelper.getCartPage());
                    }else{
                      Get.toNamed(RouteHelper.getInitial());
                    }
                        },
                        child: const AppIcon(iconData: Icons.clear)),
                    // const AppIcon(iconData: Icons.shopping_cart_outlined),
                    GetBuilder<PopularProductController>(
                        builder: (popularProduct) {
                      return GestureDetector(
                        onTap: () {
                        //  if (popularProduct.totalItems >= 1) {
                            Get.toNamed(RouteHelper.cartPage);
                         // }
                        },
                        child: Stack(
                          children: [
                            const AppIcon(
                                iconData: Icons.shopping_cart_outlined),
                            popularProduct.totalItems >= 1
                                ? const Positioned(
                                    right: 0,
                                    top: 0,
                                    child: AppIcon(
                                      iconData: Icons.circle,
                                      size: 20,
                                      iconColor: Colors.transparent,
                                      backgroundColor: AppColors.mainColor,
                                    ),
                                  )
                                : Container(),
                            popularProduct.totalItems >= 1
                                ? Positioned(
                                    right: 4,
                                    top: -2,
                                    child: BigText(
                                      text: Get.find<PopularProductController>()
                                          .totalItems
                                          .toString(),
                                      size: 12,
                                      color: Colors.white,
                                    ))
                                : Container(),
                          ],
                        ),
                      );
                    }),
                  ]),
              pinned: true,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(20),
                child: Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.only(top: 5, bottom: 10),
                  child: Center(
                    child: BigText(
                      text: product.name!,
                      size: Dimentions.font26,
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(Dimentions.radius20),
                          topLeft: Radius.circular(Dimentions.radius20))),
                ),
              ),
              backgroundColor: AppColors.yellowColor,
              expandedHeight: Dimentions.screenHeight / 2.5,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  AppConstant.BASE_URL + AppConstant.UPLOAD_URL + product.img!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: Dimentions.width20, right: Dimentions.width20),
                    child: ExpandableTextWidget(text: product.description!),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: GetBuilder<PopularProductController>(
          builder: (controller) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: Dimentions.width20 * 2.5,
                      right: Dimentions.width20 * 2.5,
                      top: Dimentions.height10,
                      bottom: Dimentions.height10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.setQuantity(false);
                        },
                        child: AppIcon(
                          iconSize: Dimentions.iconSize24,
                          iconData: Icons.remove,
                          backgroundColor: AppColors.mainColor,
                          iconColor: Colors.white,
                        ),
                      ),
                      BigText(
                        text: "\$ ${product.price} "
                            " x "
                            " ${controller.inCartItems} ",
                        color: AppColors.mainBlackColor,
                        size: Dimentions.font26,
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.setQuantity(true);
                        },
                        child: AppIcon(
                          iconSize: Dimentions.iconSize24,
                          iconData: Icons.add,
                          backgroundColor: AppColors.mainColor,
                          iconColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
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
                  child: Row(
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
                            child: const Icon(Icons.favorite,
                                color: AppColors.mainColor)),
                        GestureDetector(
                          onTap: () {
                            controller.addItem(product);
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimentions.width20,
                                  vertical: Dimentions.height20),
                              decoration: BoxDecoration(
                                  color: AppColors.mainColor,
                                  borderRadius: BorderRadius.circular(
                                      Dimentions.radius20)),
                              child: BigText(
                                text: "\$ ${product.price} | Add to cart",
                                color: Colors.white,
                              )),
                        ),
                      ]),
                ),
              ],
            );
          },
        ));
  }
}
