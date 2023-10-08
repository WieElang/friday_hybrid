import 'dart:io';

import 'package:friday_hybrid/core/session.dart';
import 'package:friday_hybrid/data/local/dao/user_dao.dart';
import 'package:friday_hybrid/data/remote/api_constants.dart';
import 'package:friday_hybrid/data/remote/api_response.dart';
import 'package:friday_hybrid/data/remote/models/auth_api_model.dart';
import 'package:friday_hybrid/data/remote/utils/api_response_utils.dart';
import 'package:friday_hybrid/data/remote/utils/api_utils.dart';

class AuthApiService {
  static Future<ApiResponse<LoginApiModel>> login(String email, String password) async {
    Map data = {
      "email": email,
      "password": password
    };
    try {
      var response = await ApiUtils.createPostRequest(ApiConstants.loginEndpoint, data: data, isUseToken: true);
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
      return ApiResponse(null, e.toString());
    }
  }

  static Future<ApiResponse<BaseStatusApiModel>> logout() async {
    try {
      var response = await ApiUtils.createPostRequest(ApiConstants.logoutEndPoint);
      final responseJson = ApiResponseUtils.returnResponse(response);
      final baseStatusApiModel = BaseStatusApiModel.fromJson(responseJson);

      if (baseStatusApiModel.status == "OK") {
        Session.clearSessionKey();
      }
      return ApiResponse(baseStatusApiModel, null);
    } on SocketException {
      return ApiResponse(null, 'No Internet Connection');
    } on SessionException catch (e) {
      return ApiResponse(null, e.message, exception: e);
    } on Exception catch (e) {
      return ApiResponse(null, e.toString());
    }
  }
}