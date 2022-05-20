import 'package:deleveryapp/data/api/api_client.dart';
import 'package:deleveryapp/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/signup_body_model.dart';

class AuthReposetory {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthReposetory({required this.apiClient, required this.sharedPreferences});
  Future<Response> registration(SignUpBody signUpBody) async {
    return await apiClient.postData(
        AppConstant.REGISTRATION_URL, signUpBody.toJson());
  }

  Future<Response> login(String phone, String password) async {
    return await apiClient.postData(
        AppConstant.LOGIN_URL, {"phone": phone, "password": password});
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstant.TOKEN, token);
    //sharedPreferences.setString("token", token);
  }

  Future<String> getUserToken() async {
    return sharedPreferences.getString(AppConstant.TOKEN) ?? "none";
  }

  bool userIsLogined() {
    return sharedPreferences.containsKey(AppConstant.TOKEN);
  }

  Future<void> saveUserNumberAndPassword(String number, String password) async {
    try {
      await sharedPreferences.setString(AppConstant.PHONE, number);
      await sharedPreferences.setString(AppConstant.PASSWORD, password);
    } catch (e) {
      rethrow;
    }
  }

  bool clearSharedData() {
    sharedPreferences.remove(AppConstant.TOKEN);
    sharedPreferences.remove(AppConstant.PASSWORD);
    sharedPreferences.remove(AppConstant.PHONE);
    apiClient.token = '';
    apiClient.updateHeader('');
    return true;
  }
}
