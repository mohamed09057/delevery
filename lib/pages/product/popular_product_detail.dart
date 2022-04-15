import 'package:deleveryapp/controllers/cart_controller.dart';
import 'package:deleveryapp/controllers/popular_product_controller.dart';
import 'package:deleveryapp/routes/route_helper.dart';
import 'package:deleveryapp/utils/app_constants.dart';
import 'package:deleveryapp/utils/daimentions.dart';
import 'package:deleveryapp/widgets/app_column.dart';
import 'package:deleveryapp/widgets/expandable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';

class PopularProductDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const PopularProductDetail({Key? key, required this.pageId ,required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              height: Dimentions.popularProductImageSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(AppConstant.BASE_URL +
                      AppConstant.UPLOAD_URL +
                      product.img!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: Dimentions.height45,
            left: Dimentions.width20,
            right: Dimentions.width20,
            child: Row(
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
                  child: const AppIcon(iconData: Icons.arrow_back),
                ),
                GetBuilder<PopularProductController>(builder: (popularProduct) {
                  return GestureDetector(
                    onTap: () {
                        Get.toNamed(RouteHelper.cartPage);
                      
                    },
                    child: Stack(
                      children: [
                        const AppIcon(iconData: Icons.shopping_cart_outlined),
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
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
          Positioned(
            top: Dimentions.popularProductImageSize - 20,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(
                  left: Dimentions.width20,
                  right: Dimentions.width20,
                  top: Dimentions.height20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimentions.radius20),
                      topRight: Radius.circular(Dimentions.radius20))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(
                    text: product.name!,
                    price: product.price!,
                    size: Dimentions.font26,
                  ),
                  SizedBox(
                    height: Dimentions.height20,
                  ),
                  const BigText(text: "intrduse"),
                  SizedBox(
                    height: Dimentions.height20,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ExpandableTextWidget(
                        text: product.description!,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
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
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            popularFoood.setQuantity(false);
                          },
                          child: const Icon(
                            Icons.remove,
                            color: AppColors.signColor,
                          ),
                        ),
                        SizedBox(
                          width: Dimentions.width5,
                        ),
                        BigText(
                          text: popularFoood.inCartItems.toString(),
                          color: AppColors.signColor,
                        ),
                        SizedBox(
                          width: Dimentions.width5,
                        ),
                        GestureDetector(
                          onTap: () {
                            popularFoood.setQuantity(true);
                          },
                          child: const Icon(
                            Icons.add,
                            color: AppColors.signColor,
                          ),
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
                          popularFoood.addItem(product);
                        },
                        child: BigText(
                          text: "\$ ${product.price} | Add to cart",
                          color: Colors.white,
                        ),
                      )),
                ]),
          );
        },
      ),
    );
  }
}
