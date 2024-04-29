import 'package:flutter/material.dart';
import 'package:weatherapps/api/custom_exception.dart';
import 'package:weatherapps/api/weather_api.dart';
import 'package:weatherapps/global_function/app_debug_print.dart';

class WeatherProvider extends ChangeNotifier {

  bool isError = false;
  bool get getIsError => isError;
  bool _isFetching = false;
  bool get isFetching => _isFetching;

  CustomException? _failure;
  CustomException? get failure => _failure;

  Map response = {};
  Map get getResponse => response;
  Map cordinateData = {};
  Map get getCordinateData => cordinateData;
  List weatherData = [];
  List get getWeatherData => weatherData;
  Map mainData = {};
  Map get getMainData => mainData;
  Map windData = {};
  Map get getWindData => windData;
  Map sysData = {};
  Map get getSysData => sysData;

  Map searchresponse = {};
  Map get getSearchResponse => searchresponse;
  Map searchcordinateData = {};
  Map get getSearchCordinateData => searchcordinateData;
  List searchweatherData = [];
  List get getSearchWeatherData => searchweatherData;
  Map searchmainData = {};
  Map get getSearchMainData => searchmainData;
  Map searchwindData = {};
  Map get getsearchWindData => searchwindData;
  Map searchsysData = {};
  Map get getSearchSysData => searchsysData;




  
  void _setFailure(CustomException? failure) {
    _failure = failure;
    AppDebug().printDebug(msg: 'weather provider failure: $failure');
    isError = true;
    notifyListeners();
  }

  Future fetchData(bool isCurrentCity, String cityName) async {
    _setFailure(null);
    _isFetching = true;
    notifyListeners();

      try{
        var res = await WeatherAPI().fetchdataweather(isCurrentCity, cityName);
        if(isCurrentCity == true){
          response = res;
          cordinateData = response['coord'];
          weatherData = response['weather'];
          mainData = response['main'];
          windData = response['wind'];
          sysData = response['sys'];
        }
        else if(isCurrentCity == false){
          searchresponse = res;
          searchcordinateData = searchresponse['coord'];
          searchweatherData = searchresponse['weather'];
          searchmainData = searchresponse['main'];
          searchwindData = searchresponse['wind'];
          searchsysData = searchresponse['sys'];
        }

        AppDebug().printDebug(msg: 'weather provider: ${ res}');
        AppDebug().printDebug(msg: 'weather provider: ${ windData}');

    } on CustomException catch (f) {
      print('errror $f');
      _setFailure(f);
    }
  
    _isFetching = false;
    notifyListeners();
  }

  

}