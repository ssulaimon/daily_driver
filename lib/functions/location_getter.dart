import 'dart:developer';

import 'package:daily_driver/const/api_credentials.dart';
import 'package:daily_driver/model/location_model.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';

class GetUserLocation {
  Future<LocationModel?> getLocation() async {
    Location location = Location();
    PermissionStatus permissionStatus;
    LocationData locationData;
    bool enabled;
    enabled = await location.serviceEnabled();
    if (!enabled) {
      enabled = await location.requestService();
      if (!enabled) {
        return null;
      }
    }
    permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        return null;
      }
    }
    locationData = await location.getLocation();
    LocationModel locationModel = LocationModel(
        latitude: locationData.latitude!, longitude: locationData.longitude!);

    return locationModel;
  }
}

class ReverseGeolocation {
  Future<void> reverseGeolocation(
      {required LocationModel locationModel}) async {
    var url = Uri.parse(
        'https://api.geoapify.com/v1/geocode/reverse?lat=${locationModel.latitude.toString()}&lon=${locationModel.longitude.toString()}&apiKey=${ApiCredentials.apiKey}');
    Response response = await get(url);
    if (response.statusCode == 200) {
      log(response.body);
    } else {
      log(response.body);
    }
  }
}
