import 'package:friday_hybrid/data/base_data.dart';
import 'package:friday_hybrid/data/local/dao/task_dao.dart';
import 'package:friday_hybrid/data/local/realm_database_helper.dart';
import 'package:friday_hybrid/data/remote/api_response.dart';
import 'package:friday_hybrid/data/remote/models/task_api_model.dart';
import 'package:friday_hybrid/data/remote/services/task_api_service.dart';
import 'package:friday_hybrid/data/repository/base_repository.dart';

import '../local/schemas.dart';

class TaskRepository extends BaseRepository {
  @override
  Future<BaseData<List<Task>>> getAllData() async {
    final response = await _getDataFromRemote();
    List<Task> tasks = TaskDao.getAll(realmInstance).toList();
    return BaseData(tasks, response.errorMessage);
  }

  @override
  Future<ApiResponse<TaskListApiModel>> _getDataFromRemote() async {
    final apiResponse = await TaskApiService.fetchTasks();
    if (apiResponse.data != null) {
      TaskDao.fromApiModels(apiResponse.data!);
    }
    return apiResponse;
  }
}