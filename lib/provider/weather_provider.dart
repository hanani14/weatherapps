import 'package:flutter/material.dart';
import 'package:weatherapps/api/custom_exception.dart';
import 'package:weatherapps/global_function/app_debug_print.dart';

class WeatherProvider extends ChangeNotifier {

  bool isError = false;
  bool get getIsError => isError;
  bool _isFetching = false;
  bool get isFetching => _isFetching;

  CustomException? _failure;
  CustomException? get failure => _failure;
  



  void _setFailure(CustomException? failure) {
    _failure = failure;
    AppDebug().printDebug(msg: 'weather provider failure: $failure');
    notifyListeners();
  }

  Future fetchData(bool isCurrentCity, String cityName) async {
    _setFailure(null);
    _isFetching = true;
    notifyListeners();
    //  await CallToApi().callWeatherAPi(isCurrentCity, cityName);


      try{
      // var res = dummycardmembership;
      // responseData = res['data'];
      // appbarData = responseData['app_bar'];
      // menucardData = responseData['menu'];
      // title = responseData['title'];
      // AppDebug().printDebug(msg: 'upgrade membership card provider: ${ title}');

    } on CustomException catch (f) {
      _setFailure(f);
    }
  
    _setFailure(null);
    _isFetching = false;
    notifyListeners();
  }

}