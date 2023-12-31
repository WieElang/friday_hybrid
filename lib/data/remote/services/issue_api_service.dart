import 'dart:io';

import 'package:friday_hybrid/data/remote/api_constants.dart';
import 'package:friday_hybrid/data/remote/api_response.dart';
import 'package:friday_hybrid/data/remote/models/auth_api_model.dart';
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

  static Future<ApiResponse<IssueApiModel>> fetchIssueDetail(int issueId) async {
    Map<String, dynamic> data = {
      "issue": issueId
    };
    try {
      var response = await ApiUtils.createGetRequest(ApiConstants.issueDetailEndpoint, params: data);
      final responseJson = ApiResponseUtils.returnResponse(response);
      IssueApiModel issueData = IssueApiModel.fromJson(responseJson['issue']);
      return ApiResponse(issueData, null);
    } on SocketException {
      return ApiResponse(null, 'No Internet Connection');
    } on SessionException catch (e) {
      return ApiResponse(null, e.message, exception: e);
    } on Exception catch (e) {
      return ApiResponse(null, e.toString());
    }
  }

  static Future<ApiResponse<IssueApiModel>> editStatus(int issueId, int status) async {
    Map data = {
      "issue": issueId,
      "status": status
    };
    print(data);
    try {
      var response = await ApiUtils.createPostRequest(ApiConstants.editStatusIssueEndpoint, data: data);
      final responseJson = ApiResponseUtils.returnResponse(response);
      IssueApiModel issueData = IssueApiModel.fromJson(responseJson['issue']);
      return ApiResponse(issueData, null);
    } on SocketException {
      return ApiResponse(null, 'No Internet Connection');
    } on SessionException catch (e) {
      return ApiResponse(null, e.message, exception: e);
    } on Exception catch (e) {
      return ApiResponse(null, e.toString());
    }
  }

  static Future<ApiResponse<BaseStatusApiModel>> editChecklist(int checklistId) async {
    Map data = {
      "checklist": checklistId
    };
    try {
      var response = await ApiUtils.createPostRequest(ApiConstants.editIssueChecklistEndpoint, data: data);
      final responseJson = ApiResponseUtils.returnResponse(response);
      BaseStatusApiModel baseStatusApiModel = BaseStatusApiModel.fromJson(responseJson);
      return ApiResponse(baseStatusApiModel, null);
    } on SocketException {
      return ApiResponse(null, 'No Internet Connection');
    } on SessionException catch (e) {
      return ApiResponse(null, e.message, exception: e);
    } on Exception catch (e) {
      return ApiResponse(null, e.toString());
    }
  }
}
