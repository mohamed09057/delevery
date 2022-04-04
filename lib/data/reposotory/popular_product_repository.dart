import 'package:deleveryapp/data/api/api_client.dart';
import 'package:deleveryapp/utils/app_constants.dart';
import 'package:get/get.dart';

class PopularProductRepository extends GetxService {
  final ApiClient apiClient;
  PopularProductRepository({required this.apiClient});

  Future<Response> getPopularProductList() async {
    return await apiClient.getData(AppConstant.POPULAR_PRODUCT_URL);
  }
}
