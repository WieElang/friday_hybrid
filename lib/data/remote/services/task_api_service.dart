import 'dart:io';

import 'package:friday_hybrid/data/remote/api_constants.dart';
import 'package:friday_hybrid/data/remote/api_response.dart';
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
}
