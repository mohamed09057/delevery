import 'package:deleveryapp/widgets/small_text.dart';
import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/daimentions.dart';
import 'big_text.dart';
import 'icon_and_text_widget.dart';

class AppColumn extends StatelessWidget {
  final String text;
    final double size;
    final int price;

  const AppColumn({Key? key,required this.text,required this.size,required this.price}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       BigText(text: text,size:size),
                       BigText(text: "\$ "+price.toString(),color: AppColors.mainColor,),
                     ],
                   ),
                  SizedBox(
                    height: Dimentions.height10,
                  ),
                  Row(children: [
                    Wrap(
                      children: List.generate(
                          5,
                          (index) => Icon(
                                Icons.star,
                                size: Dimentions.iconSize24,
                                color: AppColors.mainColor,
                              )),
                    ),
                    SizedBox(
                      width: Dimentions.width5,
                    ),
                    const SmallText(text: "4.6"),
                    SizedBox(
                      width: Dimentions.width5,
                    ),
                    const SmallText(
                      text: "1287",
                      color: AppColors.mainColor,
                    ),
                    SizedBox(
                      width: Dimentions.width5,
                    ),
                    const SmallText(text: "comments")
                  ]),
                  SizedBox(
                    height: Dimentions.height20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      IconAndTextWidget(
                        icon: Icons.circle_sharp,
                        iconColor: AppColors.iconColor1,
                        text: "Normal",
                      ),
                      IconAndTextWidget(
                        icon: Icons.location_on,
                        iconColor: AppColors.mainColor,
                        text: "1.7 km",
                      ),
                      IconAndTextWidget(
                        icon: Icons.access_time_rounded,
                        iconColor: AppColors.iconColor2,
                        text: "32 min",
                      ),
                    ],
                  ),
                ],
              );
  }
}
