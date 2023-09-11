import 'package:flutter/material.dart';
import 'package:friday_hybrid/data/remote/api_response.dart';
import 'package:friday_hybrid/data/remote/models/auth_api_model.dart';
import 'package:friday_hybrid/data/remote/services/auth_api_service.dart';

class LoginViewModel with ChangeNotifier {
  ApiResponse<LoginApiModel> _loginResponse = ApiResponse(null, null);

  ApiResponse<LoginApiModel> get loginResponse {
    return _loginResponse;
  }

  Future<void> login() async {
    _loginResponse = await AuthApiService.login();
  }
}