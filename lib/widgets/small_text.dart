import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  final String text;
  final Color color;
 final  double height;
  final double size;

 const SmallText(
      {Key? key,
      required this.text,
      this.color = const Color(0xFFccc7c5),
      this.height=1.2,
      this.size = 12})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        height: height,
        color: color,
        fontSize: size,
        fontFamily: 'Cairo',
      ),
    );
  }
}
