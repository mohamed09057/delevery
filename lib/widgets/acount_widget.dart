import 'package:deleveryapp/utils/daimentions.dart';
import 'package:flutter/material.dart';
import 'app_icon.dart';
import 'big_text.dart';

// ignore: must_be_immutable
class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;
  AccountWidget({Key? key, required this.appIcon, required this.bigText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: Dimentions.width20,
        top: Dimentions.height10,
        right: Dimentions.width10,
      ),
      child: Row(
          children: [appIcon, SizedBox(width: Dimentions.width20), bigText]),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            blurRadius: 1,
            offset: Offset(0, Dimentions.width5),
            color: Colors.grey.withOpacity(0.2)),
      ]),
    );
  }
}
