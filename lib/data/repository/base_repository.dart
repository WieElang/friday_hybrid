import 'package:friday_hybrid/data/base_data.dart';
import 'package:friday_hybrid/data/remote/api_response.dart';

abstract class BaseRepository<T> {
  Future<BaseData<T>> getAllData();
  Future<ApiResponse<T>> _getDataFromRemote();
}