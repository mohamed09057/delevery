// ignore_for_file: unused_field, prefer_final_fields, implementation_imports, unused_import
import 'dart:convert';
import 'package:deleveryapp/data/api/api_checker.dart';
import 'package:deleveryapp/models/response_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_webservice/src/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../data/reposotory/location_reposetory.dart';
import '../models/adress_model.dart';

class LocationController extends GetxController implements GetxService {
  LocationReposetory locationReposetory;
  LocationController({required this.locationReposetory});
  bool _loading = false;

  bool _isLoading = false;
  bool _inZone = false;
  bool _buttonDesable = true;

  bool get isLoading => _isLoading;
  bool get inZone => _inZone;
  bool get buttonDesable => _buttonDesable;

  late Position _position;
  late Position _pickPosition;
  // ignore: prefer_
  Placemark _placemark = Placemark();
  Placemark _pickPlacemark = Placemark();
  List<AddressModel> _addressList = [];
  late List<AddressModel> _allAddressList;
  List<AddressModel> get addressList => _addressList;
  List<AddressModel> get allAddressList => _allAddressList;
  List<String> _addressTypeList = ["home", "office", "others"];
  List<String> get addressTypeList => _addressTypeList;
  int _adressTypeIndex = 0;
  Placemark get placeMark => _placemark;
  Placemark get pickPlaceMark => _pickPlacemark;

  late GoogleMapController _mapController;
  GoogleMapController get mapController => _mapController;
  bool _updateAddressData = true;

  bool get loading => _loading;
  Position get position => _position;
  Position get picPosition => _pickPosition;
  int _addressTypeIndex = 0;
  int get addressTypeIndex => _addressTypeIndex;

  List<Prediction> _predictionList = [];

  bool _changeAddress = true;

  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  void updatePosition(CameraPosition position, bool fromAddress) async {
    if (_updateAddressData) {
      _loading = true;
      update();
      try {
        if (fromAddress) {
          _position = Position(
              longitude: position.target.longitude,
              latitude: position.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1);
        } else {
          _pickPosition = Position(
              longitude: position.target.longitude,
              latitude: position.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1);
        }

        ResponseModel _responseModel = await getZone(
            position.target.latitude.toString(),
            position.target.longitude.toString(),
            false);
        _buttonDesable = _responseModel.isSuccess;
        if (_changeAddress) {
          String _address = await getAdressFromGeocoding(
              LatLng(position.target.latitude, position.target.longitude));

          fromAddress
              ? _placemark = Placemark(name: _address)
              : _pickPlacemark = Placemark(name: _address);
        } else {
          _changeAddress = true;
        }
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
      _loading = false;
      update();
    } else {
      _updateAddressData = true;
    }
  }

  Future<String> getAdressFromGeocoding(LatLng latLng) async {
    String _address = "NO Address";
    Response response = await locationReposetory.getAdressFromGeocoding(latLng);

    if (response.body["status"] == "OK") {
      _address = response.body["results"][0]['formatted_address'].toString();
      //print("999999999999999999999999999"+_address);
    } else {}
    update();
    return _address;
  }

  late Map<String, dynamic> _getAddress;
  Map get getAddress => _getAddress;

  AddressModel getUserAddress() {
    late AddressModel _addressModel;
    _getAddress = jsonDecode(locationReposetory.getUserAddress());

    try {
      _addressModel = AddressModel.fromJson(
          jsonDecode(locationReposetory.getUserAddress()));
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return _addressModel;
  }

  void setAddressTypeIndex(int index) {
    _addressTypeIndex = index;
    update();
  }

  Future<ResponseModel> addAddress(AddressModel addressModel) async {
    _loading = true;
    update();
    Response response = await locationReposetory.addAddress(addressModel);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      await getAddressList();
      String message = response.body["message"];
      responseModel = ResponseModel(true, message);
      await saveUserAddress(addressModel);
    } else {
      // ignore: avoid_print
      print("no");
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }

  Future<void> getAddressList() async {
    Response response = await locationReposetory.getAddressList();
    if (response.statusCode == 200) {
      _addressList = [];
      _allAddressList = [];
      response.body.forEach((address) {
        _addressList.add(AddressModel.fromJson(address));
        _allAddressList.add(AddressModel.fromJson(address));
      });
    } else {
      _addressList = [];
      _allAddressList = [];
    }
    update();
  }

  Future<bool> saveUserAddress(AddressModel addressModel) async {
    String userAddress = jsonEncode(addressModel.toJson());
    return await locationReposetory.saveUserAddress(userAddress);
  }

  void clearAddressList() {
    _addressList = [];
    _allAddressList = [];
    update();
  }

  String getAddressFromLocalStorage() {
    return locationReposetory.getUserAddress();
  }

  void setAddressData() {
    _position = _pickPosition;
    _placemark = _pickPlacemark;
    _updateAddressData = false;
    update();
  }

  Future<ResponseModel> getZone(String lat, String lng, bool markerLoad) async {
    late ResponseModel _responseModel;
    if (markerLoad) {
      _loading = true;
    } else {
      _isLoading = true;
    }
    update();
    Response response = await locationReposetory.getZone(lat, lng);
    if (response.statusCode == 200) {
      /* if(response.body["zone _id"]!=2){
      _responseModel = ResponseModel(false, response.body["zone_id"].toString());
      _inZone = false;
       
     }else
     {*/
      _inZone = true;
      _responseModel = ResponseModel(true, response.body["zone_id"].toString());

      //}
    } else {
      _inZone = false;
      _responseModel = ResponseModel(true, response.statusText!);
    }
    if (markerLoad) {
      _loading = false;
    } else {
      _isLoading = false;
    }
    update();

    return _responseModel;
  }

  Future<List<Prediction>> searchLocation(
      BuildContext context, String text) async {
    if (text.isNotEmpty) {
      Response response = await locationReposetory.searchLocation(text);
      if (response.statusCode == 200 && response.body['status'] == 'OK') {
        _predictionList = [];
        response.body['predictions'].foreach((prediction) =>
            _predictionList.add(Prediction.fromJson(prediction)));
      } else {
        ApiChecker.checkApi(response);
      }
    }
    return _predictionList;
  }

  setLocation(
      String placeId, String address, GoogleMapController mapController) async {
    _loading = true;
    update();
    PlacesDetailsResponse detail;
    Response response = await locationReposetory.setLocation(placeId);
    detail = PlacesDetailsResponse.fromJson(response.body);
    _pickPosition = Position(
        longitude: detail.result.geometry!.location.lng,
        latitude: detail.result.geometry!.location.lng,
        timestamp: DateTime.now(),
        accuracy: 1,
        altitude: 1,
        heading: 1,
        speed: 1,
        speedAccuracy: 1);
    _pickPlacemark = Placemark(name: address);
    _changeAddress = false;
    // ignore: deprecated_member_use
    if (!mapController.isNull) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(detail.result.geometry!.location.lat,
              detail.result.geometry!.location.lat),
          zoom: 17)));
    }
    _loading = false;
    update();
  }
}
