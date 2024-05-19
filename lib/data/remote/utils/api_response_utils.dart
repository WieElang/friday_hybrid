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
      case 403:
        throw const SessionException('Session Expired');
      case 400 | 401 | 500:
        throw Exception(response.body.toString());
        // dynamic responseJson = jsonDecode(response.body);
        // final String errorMessage = responseJson["error_message"];
        // if (errorMessage.isNotEmpty) {
        //   throw Exception(errorMessage);
        // } else {
        //   throw Exception(response.body.toString());
        // }
      default:
        throw Exception('Error occured while communication with server with status code : ${response.statusCode}');
    }
  }
}

class SessionException implements Exception {
  final String message;

  const SessionException(this.message);
}