import 'package:flutter/material.dart';
import 'package:friday_hybrid/data/local/dao/user_dao.dart';
import 'package:friday_hybrid/data/remote/api_response.dart';
import 'package:friday_hybrid/data/remote/models/auth_api_model.dart';
import 'package:friday_hybrid/data/remote/services/auth_api_service.dart';

import '../../../data/local/realm_database_helper.dart';
import '../../../data/local/schemas.dart';

class AccountViewModel with ChangeNotifier {
  User? _user;
  User? get user {
    return _user;
  }

  void setUser() async {
    final realm = realmInstance;
    _user = UserDao.getFirst(realm);
  }

  Future<ApiResponse<BaseStatusApiModel>?> logout() async {
    return await AuthApiService.logout();
  }
}