import 'package:friday_hybrid/data/base_data.dart';
import 'package:friday_hybrid/data/local/dao/project_dao.dart';
import '../local/schemas.dart';
import 'package:friday_hybrid/data/local/realm_database_helper.dart';
import 'package:friday_hybrid/data/remote/api_response.dart';
import 'package:friday_hybrid/data/remote/models/project_api_model.dart';
import 'package:friday_hybrid/data/remote/services/project_api_service.dart';
import 'package:friday_hybrid/data/repository/base_repository.dart';

class ProjectRepository extends BaseRepository {
  @override
  Future<BaseData<List<Project>>> getAllData() async {
    final response = await _getDataFromRemote();
    List<Project> projects = ProjectDao.getActive(realmInstance).toList();
    return BaseData(projects, response.errorMessage);
  }

  @override
  Future<ApiResponse<ProjectListApiModel>> _getDataFromRemote() async {
    final apiResponse = await ProjectApiService.fetchProject();
    if (apiResponse.data != null) {
      ProjectDao.fromApiModels(apiResponse.data!);
    }
    return apiResponse;
  }
}