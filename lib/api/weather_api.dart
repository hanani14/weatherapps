import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapps/api/api_manager.dart';
import 'package:weatherapps/global_function/app_debug_print.dart';
import 'package:weatherapps/global_function/global.dart';

class WeatherAPI{


   Future<Map> fetchdataweather(bool current, String cityName) async {
      Position currentPosition = await getCurrentPosition();
      if (current) {
        List<Placemark> placemarks = await placemarkFromCoordinates(
            currentPosition.latitude, currentPosition.longitude);

        Placemark place = placemarks[0];
        cityName = place.locality!;
      }

      var url = Uri.https('api.openweathermap.org', '/data/2.5/weather',
          {'q': cityName, "units": "metric", "appid": Global().apiKey});

      final response = await APIManager().getAPICall(url).timeout(Duration(seconds: Global().timeout));
      return response;
   
  }

  Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
  }
}