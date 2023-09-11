import 'package:friday_hybrid/data/remote/models/auth_api_model.dart';
import 'package:realm/realm.dart';
import '../models/user.dart' as user_model;

import '../realm_database_helper.dart';

class UserDao {
  static user_model.User? getById(Realm realm, int id) {
    return realm.query<user_model.User>('id == $id').firstOrNull;
  }

  static void fromApiModel(UserApiModel userApiModel) {
    final realm = realmInstance;

    final existingUser = getById(realm, userApiModel.id);
    realm.writeAsync(() {
      if (existingUser != null) {
        _updateFromApiModel(existingUser, userApiModel);
      } else {
        realm.add(_createFromApiModel(userApiModel));
      }
    });
  }

  static user_model.User _createFromApiModel(UserApiModel userApiModel) {
    return user_model.User(userApiModel.id, userApiModel.name, userApiModel.email);
  }

  static user_model.User _updateFromApiModel(user_model.User existingUser, UserApiModel userApiModel) {
    existingUser.id = userApiModel.id;
    existingUser.name = userApiModel.name;
    existingUser.email = userApiModel.email;
    return existingUser;
  }
}