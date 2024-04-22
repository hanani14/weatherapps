import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:weatherapps/api/custom_exception.dart';
import 'package:weatherapps/global_function/app_debug_print.dart';
import 'package:weatherapps/global_function/global.dart';
class APIManager {
  Future<dynamic> postAPICall(String url, Map param) async {
    AppDebug().printDebug(msg: "Calling API: $url");
    AppDebug().printDebug(msg: "Calling parameters: $param");

    var responseJson;
    try {
      final response = await http.post(Uri.parse(url), body: param).timeout(Duration(seconds: Global().timeout), onTimeout: () {
        AppDebug().printDebug(msg: "Calling API Timeout: $url");
        throw throw TimeoutException("");
      });

      responseJson = _response(response, url: url);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postAPICallWithHeader(String url, Map param, Map<String, String>? headers) async {
    AppDebug().printDebug(msg: "Calling POST API: $url");
    AppDebug().printDebug(msg: "Calling parameters: $param");

    var responseJson;
    try {
      final stopwatch2 = Stopwatch()..start();
      final response = await http.post(Uri.parse(url), body: param, headers: headers).timeout(Duration(seconds: Global().timeout), onTimeout: () {
        AppDebug().printDebug(msg: "Calling API Timeout: $url");

        throw throw TimeoutException("");
      });
      AppDebug().printDebug(msg: 'call $url api executed in ${stopwatch2.elapsed}');
      responseJson = _response(response, url: url, header: headers);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postAPICallWithHeaderBodyJsonEncode(String url, String param, Map<String, String>? headers) async {
    AppDebug().printDebug(msg: "Calling POST API: $url");
    AppDebug().printDebug(msg: "Calling parameters: $param");

    var responseJson;
    try {
      final stopwatch2 = Stopwatch()..start();
      final response = await http.post(Uri.parse(url), body: param, headers: headers).timeout(Duration(seconds: Global().timeout), onTimeout: () {
        AppDebug().printDebug(msg: "Calling API Timeout: $url");
        throw throw TimeoutException("");
      });
      AppDebug().printDebug(msg: 'call $url api executed in ${stopwatch2.elapsed}');
      responseJson = _responseDecode(response, url: url, header: headers);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postAPICallWithHeader2(String url, Map param, Map<String, String>? headers) async {
    AppDebug().printDebug(msg: "Calling POST API: $url");
    AppDebug().printDebug(msg: "Calling parameters: $param");

    var responseJson;
    try {
      final response = await http.post(Uri.parse(url), body: jsonEncode(param), headers: headers).timeout(Duration(seconds: Global().timeout), onTimeout: () {
        AppDebug().printDebug(msg: "Calling API Timeout: $url");
        throw throw TimeoutException("");
      });
      responseJson = _response(response, url: url, header: headers);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> getAPICallWithHeader(String url, Map<String, String>? header) async {
    AppDebug().printDebug(msg: "Calling GET API: $url");

    var responseJson;
    try {
      final response = await http.get(Uri.parse(url), headers: header).timeout(Duration(seconds: Global().timeout), onTimeout: () {
        AppDebug().printDebug(msg: "Calling API Timeout: $url");

        throw throw TimeoutException("");
      });
      responseJson = _response(response, url: url, header: header);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> getAPICall(Uri url) async {
    AppDebug().printDebug(msg: "Calling GET API: $url");

    var responseJson;
    try {
      final response = await http.get(url).timeout(Duration(seconds: Global().timeout), onTimeout: () {
        AppDebug().printDebug(msg: "Calling API Timeout: $url");
        throw throw TimeoutException("");
      });
      responseJson = _response(response, url: url);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }


  Future<dynamic> patchAPICallWithHeader(String url, Map param, Map<String, String>? headers) async {
    AppDebug().printDebug(msg: "Calling PATCH API: $url");
    AppDebug().printDebug(msg: "Calling parameters: $param");

    var responseJson;
    try {
      final stopwatch2 = Stopwatch()..start();
      final response = await http.patch(Uri.parse(url), body: param, headers: headers).timeout(Duration(seconds: Global().timeout), onTimeout: () {
        AppDebug().printDebug(msg: "Calling API Timeout: $url");

        throw throw TimeoutException("");
      });
      AppDebug().printDebug(msg: 'call $url api executed in ${stopwatch2.elapsed}');
      responseJson = _response(response, url: url, header: headers);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> deleteAPICallWithHeader(String url, Map<String, String>? header) async {
    AppDebug().printDebug(msg: "Calling DELETE API: $url");

    var responseJson;
    try {
      final response = await http.delete(Uri.parse(url), headers: header).timeout(Duration(seconds: Global().timeout), onTimeout: () {
        AppDebug().printDebug(msg: "Calling API Timeout: $url");
        throw throw TimeoutException("");
      });
      responseJson = _response(response, url: url, header: header);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> putAPICallWithHeader(String url, Map param, Map<String, String>? headers) async {
    AppDebug().printDebug(msg: "Calling POST API: $url");
    AppDebug().printDebug(msg: "Calling parameters: $param");

    var responseJson;
    try {
      final stopwatch2 = Stopwatch()..start();
      final response = await http.put(Uri.parse(url), body: param, headers: headers).timeout(Duration(seconds: Global().timeout), onTimeout: () {
        AppDebug().printDebug(msg: "Calling API Timeout: $url");

        throw throw TimeoutException("");
      });
      AppDebug().printDebug(msg: 'call $url api executed in ${stopwatch2.elapsed}');
      responseJson = _response(response, url: url, header: headers);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response, {url, header}) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        throw UnauthorisedException(response.body.toString());
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
        throw ServerErrorException(response.body.toString());
      default:
        throw FetchDataException('Error occured while Communication with Server with StatusCode: ${response.statusCode}');
    }
  }

  dynamic _responseDecode(http.Response response, {url, header}) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        if (responseJson.toString().contains('code') || responseJson.toString().contains('CODE')) {
          if (responseJson['code'] == 400 || responseJson['code'] == 401 || responseJson['code'] == 402 || responseJson['code'] == 404 || responseJson['code'] == 500 || responseJson['code'] == 503 || responseJson['CODE'] == 400 || responseJson['CODE'] == 401 || responseJson['CODE'] == 402 || responseJson['CODE'] == 404 || responseJson['CODE'] == 500 || responseJson['CODE'] == 503) {
            AppDebug().printDebug(msg: 'error api : decode $url ${responseJson['code']} $responseJson');
          }
        }
        return responseJson;
      case 400:
        throw json.decode(response.body.toString());
      case 401:
        throw BadRequestException(response.body.toString());
      case 403:
        throw UnauthorisedException(response.body);
      case 500:
        throw ServerErrorException(response.body.toString());
      default:
        throw FetchDataException('Error occured while Communication with Server with StatusCode: ${response.statusCode}');
    }
  }

  String extractPathFromUrl(String url, {from}) {
    Uri uri = Uri.parse(url);
    return uri.path;
  }

  Future<dynamic> postAPICallWithoutBody(String url, Map<String, String>? headers) async {
      AppDebug().printDebug(msg: "Calling API: $url");

      var responseJson;
      try {
        final response = await http.post(Uri.parse(url), headers: headers).timeout(Duration(seconds: Global().timeout), onTimeout: () {
          AppDebug().printDebug(msg: "Calling API Timeout: $url");
          throw throw TimeoutException("");
        });

        responseJson = _responseDecode(response, url: url);
      } on SocketException {
        throw FetchDataException('No Internet connection');
      }
      return responseJson;
    }
  
}
