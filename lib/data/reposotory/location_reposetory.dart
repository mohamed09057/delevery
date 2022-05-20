import 'package:deleveryapp/models/adress_model.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class LocationReposetory {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  LocationReposetory(
      {required this.apiClient, required this.sharedPreferences});
  Future<Response> getAdressFromGeocoding(LatLng latLng) async {
    return await apiClient.getData(
        '${AppConstant.GEOCODE_URL}?lat=${latLng.latitude}&lng=${latLng.longitude}');
  }

  String getUserAddress() {
    return sharedPreferences.getString(AppConstant.USER_ADDRESS_URL) ?? "";
  }

  Future<Response> addAddress(AddressModel addressModel) async {
    return await apiClient.postData(
        AppConstant.ADD_ADDRESS_ADDRESS, addressModel.toJson());
  }

  Future<Response> getAddressList() async {
    return await apiClient.getData(AppConstant.ADDRESS_LIST_URL);
  }

  Future<bool> saveUserAddress(String address) async {
    apiClient.updateHeader(sharedPreferences.getString(AppConstant.TOKEN)!);
    return await sharedPreferences.setString(
        AppConstant.USER_ADDRESS_URL, address);
  }

  Future<Response> getZone(String lat, String lng) async {
    return await apiClient.getData('${AppConstant.ZONE_URL}?lat=$lat&lng=$lng');
  }
  Future<Response> searchLocation(String text)async{
    return await apiClient.getData('${AppConstant.SEARCH_LOCATION_URI}?searh_text=$text');
  }

  Future<Response> setLocation(String placeId)async{
    return await apiClient.getData('${AppConstant.PLACE_DETILS_URI}?PLACEID=$placeId');
  }
}
