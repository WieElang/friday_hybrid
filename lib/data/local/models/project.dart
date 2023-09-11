import 'dart:core';

import 'package:realm/realm.dart';

part 'project.g.dart';

@RealmModel()
class _Project {
  @PrimaryKey() late int id;
  late String name;
  late int priorityValue;
  late bool isActive;
  late DateTime created;
}
