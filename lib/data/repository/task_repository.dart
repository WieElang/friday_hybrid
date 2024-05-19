import 'package:friday_hybrid/data/base_data.dart';
import 'package:friday_hybrid/data/local/dao/issue_dao.dart';
import 'package:friday_hybrid/data/local/dao/task_activity_dao.dart';
import 'package:friday_hybrid/data/local/dao/task_dao.dart';
import 'package:friday_hybrid/data/local/realm_database_helper.dart';
import 'package:friday_hybrid/data/remote/api_response.dart';
import 'package:friday_hybrid/data/remote/models/task_api_model.dart';
import 'package:friday_hybrid/data/remote/services/task_api_service.dart';

import '../local/schemas.dart';

class TaskRepository {
  // index
  Future<BaseData<List<Task>>> getAllData(int projectId) async {
    final response = await _getDataFromRemote(projectId);
    List<Task> tasks = TaskDao.getByProject(realmInstance, projectId).toList();
    return BaseData(tasks, response.errorMessage, exception: response.exception);
  }

  Future<ApiResponse<TaskListApiModel>> _getDataFromRemote(int projectId) async {
    final apiResponse = await TaskApiService.fetchTasks(projectId);
    if (apiResponse.data != null) {
      TaskDao.fromApiModels(apiResponse.data!);
    }
    return apiResponse;
  }

  // detail
  Future<BaseData<Task>> getTask(int taskId) async {
    final response = await _getTaskDetailFromRemote(taskId);
    Task task = TaskDao.getById(realmInstance, taskId)!;
    return BaseData(task, response.errorMessage, exception: response.exception);
  }

  Future<ApiResponse<TaskDetailApiModel>> _getTaskDetailFromRemote(int taskId) async {
    final apiResponse = await TaskApiService.fetchTaskDetail(taskId);
    if (apiResponse.data != null) {
      TaskDao.fromApiModel(apiResponse.data!.task);
      IssueDao.fromApiModel(apiResponse.data!.issue);
    }
    return apiResponse;
  }

  // daily
  Future<BaseData<List<Task>>> getDailyTasks() async {
    final response = await _getDailyTaskFromRemote();
    List<Task> tasks = TaskDao.getDailyTask(realmInstance).toList();
    return BaseData(tasks, response.errorMessage, exception: response.exception);
  }

  Future<ApiResponse<DailyTaskApiModel>> _getDailyTaskFromRemote() async {
    final apiResponse = await TaskApiService.fetchDailyTask();
    if (apiResponse.data != null) {
      TaskDao.fromApiModels(apiResponse.data!.tasks);
      TaskActivityDao.fromApiModels(apiResponse.data!.activities);
    }
    return apiResponse;
  }
}