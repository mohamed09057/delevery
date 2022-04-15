import 'package:deleveryapp/data/api/api_client.dart';
import 'package:deleveryapp/utils/app_constants.dart';
import 'package:get/get.dart';

class UserRepository {
  final ApiClient apiClient;
  UserRepository({required this.apiClient});
  Future<Response> getUserInfo() async {
    return await apiClient.getData(AppConstant.USER_INFO_URL);
  }
}
