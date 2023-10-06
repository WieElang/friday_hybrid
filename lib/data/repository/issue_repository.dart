import 'package:friday_hybrid/data/base_data.dart';
import 'package:friday_hybrid/data/local/dao/issue_dao.dart';
import 'package:friday_hybrid/data/local/realm_database_helper.dart';
import 'package:friday_hybrid/data/remote/api_response.dart';
import 'package:friday_hybrid/data/remote/models/issue_api_model.dart';
import 'package:friday_hybrid/data/remote/services/issue_api_service.dart';
import 'package:friday_hybrid/data/repository/base_repository.dart';

import '../local/schemas.dart';

class IssueRepository extends BaseRepository {
  @override
  Future<BaseData<List<Issue>>> getAllData() async {
    final response = await _getDataFromRemote();
    List<Issue> issues = IssueDao.getAll(realmInstance).toList();
    return BaseData(issues, response.errorMessage);
  }

  @override
  Future<ApiResponse<IssueListApiModel>> _getDataFromRemote() async {
    final apiResponse = await IssueApiService.fetchIssues();
    if (apiResponse.data != null) {
      IssueDao.fromApiModels(apiResponse.data!);
    }
    return apiResponse;
  }
}