import 'dart:io';

import 'package:friday_hybrid/data/local/dao/task_dao.dart';
import 'package:friday_hybrid/data/local/realm_database_helper.dart';
import 'package:friday_hybrid/data/local/schemas.dart';
import 'package:friday_hybrid/data/remote/api_constants.dart';
import 'package:friday_hybrid/data/remote/api_response.dart';
import 'package:friday_hybrid/data/remote/models/auth_api_model.dart';
import 'package:friday_hybrid/data/remote/models/task_api_model.dart';
import 'package:friday_hybrid/data/remote/utils/api_response_utils.dart';
import 'package:friday_hybrid/data/remote/utils/api_utils.dart';

class TaskApiService {
  static Future<ApiResponse<TaskListApiModel>> fetchTasks(int projectId) async {
    Map<String, dynamic> data = {
      "project": projectId
    };
    try {
      var response = await ApiUtils.createGetRequest(ApiConstants.tasksEndpoint, params: data);
      final responseJson = ApiResponseUtils.returnResponse(response);
      TaskListApiModel tasks = TaskListApiModel.fromJson(responseJson);
      return ApiResponse(tasks, null);
    } on SocketException {
      return ApiResponse(null, 'No Internet Connection');
    } on SessionException catch (e) {
      return ApiResponse(null, e.message, exception: e);
    } on Exception catch (e) {
      return ApiResponse(null, e.toString());
    }
  }

  static Future<ApiResponse<DailyTaskApiModel>> fetchDailyTask() async {
    try {
      var response = await ApiUtils.createGetRequest(ApiConstants.dailyTaskEndpoint);
      final responseJson = ApiResponseUtils.returnResponse(response);
      DailyTaskApiModel dailyTaskApiModel = DailyTaskApiModel.fromJson(responseJson);
      return ApiResponse(dailyTaskApiModel, null);
    } on SocketException {
      return ApiResponse(null, 'No Internet Connection');
    } on SessionException catch (e) {
      return ApiResponse(null, e.message, exception: e);
    } on Exception catch (e) {
      return ApiResponse(null, e.toString());
    }
  }

  static Future<ApiResponse<TaskDetailApiModel>> fetchTaskDetail(int taskId) async {
    Map<String, dynamic> data = {
      "task": taskId
    };
    try {
      var response = await ApiUtils.createGetRequest(ApiConstants.taskDetailEndpoint, params: data);
      final responseJson = ApiResponseUtils.returnResponse(response);
      TaskDetailApiModel taskData = TaskDetailApiModel.fromJson(responseJson);
      return ApiResponse(taskData, null);
    } on SocketException {
      return ApiResponse(null, 'No Internet Connection');
    } on SessionException catch (e) {
      return ApiResponse(null, e.message, exception: e);
    } on Exception catch (e) {
      return ApiResponse(null, e.toString());
    }
  }

  static Future<ApiResponse<TaskApiModel>> addTask(int projectId, int issueId, String name, String? notes, String? link) async {
    Map data = {
      "project": projectId,
      "issue": issueId,
      "name": name,
      "notes": notes,
      "link": link
    };
    try {
      var response = await ApiUtils.createPostRequest(ApiConstants.addTaskEndpoint, data: data);
      final responseJson = ApiResponseUtils.returnResponse(response);
      final taskApiModel = TaskApiModel.fromJson(responseJson['task']);
      TaskDao.fromApiModel(taskApiModel);

      return ApiResponse(taskApiModel, null);
    } on SocketException {
      return ApiResponse(null, 'No Internet Connection');
    } on SessionException catch (e) {
      return ApiResponse(null, e.message, exception: e);
    } on Exception catch (e) {
      return ApiResponse(null, e.toString());
    }
  }

  static Future<ApiResponse<TaskApiModel>> editTask(int taskId, int projectId, int issueId, String name, int status, String? notes, String? link) async {
    Map data = {
      "task": taskId,
      "project": projectId,
      "issue": issueId,
      "name": name,
      "status": status,
      "notes": notes,
      "link": link
    };
    try {
      var response = await ApiUtils.createPostRequest(ApiConstants.editTaskEndpoint, data: data);
      final responseJson = ApiResponseUtils.returnResponse(response);
      final taskApiModel = TaskApiModel.fromJson(responseJson['task']);
      TaskDao.fromApiModel(taskApiModel);

      return ApiResponse(taskApiModel, null);
    } on SocketException {
      return ApiResponse(null, 'No Internet Connection');
    } on SessionException catch (e) {
      return ApiResponse(null, e.message, exception: e);
    } on Exception catch (e) {
      return ApiResponse(null, e.toString());
    }
  }

  static Future<ApiResponse<BaseStatusApiModel>> deleteTask(int taskId) async {
    Map data = {
      "task": taskId,
    };
    try {
      var response = await ApiUtils.createPostRequest(ApiConstants.deleteTaskEndpoint, data: data);
      final responseJson = ApiResponseUtils.returnResponse(response);
      final statusApiModel = BaseStatusApiModel.fromJson(responseJson);
      if (statusApiModel.status == "OK") {
        await realmInstance.writeAsync(() => TaskDao.delete(realmInstance, taskId));
      }
      return ApiResponse(statusApiModel, null);
    } on SocketException {
      return ApiResponse(null, 'No Internet Connection');
    } on SessionException catch (e) {
      return ApiResponse(null, e.message, exception: e);
    } on Exception catch (e) {
      return ApiResponse(null, e.toString());
    }
  }
}
