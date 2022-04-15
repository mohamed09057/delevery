import 'package:deleveryapp/utils/colors.dart';
import 'package:deleveryapp/utils/daimentions.dart';
import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: Dimentions.height20*5,
        width: Dimentions.height20*5,
        decoration: BoxDecoration(
          color: AppColors.mainColor,
          borderRadius: BorderRadius.circular(Dimentions.height20*5/2),

        ),
        alignment: Alignment.center,
        child: const CircularProgressIndicator(color: Colors.white,),
      ),
    );
  }
}