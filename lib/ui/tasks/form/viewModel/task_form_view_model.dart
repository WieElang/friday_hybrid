import 'package:flutter/material.dart';
import 'package:friday_hybrid/data/remote/models/task_api_model.dart';
import 'package:friday_hybrid/data/remote/services/task_api_service.dart';

import '../../../../data/base_data.dart';
import '../../../../data/local/schemas.dart';
import '../../../../data/remote/api_response.dart';
import '../../../../data/repository/issue_repository.dart';


class TaskFormViewModel with ChangeNotifier {
  BaseData<List<Issue>> _baseData = BaseData(null, null, exception: null);

  BaseData<List<Issue>> get baseData {
    return _baseData;
  }

  void getIssues(int projectId) async {
    _baseData = await IssueRepository().getByProject(projectId);
    notifyListeners();
  }

  Future<ApiResponse<TaskApiModel>?> add(int projectId, int issueId, String name, {String? notes, String? link}) async {
    return await TaskApiService.addTask(projectId, issueId, name, notes, link);
  }

  Future<ApiResponse<TaskApiModel>?> edit(int taskId, int projectId, int issueId, String name, {String? notes, String? link}) async {
    return await TaskApiService.editTask(taskId, projectId, issueId, name, notes, link);
  }
}
