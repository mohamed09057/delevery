import 'package:deleveryapp/controllers/auth_controller.dart';
import 'package:deleveryapp/controllers/cart_controller.dart';
import 'package:deleveryapp/controllers/location_controller.dart';
import 'package:deleveryapp/controllers/user_controller.dart';
import 'package:deleveryapp/routes/route_helper.dart';
import 'package:deleveryapp/utils/colors.dart';
import 'package:deleveryapp/utils/daimentions.dart';
import 'package:deleveryapp/widgets/acount_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/custom_loader.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';

class AcountPage extends StatelessWidget {
  const AcountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userIsLogined();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
    } else {}
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        centerTitle:true,
        title: const BigText(text: "Profile", color: Colors.white),
      ),
      body: GetBuilder<UserController>(builder: (userController) {
        return _userLoggedIn
            ? (userController.isLoading == false 
                ? Container(
                    //height: 500,
                    width: double.maxFinite,
                    margin: EdgeInsets.only(top: Dimentions.height20),
                    child: Column(
                      children: [
                        AppIcon(
                          iconData: Icons.person,
                          iconSize: Dimentions.iconSize24 * 3,
                          backgroundColor: const Color.fromARGB(255, 172, 189, 187),
                          iconColor: Colors.white,
                          size: Dimentions.height30 * 5,
                        ),
                        SizedBox(height: Dimentions.height30),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                AccountWidget(
                                  appIcon: AppIcon(
                                    iconData: Icons.person,
                                    iconSize: Dimentions.height10 * 5 / 2,
                                    backgroundColor: AppColors.mainColor,
                                    iconColor: Colors.white,
                                    size: Dimentions.height10 * 5,
                                  ),
                                  bigText: BigText(
                                      text: userController.userModel.name),
                                ),
                                SizedBox(height: Dimentions.height20),
                                AccountWidget(
                                  appIcon: AppIcon(
                                    iconData: Icons.phone,
                                    iconSize: Dimentions.height10 * 5 / 2,
                                    backgroundColor: AppColors.yellowColor,
                                    iconColor: Colors.white,
                                    size: Dimentions.height10 * 5,
                                  ),
                                  bigText: BigText(
                                    text: userController.userModel.phone,
                                  ),
                                ),
                                SizedBox(height: Dimentions.height20),
                                AccountWidget(
                                  appIcon: AppIcon(
                                    iconData: Icons.email,
                                    iconSize: Dimentions.height10 * 5 / 2,
                                    backgroundColor: AppColors.yellowColor,
                                    iconColor: Colors.white,
                                    size: Dimentions.height10 * 5,
                                  ),
                                  bigText: BigText(
                                    text: userController.userModel.email,
                                  ),
                                ),
                                SizedBox(height: Dimentions.height20),
                                GetBuilder<LocationController>(
                                    builder: (locationController) {
                                  if (_userLoggedIn &&
                                      locationController.addressList.isEmpty) {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.offNamed(
                                            RouteHelper.getAddressPage());
                                      },
                                      child: AccountWidget(
                                        appIcon: AppIcon(
                                          iconData: Icons.location_on,
                                          iconSize: Dimentions.height10 * 5 / 2,
                                          backgroundColor: AppColors.mainColor,
                                          iconColor: Colors.white,
                                          size: Dimentions.height10 * 5,
                                        ),
                                        bigText: const BigText(
                                          text: "Address",
                                        ),
                                      ),
                                    );
                                  } else {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.offNamed(
                                            RouteHelper.getAddressPage());
                                      },
                                      child: AccountWidget(
                                        appIcon: AppIcon(
                                          iconData: Icons.location_on,
                                          iconSize: Dimentions.height10 * 5 / 2,
                                          backgroundColor: AppColors.mainColor,
                                          iconColor: Colors.white,
                                          size: Dimentions.height10 * 5,
                                        ),
                                        bigText: const BigText(
                                          text: "add youre address",
                                        ),
                                      ),
                                    );
                                  }
                                }),
                                SizedBox(height: Dimentions.height20),
                                AccountWidget(
                                  appIcon: AppIcon(
                                    iconData: Icons.message_outlined,
                                    iconSize: Dimentions.height10 * 5 / 2,
                                    backgroundColor: Colors.redAccent,
                                    iconColor: Colors.white,
                                    size: Dimentions.height10 * 5,
                                  ),
                                  bigText: const BigText(
                                    text: "Message",
                                  ),
                                ),
                                SizedBox(height: Dimentions.height20),
                                GestureDetector(
                                  onTap: () {
                                    if (Get.find<AuthController>()
                                        .userIsLogined()) {
                                      Get.find<AuthController>()
                                          .clearSharedData();
                                      Get.find<CartController>().clear();
                                      Get.find<CartController>()
                                          .clearCartHistory();

                                      Get.find<LocationController>()
                                          .clearAddressList();
                                      Get.offNamed(RouteHelper.getSignInPage());
                                    } else {
                                      Get.offNamed(RouteHelper.getSignInPage());
                                    }
                                  },
                                  child: AccountWidget(
                                    appIcon: AppIcon(
                                      iconData: Icons.logout,
                                      iconSize: Dimentions.height10 * 5 / 2,
                                      backgroundColor: Colors.redAccent,
                                      iconColor: Colors.white,
                                      size: Dimentions.height10 * 5,
                                    ),
                                    bigText: const BigText(
                                      text: "Logout",
                                    ),
                                  ),
                                ),
                                SizedBox(height: Dimentions.height20),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const CustomLoader())
            : Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.maxFinite,
                    height: Dimentions.height20 * 8,
                    margin: EdgeInsets.only(
                        left: Dimentions.width20, right: Dimentions.width20),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimentions.radius20),
                        image: const DecorationImage(
                            image: AssetImage("assetName"), fit: BoxFit.cover)),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getSignInPage());
                    },
                    child: Container(
                        width: double.maxFinite,
                        height: Dimentions.height20 * 5,
                        margin: EdgeInsets.only(
                            left: Dimentions.width20,
                            right: Dimentions.width20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(Dimentions.radius20),
                        ),
                        child: const Center(
                            child: BigText(
                          text: "Sign In",
                        ))),
                  )
                ],
              ));
      }),
    );
  }
}
