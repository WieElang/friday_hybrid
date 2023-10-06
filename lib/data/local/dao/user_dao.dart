import 'package:friday_hybrid/data/remote/models/auth_api_model.dart';
import 'package:realm/realm.dart';
import '../schemas.dart' as schemas;

import '../realm_database_helper.dart';

class UserDao {
  static schemas.User? getById(Realm realm, int id) {
    return realm.query<schemas.User>('id == $id').firstOrNull;
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

  static schemas.User _createFromApiModel(UserApiModel userApiModel) {
    return schemas.User(userApiModel.id, userApiModel.name, userApiModel.email);
  }

  static schemas.User _updateFromApiModel(schemas.User existingUser, UserApiModel userApiModel) {
    existingUser.id = userApiModel.id;
    existingUser.name = userApiModel.name;
    existingUser.email = userApiModel.email;
    return existingUser;
  }
}