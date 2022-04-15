import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/daimentions.dart';

// ignore: must_be_immutable
class AppTextFaield extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hint;
  final IconData icon;
  bool isObSecure;

   AppTextFaield(
      {Key? key,
      required this.textEditingController,
      required this.hint,
      required this.icon,this.isObSecure=false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.only(left: Dimentions.width20, right: Dimentions.width20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimentions.radius15),
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              spreadRadius: 2,
              offset: const Offset(1, 1),
              color: Colors.grey.withOpacity(0.2),
            )
          ]),
      child: TextField(
        obscureText: isObSecure?true:false,
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: hint,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimentions.radius15),
            borderSide: const BorderSide(
              width: 1.0,
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimentions.radius15),
            borderSide: const BorderSide(
              width: 1.0,
              color: Colors.white,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimentions.radius15),
          ),
          prefixIcon: Icon(
            icon,
            color: AppColors.yellowColor,
          ),
        ),
      ),
    );
  }
}
