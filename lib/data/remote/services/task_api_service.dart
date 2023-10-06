import 'dart:io';

import 'package:friday_hybrid/data/remote/api_constants.dart';
import 'package:friday_hybrid/data/remote/api_response.dart';
import 'package:friday_hybrid/data/remote/models/task_api_model.dart';
import 'package:friday_hybrid/data/remote/utils/api_response_utils.dart';
import 'package:friday_hybrid/data/remote/utils/api_utils.dart';

class TaskApiService {
  static Future<ApiResponse<TaskListApiModel>> fetchTasks() async {
    try {
      var response = await ApiUtils.createGetRequest(ApiConstants.tasksEndpoint);
      final responseJson = ApiResponseUtils.returnResponse(response);
      TaskListApiModel tasks = TaskListApiModel.fromJson(responseJson);
      return ApiResponse(tasks, null);
    } on SocketException {
      return ApiResponse(null, 'No Internet Connection');
    } on Exception catch (e) {
      return ApiResponse(null, 'Error: $e');
    }
  }
}
