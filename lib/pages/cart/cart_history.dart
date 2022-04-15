import 'dart:convert';
import 'package:deleveryapp/base/no_data_page.dart';
import 'package:deleveryapp/controllers/cart_controller.dart';
import 'package:deleveryapp/models/cart_model.dart';
import 'package:deleveryapp/utils/app_constants.dart';
import 'package:deleveryapp/utils/colors.dart';
import 'package:deleveryapp/utils/daimentions.dart';
import 'package:deleveryapp/widgets/app_icon.dart';
import 'package:deleveryapp/widgets/big_text.dart';
import 'package:deleveryapp/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../routes/route_helper.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();
    // ignore: prefer_collection_literals
    Map<String, int> cartItemsPerOrder = Map();

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }
    List<int> cartItemsPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();

    var listCounter = 0;

    Widget timeWidget(int index) {
      var outeputDate = DateTime.now().toString();
      if (index < getCartHistoryList.length) {
        DateTime parseDate = DateFormat("yyyy-mm-dd HH:mm:ss")
            .parse(getCartHistoryList[listCounter].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat("MM/dd/yyyy hh:mm a");
        outeputDate = outputFormat.format(inputDate);
      }
      return BigText(text: outeputDate);
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: Dimentions.height20 * 6,
            color: AppColors.mainColor,
            width: double.maxFinite,
            padding: EdgeInsets.only(
                top: Dimentions.height45, bottom: Dimentions.height10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                BigText(text: "Cart History"),
                AppIcon(
                  iconData: Icons.shopping_cart_outlined,
                  iconColor: AppColors.mainColor,
                  backgroundColor: Colors.white,
                ),
              ],
            ),
          ),
          GetBuilder<CartController>(builder: (_cartController) {
            return getCartHistoryList.isNotEmpty
                ? Expanded(
                    child: Container(
                        margin: EdgeInsets.only(
                          top: Dimentions.height20,
                          left: Dimentions.height20,
                          right: Dimentions.height20,
                        ),
                        child: MediaQuery.removePadding(
                          removeTop: true,
                          context: context,
                          child: ListView(
                            children: [
                              for (int i = 0; i < itemsPerOrder.length; i++)
                                Container(
                                  height: Dimentions.height30 * 5,
                                  margin: EdgeInsets.only(
                                      bottom: Dimentions.height20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      timeWidget(listCounter),

                                      // BigText(text: getCartHistoryList[listCounter].time!),
                                      SizedBox(
                                        height: Dimentions.height10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Wrap(
                                              direction: Axis.horizontal,
                                              children: List.generate(
                                                  itemsPerOrder[i], (index) {
                                                if (listCounter <
                                                    getCartHistoryList.length) {
                                                  listCounter++;
                                                }
                                                return index <= 2
                                                    ? Container(
                                                        margin: EdgeInsets.only(
                                                            right: Dimentions
                                                                    .width10 /
                                                                2),
                                                        height: Dimentions
                                                                .height20 *
                                                            4,
                                                        width: Dimentions
                                                                .height20 *
                                                            4,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    Dimentions
                                                                            .radius15 /
                                                                        2),
                                                            image: DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image: NetworkImage(AppConstant
                                                                        .BASE_URL +
                                                                    AppConstant
                                                                        .UPLOAD_URL +
                                                                    getCartHistoryList[
                                                                            listCounter -
                                                                                1]
                                                                        .img!))),
                                                      )
                                                    : Container();
                                              })),
                                          SizedBox(
                                            height: Dimentions.height20 * 5,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                const SmallText(
                                                    text: "total",
                                                    color:
                                                        AppColors.titleColor),
                                                BigText(
                                                  text: itemsPerOrder[i]
                                                          .toString() +
                                                      " items",
                                                  color: AppColors.titleColor,
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      var orderTime =
                                                          cartOrderTimeToList();
                                                      Map<int, CartModel>
                                                          moreOurder = {};
                                                      for (int j = 0;
                                                          j <
                                                              getCartHistoryList
                                                                  .length;
                                                          j++) {
                                                        if (getCartHistoryList[
                                                                    j]
                                                                .time ==
                                                            orderTime[i]) {
                                                          moreOurder.putIfAbsent(
                                                              getCartHistoryList[
                                                                      j]
                                                                  .id!,
                                                              () => CartModel.fromJson(
                                                                  jsonDecode((jsonEncode(
                                                                      getCartHistoryList[
                                                                          j])))));
                                                        }
                                                      }
                                                      Get.find<CartController>()
                                                              .setItems =
                                                          moreOurder;
                                                      Get.find<CartController>()
                                                          .addToCartList();

                                                      Get.toNamed(RouteHelper
                                                          .getCartPage());
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  Dimentions
                                                                      .width10,
                                                              vertical: Dimentions
                                                                      .height10 /
                                                                  2),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius
                                                            .circular(Dimentions
                                                                    .radius15 /
                                                                3),
                                                        border: Border.all(
                                                          width: 1,
                                                          color: AppColors
                                                              .mainColor,
                                                        ),
                                                      ),
                                                      child: const SmallText(
                                                        text: "one more",
                                                        color:
                                                            AppColors.mainColor,
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                            ],
                          ),
                        )),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: const Center(
                        child: NoDataPage(text: "Your history is empty")));
          }),
        ],
      ),
    );
  }
}
