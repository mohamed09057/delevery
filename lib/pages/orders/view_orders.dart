import 'package:deleveryapp/controllers/order_controller.dart';
import 'package:deleveryapp/models/order_model.dart';
import 'package:deleveryapp/utils/daimentions.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../utils/colors.dart';

class ViewOrder extends StatelessWidget {
  final bool isCurrent;

  const ViewOrder({Key? key, required this.isCurrent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OrderController>(builder: (orderController) {
        if (orderController.isLoading == false) {
           List<OrderModel> orderList=[];
          if (orderController.currntOrderList.isNotEmpty) {
            orderList = isCurrent
                ? orderController.currntOrderList.reversed.toList()
                : orderController.historyOrderList.reversed.toList();
          }
          return SizedBox(
            width: double.maxFinite,
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Dimentions.height10 / 2,vertical: Dimentions.height10),
              child: ListView.builder(
                  itemCount: orderList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("#order_id    " +
                                  orderList[index].id.toString()),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          color: AppColors.mainColor,
                                          borderRadius: BorderRadius.circular(
                                              Dimentions.radius20 / 4)),
                                      child: Container(
                                        margin: EdgeInsets.all(
                                            Dimentions.height10 / 2),
                                        child: Text(
                                          '${orderList[index].orderStatus}',
                                          style:
                                              const TextStyle(color: Colors.white),
                                        ),
                                      )),
                                  SizedBox(
                                    height: Dimentions.height10 / 2,
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                              Dimentions.radius20 / 4)),
                                      child: Container(
                                        margin: EdgeInsets.all(Dimentions.height10/2),
                                        child:const Text("Track order")),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: Dimentions.height10,
                          )
                        ],
                      ),
                    );
                  }),
            ),
          );
        } else {
          return const Text("");
        }
      }),
    );
  }
}
