import 'dart:io';

import 'package:friday_hybrid/core/session.dart';
import 'package:friday_hybrid/data/remote/api_constants.dart';
import 'package:friday_hybrid/data/remote/api_response.dart';
import 'package:friday_hybrid/data/remote/models/project_api_model.dart';
import 'package:friday_hybrid/data/remote/utils/api_response_utils.dart';
import 'package:friday_hybrid/data/remote/utils/api_utils.dart';

class ProjectApiService {
  static Future<ApiResponse<ProjectListApiModel>> fetchProject() async {
    try {
      var response = await ApiUtils.createGetRequest(ApiConstants.projectsEndpoint, isUseToken: true);
      final responseJson = ApiResponseUtils.returnResponse(response);
      ProjectListApiModel projectList = ProjectListApiModel.fromJson(responseJson);
      return ApiResponse(projectList, null);
    } on SocketException {
      return ApiResponse(null, 'No Internet Connection');
    } on SessionException catch (e) {
      Session.clearSessionKey();
      return ApiResponse(null, e.message, exception: e);
    } on Exception catch (e) {
      return ApiResponse(null, e.toString());
    }
  }
}
