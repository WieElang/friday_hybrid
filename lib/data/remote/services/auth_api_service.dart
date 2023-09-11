import 'dart:io';

import 'package:friday_hybrid/core/session.dart';
import 'package:friday_hybrid/data/local/dao/user_dao.dart';
import 'package:friday_hybrid/data/remote/api_constants.dart';
import 'package:friday_hybrid/data/remote/api_response.dart';
import 'package:friday_hybrid/data/remote/models/auth_api_model.dart';
import 'package:friday_hybrid/data/remote/utils/api_response_utils.dart';
import 'package:http/http.dart' as http;

class AuthApiService {
  static Future<ApiResponse<LoginApiModel>> login() async {
    var url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.loginEndpoint}?token=${ApiConstants.apiToken}');
    try {
      var response = await http.get(url);
      final responseJson = ApiResponseUtils.returnResponse(response);
      final loginApiModel = LoginApiModel.fromJson(responseJson);
      UserDao.fromApiModel(loginApiModel.user);

      if (response.headers.containsKey("session_key")) {
        final sessionKey = response.headers["session_key"];
        Session.setSessionKey(sessionKey!);
      }

      return ApiResponse(loginApiModel, null);
    } on SocketException {
      return ApiResponse(null, 'No Internet Connection');
    } on Exception catch (e) {
      return ApiResponse(null, 'Error: $e');
    }
  }
}