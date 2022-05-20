import 'package:deleveryapp/utils/daimentions.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final bool transparent;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final double? fontSize;
  final double radius;
  final IconData? icon;

  const CustomButton(
      {Key? key,
      this.onPressed,
      required this.buttonText,
       this.transparent=false,
      this.margin,
      this.height,
      this.width,
      this.fontSize,
      this.radius = 5,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
   final ButtonStyle _flateButton= TextButton.styleFrom(
      backgroundColor: onPressed==null?Theme.of(context).disabledColor:transparent?Colors.transparent:Theme.of(context).primaryColor
    ,
    minimumSize: Size(width==null?Dimentions.screenWidth:width!,height!=null?height!:50 ),
    padding: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius)
    )
    );
    return Center(child: SizedBox(
      width: width??Dimentions.screenWidth,
    height: height??50,
    child: TextButton(onPressed: onPressed,
    style: _flateButton,
    child:Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon!=null?Padding(padding: EdgeInsets.only(
          right: Dimentions.width5,
          
          ),child: Icon(icon,color: transparent?Theme.of(context).primaryColor:Theme.of(context).cardColor)):const SizedBox(),
         Text(buttonText,style:TextStyle(
           fontSize: fontSize ?? Dimentions.font15,
           color: transparent?Theme.of(context).primaryColor:Theme.of(context).cardColor
         ) ,)
      ],
    )
    ),),);
  }
}
