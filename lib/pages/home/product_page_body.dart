import 'package:deleveryapp/controllers/popular_product_controller.dart';
import 'package:deleveryapp/routes/route_helper.dart';
import 'package:deleveryapp/utils/app_constants.dart';
import 'package:deleveryapp/utils/colors.dart';
import 'package:deleveryapp/utils/daimentions.dart';
import 'package:deleveryapp/widgets/big_text.dart';
import 'package:deleveryapp/widgets/small_text.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../models/popular_product_model.dart';
import '../../widgets/app_column.dart';
import '../../widgets/icon_and_text_widget.dart';

class ProductPageBody extends StatefulWidget {
  const ProductPageBody({Key? key}) : super(key: key);

  @override
  State<ProductPageBody> createState() => _ProductPageBodyState();
}

class _ProductPageBodyState extends State<ProductPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _curruntPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = Dimentions.pageViewContainer;
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _curruntPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return popularProducts.isLoaded
              ? SizedBox(
                  height: Dimentions.pageView,
                  child: PageView.builder(
                      itemCount: popularProducts.popularProductList.length,
                      controller: pageController,
                      itemBuilder: (context, position) {
                        return _buildPageItem(position,
                            popularProducts.popularProductList[position]);
                      }),
                )
              // ignore: prefer_const_constructors
              : const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.mainColor,
                  ),
                );
        }),

        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return //Dots
              DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty
                ? 1
                : popularProducts.popularProductList.length,
            position: _curruntPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              shape: const Border(),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        //First Container
        SizedBox(
          height: Dimentions.height30,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimentions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const BigText(text: "Recommended"),
              SizedBox(
                width: Dimentions.width10,
              ),
              Container(
                  margin: const EdgeInsets.only(bottom: 2),
                  child: const BigText(text: ".")),
              SizedBox(
                width: Dimentions.width10,
              ),
              Container(
                  margin: const EdgeInsets.only(bottom: 3),
                  child: const SmallText(text: "product pairing"))
            ],
          ),
        ),

        GetBuilder<RecommendedProductController>(
            builder: (recommendedProducts) {
          return recommendedProducts.isLoaded
              ? ListView.builder(
                  itemCount: recommendedProducts.recommendedProductList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(
                            RouteHelper.getRecommendedProduct(index, "home"));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: Dimentions.width20,
                            right: Dimentions.width20,
                            bottom: Dimentions.width10),
                        child: Row(
                          children: [
                            Container(
                              width: Dimentions.listViewImageSize,
                              height: Dimentions.listViewImageSize,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                      Dimentions.radius20),
                                  image: DecorationImage(
                                      image: NetworkImage(AppConstant.BASE_URL +
                                          AppConstant.UPLOAD_URL +
                                          recommendedProducts
                                              .recommendedProductList[index]
                                              .img!),
                                      fit: BoxFit.cover)),
                            ),
                            Expanded(
                              child: Container(
                                height: Dimentions.listViewTextSize,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topRight:
                                        Radius.circular(Dimentions.radius20),
                                    bottomRight:
                                        Radius.circular(Dimentions.radius20),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: Dimentions.width10,
                                      right: Dimentions.width10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          BigText(
                                              text: recommendedProducts
                                                  .recommendedProductList[index]
                                                  .name!),
                                          BigText(
                                              text: "\$ " +
                                                  recommendedProducts
                                                      .recommendedProductList[
                                                          index]
                                                      .price!
                                                      .toString(),
                                              color: AppColors.mainColor),
                                        ],
                                      ),
                                      SizedBox(
                                        height: Dimentions.height10,
                                      ),
                                      const SmallText(text: "2df1h112 1hf12"),
                                      SizedBox(
                                        height: Dimentions.height10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          IconAndTextWidget(
                                            icon: Icons.circle_sharp,
                                            iconColor: AppColors.iconColor1,
                                            text: "Normal",
                                          ),
                                          IconAndTextWidget(
                                            icon: Icons.location_on,
                                            iconColor: AppColors.mainColor,
                                            text: "1.7 km",
                                          ),
                                          IconAndTextWidget(
                                            icon: Icons.access_time_rounded,
                                            iconColor: AppColors.iconColor2,
                                            text: "32 min",
                                          ),
                                        ],
                                      ),
                                    ],
                                    
                                  ),
                                ),
                              ),
                            ),
                            
                          ],
                        ),
                      ),
                    );
                  })
              : const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.mainColor,
                  ),
                );
        }),
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct) {
    Matrix4 matrix4 = Matrix4.identity();
    if (index == _curruntPageValue.floor()) {
      var currentScale = 1 - (_curruntPageValue - index) * (1 - _scaleFactor);
      var currentTrans = _height * (1 - currentScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (index == _curruntPageValue.floor() + 1) {
      var currentScale =
          _scaleFactor + (_curruntPageValue - index + 1) * (1 - _scaleFactor);
      var currentTrans = _height * (1 - currentScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (index == _curruntPageValue.floor() - 1) {
      var currentScale = 1 - (_curruntPageValue - index) * (1 - _scaleFactor);
      var currentTrans = _height * (1 - currentScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else {
      var currentScale = 0.8;

      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 0);
    }
    return Transform(
      transform: matrix4,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularProduct(index, "home"));
            },
            child: Container(
              margin: EdgeInsets.only(
                  left: Dimentions.width10, right: Dimentions.width10),
              height: Dimentions.pageViewContainer,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimentions.radius30),
                  color: index.isEven ? Colors.blue : Colors.black,
                  image: DecorationImage(
                      image: NetworkImage(AppConstant.BASE_URL +
                          AppConstant.UPLOAD_URL +
                          popularProduct.img!),
                      fit: BoxFit.cover)),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(
                  left: Dimentions.width30,
                  right: Dimentions.width30,
                  bottom: Dimentions.width30),
              height: Dimentions.pageViewTextContainer,
              padding: EdgeInsets.only(
                  left: Dimentions.width10,
                  right: Dimentions.width10,
                  top: Dimentions.height10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimentions.radius20),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 5.0,
                        offset: Offset(0, 5)),
                    BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                    BoxShadow(color: Colors.white, offset: Offset(0, 5))
                  ]),
              child: AppColumn(
                text: popularProduct.name!,
                price: popularProduct.price!,
                size: Dimentions.font20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
