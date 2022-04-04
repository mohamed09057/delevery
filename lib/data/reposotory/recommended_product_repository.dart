import 'package:deleveryapp/data/api/api_client.dart';
import 'package:deleveryapp/utils/app_constants.dart';
import 'package:get/get.dart';

class RecommendedProductRepository extends GetxService {
  final ApiClient apiClient;
  RecommendedProductRepository({required this.apiClient});

  Future<Response> getRecommendedProductList() async {
    return await apiClient.getData(AppConstant.RECOMMANDED_PRODUCT_URL);
  }
}
