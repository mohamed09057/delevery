import 'package:deleveryapp/base/custom_loader.dart';
import 'package:deleveryapp/pages/auth/sign_up_page.dart';
import 'package:deleveryapp/routes/route_helper.dart';
import 'package:deleveryapp/utils/colors.dart';
import 'package:deleveryapp/utils/daimentions.dart';
import 'package:deleveryapp/widgets/app_text_faield.dart';
import 'package:deleveryapp/widgets/big_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/show_custom_snackbar.dart';
import '../../controllers/auth_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController) {
      String password = passwordController.text.trim();
      String email = emailController.text.trim();

      if (email.isEmpty) {
        showCustomSnackBar("Type in your email", title: "email");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Type in your valid email", title: "valid email");
      } else if (password.isEmpty) {
        showCustomSnackBar("Type in your name", title: "password");
      } else if (password.length < 6) {
        showCustomSnackBar("Password cannot be less than six characters",
            title: "password");
      } else {
        authController.login(email, password).then((value) {
          if (value.isSuccess) {
            Get.toNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackBar(value.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(
        builder: (authController) {
          return !authController.isLoading
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Dimentions.screenHeight * 0.05,
                      ),
                      SizedBox(
                        height: Dimentions.screenHeight * 0.25,
                        child: const Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 80,
                            backgroundImage:
                                AssetImage("assets/images/logoapp2.jpg"),
                          ),
                        ),
                      ),
                      Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(
                          left: Dimentions.screenHeight * 0.05,
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello",
                                style: TextStyle(
                                  fontSize: Dimentions.font20 * 3 +
                                      Dimentions.font20 / 2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "sign into your account",
                                style: TextStyle(
                                  fontSize: Dimentions.font20,
                                  color: Colors.grey[500],
                                ),
                              )
                            ]),
                      ),
                      SizedBox(
                        height: Dimentions.height20,
                      ),
                      AppTextFaield(
                          textEditingController: emailController,
                          hint: "email",
                          icon: Icons.email),
                      SizedBox(
                        height: Dimentions.height20,
                      ),
                      AppTextFaield(
                          isObSecure: true,
                          textEditingController: passwordController,
                          hint: "password",
                          icon: Icons.password_sharp),
                      SizedBox(
                        height: Dimentions.height20,
                      ),
                      Row(
                        children: [
                          Expanded(child: Container()),
                          RichText(
                            text: TextSpan(
                              text: "already",
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: Dimentions.font20,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Dimentions.height20,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Dimentions.screenHeight * 0.05,
                      ),
                      GestureDetector(
                        onTap: () {
                          _login(authController);
                        },
                        child: Container(
                          width: Dimentions.screenWidth / 2,
                          height: Dimentions.screenHeight / 13,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimentions.radius30),
                              color: AppColors.mainColor),
                          child: Center(
                            child: BigText(
                              text: "Sign In",
                              size: Dimentions.font20 + Dimentions.font20 / 2,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimentions.screenHeight * 0.05,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Don't have an account?",
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimentions.font20,
                          ),
                          children: [
                            TextSpan(
                              text: "Don't have an account?",
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: Dimentions.font20,
                              ),
                            ),
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.to(() => const SignUpPage(),
                                    transition: Transition.fade),
                              text: "create",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.mainBlackColor,
                                fontSize: Dimentions.font15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : const CustomLoader();
        },
      ),
    );
  }
}
