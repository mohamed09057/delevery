// ignore_for_file: implementation_imports

import 'package:deleveryapp/utils/daimentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/src/places.dart';
import '../../../controllers/location_controller.dart';

class LocationDialog extends StatelessWidget {
  final GoogleMapController mapController;

  const LocationDialog({Key? key, required this.mapController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.all(Dimentions.width10),
      child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimentions.radius20 / 2),
          ),
          child: SizedBox(
              width: Dimentions.screenWidth,
              child: TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: _controller,
                  textInputAction: TextInputAction.search,
                  autofocus: true,
                  keyboardType: TextInputType.streetAddress,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    hintText: 'search location',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimentions.radius20),
                      borderSide: const BorderSide(
                        style: BorderStyle.none,
                        width: 0,
                      ),
                    ),
                    hintStyle: Theme.of(context).textTheme.headline2?.copyWith(
                          color: Theme.of(context).disabledColor,
                          fontSize: Dimentions.font15,
                        ),
                  ), 
                ),
                onSuggestionSelected: (Prediction suggestion) {
                  // ignore: void_checks
                  return Get.find<LocationController>().setLocation(
                      suggestion.placeId!,
                      suggestion.description!,
                      mapController);
                },
                suggestionsCallback: (pattern) async {
                  return await Get.find<LocationController>()
                      .searchLocation(context, pattern);
                },
                itemBuilder: (BuildContext context, Prediction suggestion) {
                  return Padding(
                    padding: EdgeInsets.all(Dimentions.width10),
                    child: Row(
                      children: [
                        const Icon(Icons.location_on),
                        Expanded(
                            child: Text(
                          suggestion.description!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.headline2?.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.color,
                                    fontSize: Dimentions.font15,
                                  ),
                        ))
                      ],
                    ),
                  );
                },
              ))),
    );
  }
}
