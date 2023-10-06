import 'package:flutter/material.dart';
import 'package:friday_hybrid/data/repository/project_repository.dart';

import '../../../data/base_data.dart';
import '../../../data/local/schemas.dart';

class HomeViewModel with ChangeNotifier {
  BaseData<List<Project>> _baseData = BaseData(null, null);

  BaseData<List<Project>> get baseData {
    return _baseData;
  }

  Future<void> getProjects() async {
    _baseData = await ProjectRepository().getAllData();
    notifyListeners();
  }
}