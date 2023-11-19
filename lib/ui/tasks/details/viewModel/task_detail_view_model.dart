import 'package:flutter/material.dart';
import 'package:friday_hybrid/data/local/dao/task_activity_dao.dart';
import 'package:friday_hybrid/data/local/realm_database_helper.dart';
import 'package:friday_hybrid/data/remote/models/auth_api_model.dart';
import 'package:friday_hybrid/data/repository/task_repository.dart';

import '../../../../data/base_data.dart';
import '../../../../data/local/schemas.dart';
import '../../../../data/remote/api_response.dart';
import '../../../../data/remote/services/task_api_service.dart';


class TaskDetailViewModel with ChangeNotifier {
  BaseData<Task> _taskData = BaseData(null, null, exception: null);
  BaseData<Task> get taskData {
    return _taskData;
  }

  List<TaskActivity> _activities = [];
  List<TaskActivity> get activities {
    return _activities;
  }

  void getTask(int taskId) async {
    _taskData = await TaskRepository().getTask(taskId);
    if (_taskData.data != null) {
      final realm = realmInstance;
      final task = _taskData.data!;
      final taskActivities = TaskActivityDao.getByTask(realm, task.id);
      _activities = taskActivities.toList();
    } else {
      _activities = [];
    }
    notifyListeners();
  }

  Future<ApiResponse<BaseStatusApiModel>?> delete(int taskId) async {
    return await TaskApiService.deleteTask(taskId);
  }
}
