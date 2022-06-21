import 'package:deleveryapp/data/reposotory/order_repository.dart';
import 'package:deleveryapp/models/order_model.dart';
import 'package:deleveryapp/models/place_order_model.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class OrderController extends GetxController implements GetxService {
  OrderRepository orderRepository;

  bool _isLoading = false;
  late List<OrderModel> _currntOrderList;
  late List<OrderModel> _historyOrderList;

  List<OrderModel> get currntOrderList => _currntOrderList;
  List<OrderModel> get historyOrderList => _historyOrderList;

  OrderController({required this.orderRepository});
  bool get isLoading => _isLoading;

  Future<void> placeOrder(PlaceOrderBody placeholder, Function callBack) async {
    _isLoading = true;
    Response response = await orderRepository.placeOrder(placeholder);
    if (response.statusCode == 200) {
      _isLoading = false;
      String message = response.body['message'];
      String orderId = response.body['order_id'].toString();
      callBack(true, message, orderId);
    } else {
      {
        callBack(false, response.statusText!, '-1');
      }
    }
  }

  Future<void> orderList() async {
    _isLoading = true;
    Response response = await orderRepository.orderList();
    if (response.statusCode == 200) {
      _historyOrderList = [];
      _currntOrderList = [];
      response.body.forEach((order) {
        OrderModel orderModel = OrderModel.fromJson(order);
        if (orderModel.orderStatus == 'pending' ||
            orderModel.orderStatus == 'accepted' ||
            orderModel.orderStatus == 'processing' ||
            orderModel.orderStatus == 'handover' ||
            orderModel.orderStatus == 'picked_up') {
          _currntOrderList.add(orderModel);
        } else {
          _historyOrderList.add(orderModel);
        }
      });
    } else {
      _historyOrderList = [];
      _currntOrderList = [];
    }
    _isLoading = false;
    update();
  }
}
