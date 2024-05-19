import 'package:flutter/material.dart';
import 'package:friday_hybrid/data/repository/task_repository.dart';

import '../../../../data/base_data.dart';
import '../../../../data/local/schemas.dart';


class TaskViewModel with ChangeNotifier {
  BaseData<List<Task>> _baseData = BaseData(null, null, exception: null);

  BaseData<List<Task>> get baseData {
    return _baseData;
  }

  void getTasks(int projectId) async {
    _baseData = await TaskRepository().getAllData(projectId);
    notifyListeners();
  }
}
