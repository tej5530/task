import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:task/server/network.dart';

class APIManager {
  factory APIManager() {
    return _singleton;
  }

  APIManager._internal();

  static final APIManager _singleton = APIManager._internal();

  String baseUrl = "https://5d55541936ad770014ccdf2d.mockapi.io/api/v1/";

  Future<http.Response> postData(
      String postfixUrl, dynamic data, MethodType type) async {
    Connectivity connectivity = Connectivity();
    var connectivityResult = await connectivity.checkConnectivity();
    var conn = CheckConnection.getConnectionValue(connectivityResult);
    if (conn == "Mobile" || conn == "Wi-Fi") {
      print(json.encode(data).toString());
      Map<String, String> header = new Map();
      header["Content-Type"] = "application/json";
      header["Accept"] = "application/json";
      var response;
      if (type == MethodType.POST) {
        response = await http.post(Uri.parse(baseUrl + postfixUrl),
            body: json.encode(data), headers: header);
        print(response.body.toString());
      } else {
        response = await http.get(Uri.parse(baseUrl + postfixUrl + data),
            headers: header);
        print(response.body.toString());
      }
      return response;
    } else {
      print('No internet connection found...');
      return null;
    }
  }
}

enum MethodType { GET, POST }
