import 'package:flutter/material.dart';
import 'package:friday_hybrid/data/remote/models/task_api_model.dart';
import 'package:friday_hybrid/data/remote/services/task_api_service.dart';

import '../../../../data/local/schemas.dart';
import '../../../../data/remote/api_response.dart';
import '../../../../data/repository/issue_repository.dart';


class TaskFormViewModel with ChangeNotifier {
  List<Issue> _issues = [];
  List<Issue> get issues {
    return _issues;
  }

  void getIssues(int projectId) async {
    final baseData = await IssueRepository().getByProject(projectId);
    if (baseData.data != null) {
      _issues = baseData.data!;
    } else {
      _issues = [];
    }
    notifyListeners();
  }

  Future<ApiResponse<TaskApiModel>?> add(int projectId, int issueId, String name, {String? notes, String? link}) async {
    return await TaskApiService.addTask(projectId, issueId, name, notes, link);
  }

  Future<ApiResponse<TaskApiModel>?> edit(int taskId, int projectId, int issueId, String name, int status, {String? notes, String? link}) async {
    return await TaskApiService.editTask(taskId, projectId, issueId, name, status, notes, link);
  }
}
