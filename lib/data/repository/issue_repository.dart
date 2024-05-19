import 'package:friday_hybrid/data/base_data.dart';
import 'package:friday_hybrid/data/local/dao/issue_dao.dart';
import 'package:friday_hybrid/data/local/realm_database_helper.dart';
import 'package:friday_hybrid/data/remote/api_response.dart';
import 'package:friday_hybrid/data/remote/models/issue_api_model.dart';
import 'package:friday_hybrid/data/remote/services/issue_api_service.dart';

import '../local/schemas.dart';

class IssueRepository {
  // index
  Future<BaseData<List<Issue>>> getAllData() async {
    final response = await _getDataFromRemote();
    List<Issue> issues = IssueDao.getAll(realmInstance).toList();
    return BaseData(issues, response.errorMessage, exception: response.exception);
  }

  Future<BaseData<List<Issue>>> getByProject(int projectId) async {
    final response = await _getDataFromRemote();
    List<Issue> issues = IssueDao.getByProject(realmInstance, projectId).toList();
    return BaseData(issues, response.errorMessage, exception: response.exception);
  }

  Future<ApiResponse<IssueListApiModel>> _getDataFromRemote() async {
    final apiResponse = await IssueApiService.fetchIssues();
    if (apiResponse.data != null) {
      IssueDao.fromApiModels(apiResponse.data!);
    }
    return apiResponse;
  }

  // detail
  Future<BaseData<Issue>> getIssue(int issueId) async {
    final response = await _getIssueDetailFromRemote(issueId);
    Issue issue = IssueDao.getById(realmInstance, issueId)!;
    return BaseData(issue, response.errorMessage, exception: response.exception);
  }

  Future<ApiResponse<IssueApiModel>> _getIssueDetailFromRemote(int issueId) async {
    final apiResponse = await IssueApiService.fetchIssueDetail(issueId);
    if (apiResponse.data != null) {
      IssueDao.fromApiModel(apiResponse.data!);
    }
    return apiResponse;
  }
}