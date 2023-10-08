import 'dart:io';

import 'package:friday_hybrid/data/remote/api_constants.dart';
import 'package:friday_hybrid/data/remote/api_response.dart';
import 'package:friday_hybrid/data/remote/models/issue_api_model.dart';
import 'package:friday_hybrid/data/remote/utils/api_response_utils.dart';
import 'package:friday_hybrid/data/remote/utils/api_utils.dart';

class IssueApiService {
  static Future<ApiResponse<IssueListApiModel>> fetchIssues() async {
    try {
      var response = await ApiUtils.createGetRequest(ApiConstants.issuesEndpoint);
      final responseJson = ApiResponseUtils.returnResponse(response);
      IssueListApiModel issues = IssueListApiModel.fromJson(responseJson);
      return ApiResponse(issues, null);
    } on SocketException {
      return ApiResponse(null, 'No Internet Connection');
    } on SessionException catch (e) {
      return ApiResponse(null, e.message, exception: e);
    } on Exception catch (e) {
      return ApiResponse(null, e.toString());
    }
  }
}
