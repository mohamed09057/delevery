import 'package:deleveryapp/data/api/api_client.dart';
import 'package:deleveryapp/models/place_order_model.dart';
import 'package:deleveryapp/utils/app_constants.dart';
import 'package:get/get.dart';

class OrderRepository {
  final ApiClient apiClient;

  OrderRepository({required this.apiClient});

 Future<Response> placeOrder(PlaceOrderBody placeOrderBody) async{
  return await  apiClient.postData(AppConstant.PLACE_ORDER_URI,placeOrderBody.toJson());
  
  }

   Future<Response> orderList() async{
  return await  apiClient.getData(AppConstant.ORDER_LIST_URI);
  
  }
}
