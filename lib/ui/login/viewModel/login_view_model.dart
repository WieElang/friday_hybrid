import 'package:flutter/material.dart';
import 'package:friday_hybrid/data/remote/api_response.dart';
import 'package:friday_hybrid/data/remote/models/auth_api_model.dart';
import 'package:friday_hybrid/data/remote/services/auth_api_service.dart';

class LoginViewModel with ChangeNotifier {
  Future<ApiResponse<LoginApiModel>?> login(String email, String password) async {
    return await AuthApiService.login(email, password);
  }
}