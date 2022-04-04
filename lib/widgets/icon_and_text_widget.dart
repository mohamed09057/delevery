import 'package:deleveryapp/utils/daimentions.dart';
import 'package:deleveryapp/widgets/small_text.dart';
import 'package:flutter/material.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;

  const IconAndTextWidget(
      {Key? key,
      required this.icon,
      required this.text,
      required this.iconColor,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon,color: iconColor,size: Dimentions.iconSize24,),
        SizedBox(width: Dimentions.width5,),
        SmallText(text: text)
      ],
    );
  }
}
