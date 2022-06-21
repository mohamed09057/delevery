import 'package:deleveryapp/base/custom_button.dart';
import 'package:deleveryapp/routes/route_helper.dart';
import 'package:deleveryapp/utils/daimentions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderSuccessPage extends StatelessWidget {
  final String orderId;
  final int status;

  const OrderSuccessPage(
      {Key? key, required this.orderId, required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (status == 0) {
      Future.delayed(const Duration(seconds: 1), () {});
    }
    return Scaffold(
        body: Center(
          child: SizedBox(
            width: Dimentions.screenWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  status == 1 ? "assets/images/successed.png" : "assets/images/wrning.png",
                  width: 100,
                  height: 100,
                ),
                SizedBox(
                  height: Dimentions.height45,
                ),
                Text(
                  status == 1 ? "You placed the order successfully" : "Your order dailed",
                  style: TextStyle(
                    fontSize: Dimentions.font26,
                  ),
                ),
                SizedBox(
                  height: Dimentions.height20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimentions.height20,
                      vertical: Dimentions.height20),
                  child: Text(
                    status == 1 ? "Successfull order" : "Failed order",
                    style: TextStyle(
                        fontSize: Dimentions.font15,
                        color: Theme.of(context).disabledColor),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: Dimentions.height45,
                ),
                Padding(
                  padding: EdgeInsets.all(Dimentions.height20),
                  child: CustomButton(
                    buttonText: 'Back to home',
                    onPressed: () => Get.offAllNamed(RouteHelper.getInitial()),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
