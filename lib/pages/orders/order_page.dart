import 'package:deleveryapp/controllers/auth_controller.dart';
import 'package:deleveryapp/pages/orders/view_orders.dart';
import 'package:deleveryapp/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/order_controller.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin {
  late TabController _tabController;
  late bool _isLogedIn;

  @override
  void initState() {
    super.initState();
    _isLogedIn = Get.find<AuthController>().userIsLogined();
    if (_isLogedIn) {
      _tabController = TabController(length: 2, vsync: this);
      Get.find<OrderController>().orderList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
        centerTitle: true,
        backgroundColor: AppColors.mainColor,
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.maxFinite,
            child: TabBar(
              controller: _tabController,
              indicatorColor: AppColors.mainColor,
              indicatorWeight: 3,
              labelColor: AppColors.mainColor,
              unselectedLabelColor: AppColors.yellowColor,
              tabs: const[
                Tab(
                  text: "Current",
                ),
                Tab(
                  text: "History",
                )
              ],
            ),
          ),
          Expanded(
              child: TabBarView(
            controller: _tabController,
            children:const [
               ViewOrder(isCurrent: true),
              ViewOrder(isCurrent: false),

            ],
          ))
        ],
      ),
    );
  }
}
