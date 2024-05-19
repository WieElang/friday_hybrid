import 'package:flutter/material.dart';
import 'package:friday_hybrid/data/local/realm_database_helper.dart';
import 'package:friday_hybrid/data/repository/project_repository.dart';

import '../../../data/base_data.dart';
import '../../../data/local/dao/user_dao.dart';
import '../../../data/local/schemas.dart';

class HomeViewModel with ChangeNotifier {
  User? _user;
  User? get user {
    return _user;
  }

  void getUser() async {
    final realm = realmInstance;
    _user = UserDao.getFirst(realm);
  }

  BaseData<List<Project>> _baseData = BaseData(null, null, exception: null);
  BaseData<List<Project>> get baseData {
    return _baseData;
  }

  void getProjects() async {
    _baseData = await ProjectRepository().getAllData();
    notifyListeners();
  }
}