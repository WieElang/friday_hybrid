import 'dart:core';

import 'package:realm/realm.dart';

part 'schemas.g.dart';

@RealmModel()
class _User {
  @PrimaryKey() late int id;
  late String name;
  late String email;
  late String employeeCode;
}

@RealmModel()
class _Project {
  @PrimaryKey() late int id;
  late String name;
  late int priorityValue;
  late bool isActive;
  late DateTime created;
}

@RealmModel()
class _Issue {
  @PrimaryKey() late int id;
  late String creatorName;
  late String title;
  late String? description;
  late String? link;
  late int statusValue;
  late int priorityValue;
  late DateTime? deadlineDate;
  late DateTime created;
  late _Project? project;
}

@RealmModel()
class _IssueChecklist {
  @PrimaryKey() late int id;
  late String? name;
  late String? description;
  late bool isChecked;
  late bool isActive;
  late _Issue? issue;
}

@RealmModel()
class _IssueActivity {
  @PrimaryKey() late int id;
  late String userName;
  late String? message;
  late DateTime created;
  late _Issue? issue;
}

@RealmModel()
class _Task {
  @PrimaryKey() late int id;
  late String name;
  late int statusValue;
  late String? notes;
  late String? link;
  late DateTime updated;
  late DateTime created;
  late _Project? project;
  late _Issue? issue;
}

@RealmModel()
class _TaskActivity {
  @PrimaryKey() late int id;
  late int oldStatusValue;
  late int newStatusValue;
  late DateTime created;
  late _Task? task;
}

@RealmModel()
class _Comment {
  @PrimaryKey() late int id;
  late String userName;
  late String message;
  late DateTime created;
  late _Task? task;
}
