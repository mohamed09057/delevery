import 'package:deleveryapp/base/custom_loader.dart';
import 'package:deleveryapp/controllers/auth_controller.dart';
import 'package:deleveryapp/controllers/location_controller.dart';
import 'package:deleveryapp/controllers/user_controller.dart';
import 'package:deleveryapp/models/adress_model.dart';
import 'package:deleveryapp/pages/address/pic_address_map.dart';
import 'package:deleveryapp/routes/route_helper.dart';
import 'package:deleveryapp/utils/colors.dart';
import 'package:deleveryapp/utils/daimentions.dart';
import 'package:deleveryapp/widgets/app_text_faield.dart';
import 'package:deleveryapp/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  // ignore: prefer_final_fields, unused_field
  TextEditingController _adressController = TextEditingController();
  // ignore: unused_field
  final TextEditingController _contactPersonName = TextEditingController();

  // ignore: unused_field
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLoged;
  // ignore: unused_field
  CameraPosition _cameraPosition =
      const CameraPosition(target: LatLng(45.515, -122.677), zoom: 17);
  late LatLng _initialPosition = const LatLng(45.515, -122.677);

  @override
  void initState() {
    super.initState();
    _isLoged = Get.find<AuthController>().userIsLogined();
    // ignore: unnecessary_null_comparison
    if (_isLoged && Get.find<UserController>().userModel == null) {
      Get.find<UserController>().getUserInfo();
    }
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      if (Get.find<LocationController>().getAddressFromLocalStorage() == "") {
        Get.find<LocationController>()
            .saveUserAddress(Get.find<LocationController>().addressList.last);
      }

      Get.find<LocationController>().getUserAddress();

      _cameraPosition = CameraPosition(
          target: LatLng(
              double.parse(
                  Get.find<LocationController>().getAddress['latitude']),
              double.parse(
                  Get.find<LocationController>().getAddress['longitude'])));
      _initialPosition = LatLng(
          double.parse(Get.find<LocationController>().getAddress['latitude']),
          double.parse(Get.find<LocationController>().getAddress['longitude']));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Address Page"),
        centerTitle: true,
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<UserController>(builder: (userController) {
        // ignore: unnecessary_null_comparison
        if (userController.userModel != null &&
            _contactPersonName.text.isEmpty) {
          _contactPersonName.text = userController.userModel.name;
          _contactPersonNumber.text = userController.userModel.phone;
          if (Get.find<LocationController>().addressList.isNotEmpty) {
            _adressController.text =
                Get.find<LocationController>().getUserAddress().address;
          }
        }
        return userController.isLoading == false
            ? GetBuilder<LocationController>(builder: (locationController) {
                _adressController.text =
                    '${locationController.placeMark.name ?? ''}'
                    '${locationController.placeMark.locality ?? ''}'
                    '${locationController.placeMark.postalCode ?? ''}'
                    '${locationController.placeMark.country ?? ''}';
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 140,
                        width: MediaQuery.of(context).size.width,
                        margin:
                            const EdgeInsets.only(left: 5, right: 5, top: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                width: 2, color: AppColors.mainColor)),
                        child: Stack(children: [
                          GoogleMap(
                            initialCameraPosition: CameraPosition(
                                target: _initialPosition, zoom: 17),
                            onTap: (latlng) {
                              Get.toNamed(RouteHelper.getPickAddressMapPage(),
                                  arguments: PickAddressMap(
                                      fromSignup: false,
                                      fromAddress: true,
                                      googleMapController:
                                          locationController.mapController));
                            },
                            zoomControlsEnabled: false,
                            compassEnabled: false,
                            myLocationEnabled: true,
                            indoorViewEnabled: true,
                            mapToolbarEnabled: false,
                            onCameraIdle: () {
                              locationController.updatePosition(
                                  _cameraPosition, true);
                            },
                            onCameraMove: ((position) =>
                                _cameraPosition = position),
                            onMapCreated: (GoogleMapController controller) {
                              locationController.setMapController(controller);
                            },
                          ),
                        ]),
                      ),
                      SizedBox(
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, top: 20),
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  locationController.addressTypeList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    locationController
                                        .setAddressTypeIndex(index);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        right: Dimentions.width10),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Dimentions.width20,
                                        vertical: Dimentions.height10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Dimentions.radius20 / 4),
                                        color: Theme.of(context).cardColor,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey[200]!,
                                            spreadRadius: 1,
                                            blurRadius: 5,
                                          )
                                        ]),
                                    child: Icon(
                                      index == 0
                                          ? Icons.home_filled
                                          : index == 1
                                              ? Icons.work
                                              : Icons.location_on,
                                      color:
                                          locationController.addressTypeIndex ==
                                                  index
                                              ? AppColors.mainColor
                                              : Theme.of(context).disabledColor,
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                      SizedBox(
                        height: Dimentions.height20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: Dimentions.width20),
                        child: const BigText(text: "Delevery address"),
                      ),
                      SizedBox(
                        height: Dimentions.height20,
                      ),
                      AppTextFaield(
                          textEditingController: _adressController,
                          hint: "your address",
                          icon: Icons.map),
                      SizedBox(
                        height: Dimentions.height20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: Dimentions.width20),
                        child: const BigText(text: "Contact name"),
                      ),
                      SizedBox(
                        height: Dimentions.height20,
                      ),
                      AppTextFaield(
                          textEditingController: _contactPersonName,
                          hint: "your name",
                          icon: Icons.person),
                      SizedBox(
                        height: Dimentions.height20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: Dimentions.width20),
                        child: const BigText(text: "Contact number"),
                      ),
                      SizedBox(
                        height: Dimentions.height20,
                      ),
                      AppTextFaield(
                          textEditingController: _contactPersonNumber,
                          hint: "your phone number",
                          icon: Icons.phone),
                    ],
                  ),
                );
              })
            : const CustomLoader();
      }),
      bottomNavigationBar: GetBuilder<LocationController>(
        builder: (locationController) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: Dimentions.bottomHeightBar,
                padding: EdgeInsets.only(
                  top: Dimentions.height20,
                  bottom: Dimentions.height20,
                  left: Dimentions.width20,
                  right: Dimentions.width20,
                ),
                decoration: BoxDecoration(
                    color: AppColors.buttonBackgroundColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimentions.radius20 * 2),
                        topRight: Radius.circular(Dimentions.radius20 * 2))),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  GestureDetector(
                    onTap: () {
                      // controller.addItem(product);
                      AddressModel _addressModel = AddressModel(
                          addressType: locationController.addressTypeList[
                              locationController.addressTypeIndex],
                          contactPersonName: _contactPersonName.text,
                          contactPersonNumber: _contactPersonNumber.text,
                          adress: _adressController.text,
                          latitude:
                              locationController.position.latitude.toString(),
                          longitude:
                              locationController.position.longitude.toString());

                      locationController
                          .addAddress(_addressModel)
                          .then((response) {
                        if (response.isSuccess) {
                          Get.toNamed(RouteHelper.getInitial());
                          Get.snackbar("address", "added success");
                        } else {
                          Get.snackbar("address", "add faild");
                        }
                      });
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimentions.width20,
                            vertical: Dimentions.height20),
                        decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius:
                                BorderRadius.circular(Dimentions.radius20)),
                        child: const BigText(
                          text: " Save address",
                          color: Colors.white,
                        )),
                  ),
                ]),
              ),
            ],
          );
        },
      ),
    );
  }
}
