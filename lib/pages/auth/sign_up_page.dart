import 'package:deleveryapp/controllers/auth_controller.dart';
import 'package:deleveryapp/models/signup_body_model.dart';
import 'package:deleveryapp/routes/route_helper.dart';
import 'package:deleveryapp/utils/colors.dart';
import 'package:deleveryapp/utils/daimentions.dart';
import 'package:deleveryapp/widgets/app_text_faield.dart';
import 'package:deleveryapp/widgets/big_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/custom_loader.dart';
import '../../base/show_custom_snackbar.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages = [
      'go.png',
      'tw.png',
      'fa.jpg',
    ];
    void _registration(AuthController authController) {
      String name = nameController.text.trim();
      String password = passwordController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();

      if (name.isEmpty) {
        showCustomSnackBar("Type in your name", title: "name");
      } else if (phone.isEmpty) {
        showCustomSnackBar("Type in your phone number", title: "phone number");
      } else if (email.isEmpty) {
        showCustomSnackBar("Type in your email", title: "email");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Type in your valid email", title: "valid email");
      } else if (password.isEmpty) {
        showCustomSnackBar("Type in your name", title: "password");
      } else if (password.length < 6) {
        showCustomSnackBar("Password cannot be less than six characters",
            title: "password");
      } else {
        SignUpBody signUpBody = SignUpBody(
            email: email, password: password, name: name, phone: phone);
        authController.registration(signUpBody).then((value) {
          if (value.isSuccess) {
            Get.offNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackBar(value.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(builder: (_authController) {
          return !_authController.isLoading
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Dimentions.screenHeight * 0.02,
                      ),
                      SizedBox(
                        height: Dimentions.screenHeight * 0.2,
                        child: const Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 80,
                            backgroundImage:
                                AssetImage("assets/images/logoapp2.jpg"),
                          ),
                        ),
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
                      AppTextFaield(
                          textEditingController: nameController,
                          hint: "name",
                          icon: Icons.person),
                      SizedBox(
                        height: Dimentions.height20,
                      ),
                      AppTextFaield(
                          textEditingController: phoneController,
                          hint: "phone",
                          icon: Icons.phone),
                      SizedBox(
                        height: Dimentions.height20,
                      ),
                      GestureDetector(
                        onTap: () {
                          _registration(_authController);
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
                              text: "SignUp",
                              size: Dimentions.font20 + Dimentions.font20 / 2,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimentions.screenHeight * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "Have an account?",
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: Dimentions.font20,
                              ),
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.back(),
                              text: " LogIn",
                              style: TextStyle(
                                color: AppColors.mainColor,
                                fontSize: Dimentions.font20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Dimentions.screenHeight * 0.05,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "SignIn using one of the folowing methods",
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimentions.font20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Wrap(
                        children: List.generate(
                            3,
                            (index) => Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage(
                                        "assets/images/" + signUpImages[index]),
                                    radius: Dimentions.radius30,
                                  ),
                                )),
                      )
                    ],
                  ),
                )
              : const CustomLoader();
        }));
  }
}
