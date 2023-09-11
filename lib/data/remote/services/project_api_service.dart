import 'dart:io';

import 'package:friday_hybrid/data/remote/api_constants.dart';
import 'package:friday_hybrid/data/remote/api_response.dart';
import 'package:friday_hybrid/data/remote/models/project_api_model.dart';
import 'package:friday_hybrid/data/remote/utils/api_response_utils.dart';
import 'package:http/http.dart' as http;

class ProjectApiService {
  static Future<ApiResponse<ProjectListApiModel>> fetchProject() async {
    var url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.projectsEndpoint}?token=${ApiConstants.apiToken}');
    try {
      var response = await http.get(url);
      final responseJson = ApiResponseUtils.returnResponse(response);
      ProjectListApiModel projectList = ProjectListApiModel.fromJson(responseJson);
      return ApiResponse(projectList, null);
    } on SocketException {
      return ApiResponse(null, 'No Internet Connection');
    } on Exception catch (e) {
      return ApiResponse(null, 'Error: $e');
    }
  }
}
