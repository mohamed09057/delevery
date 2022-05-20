import 'package:deleveryapp/base/custom_button.dart';
import 'package:deleveryapp/pages/address/widgets/search_location_page.dart';
import 'package:deleveryapp/routes/route_helper.dart';
import 'package:deleveryapp/utils/colors.dart';
import 'package:deleveryapp/utils/daimentions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../controllers/location_controller.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSignup;
  final bool fromAddress;
  final GoogleMapController? googleMapController;

  const PickAddressMap(
      {Key? key,
      required this.fromSignup,
      required this.fromAddress,
      this.googleMapController})
      : super(key: key);

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initialPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;

  @override
  void initState() {
    super.initState();
    if (Get.find<LocationController>().addressList.isEmpty) {
      _initialPosition = const LatLng(45.24165, -122.3545355);
      _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
    } else {
      if (Get.find<LocationController>().addressList.isNotEmpty) {
        _initialPosition = LatLng(
            double.parse(Get.find<LocationController>().getAddress["latitude"]),
            double.parse(
                Get.find<LocationController>().getAddress["longitude"]));
        _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: SizedBox(
                width: double.maxFinite,
                child: Stack(
                  children: [
                    GoogleMap(
                      initialCameraPosition:
                          CameraPosition(target: _initialPosition, zoom: 17),
                      zoomControlsEnabled: false,
                      onCameraMove: (CameraPosition cameraPosition) {
                        _cameraPosition = cameraPosition;
                      },
                      onCameraIdle: () {
                        Get.find<LocationController>()
                            .updatePosition(_cameraPosition, false);
                      },
                      onMapCreated: (GoogleMapController mapController) {
                        _mapController = mapController;
                        if (!widget.fromAddress) {}
                      },
                    ),
                    Center(
                        child: locationController.loading == false
                            ? Image.asset(
                                "assets/images/pickMarker.png",
                                height: 50,
                                width: 50,
                              )
                            : const CircularProgressIndicator()),
                    Positioned(
                      left: Dimentions.width20,
                      right: Dimentions.width20,
                      top: Dimentions.height45,
                      child: InkWell(
                        onTap: () {
                          Get.dialog(
                              LocationDialog(mapController: _mapController));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimentions.width10),
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius:
                                BorderRadius.circular(Dimentions.radius15),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 25,
                                color: AppColors.yellowColor,
                              ),
                              Expanded(
                                child: Text(
                                  locationController.pickPlaceMark.name ?? '',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Dimentions.font15 + 2,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                width: Dimentions.width10,
                              ),
                              const Icon(
                                Icons.search,
                                size: 25,
                                color: AppColors.yellowColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 50,
                        right: Dimentions.width20,
                        left: Dimentions.width20,
                        child: locationController.isLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : CustomButton(
                                buttonText: locationController.inZone == false
                                    ? widget.fromAddress
                                        ? 'Pick address'
                                        : 'Pick location'
                                    : 'Service is not abalanle in this area',
                                onPressed: locationController.buttonDesable ==
                                            false ||
                                        locationController.loading
                                    ? () {}
                                    : () {
                                        if (locationController
                                                    .picPosition.latitude !=
                                                0 &&
                                            locationController
                                                    .pickPlaceMark.name !=
                                                null) {
                                          if (widget.fromAddress) {
                                            if (widget.googleMapController !=
                                                null) {
                                              widget.googleMapController!.moveCamera(
                                                  CameraUpdate.newCameraPosition(
                                                      CameraPosition(
                                                          target: LatLng(
                                                              locationController
                                                                  .picPosition
                                                                  .latitude,
                                                              locationController
                                                                  .picPosition
                                                                  .longitude))));
                                              locationController
                                                  .setAddressData();
                                            }
                                            Get.toNamed(
                                                RouteHelper.getAddressPage());
                                          }
                                        }
                                      },
                              ))
                  ],
                )),
          ),
        ),
      );
    });
  }
}
