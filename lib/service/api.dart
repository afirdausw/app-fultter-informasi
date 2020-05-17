import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'custom_exception.dart';

class ApiProvider {
  // Server URL
  final String _baseUrl = "http://10.0.2.2/onlenkan-informasi/";
  // final String _baseUrl = "http://192.168.43.17/onlenkan-informasi/";
  // final String _baseUrl = "http://192.168.1.21/onlenkan-informasi/";
  // final String _baseUrl = "https://informasi.onlenkan.org/";

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await http.get(_baseUrl + url);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}