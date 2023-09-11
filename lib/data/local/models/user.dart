import 'dart:core';

import 'package:realm/realm.dart';

part 'user.g.dart';

@RealmModel()
class _User {
  @PrimaryKey() late int id;
  late String name;
  late String email;
}
