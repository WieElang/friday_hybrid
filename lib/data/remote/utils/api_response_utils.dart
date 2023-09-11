import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ApiResponseUtils {
  @visibleForTesting
  static dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400 | 401 | 403 | 500:
        throw Exception(response.body.toString());
      default:
        throw Exception('Error occured while communication with server with status code : ${response.statusCode}');
    }
  }
}