// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schemas.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class User extends _User with RealmEntity, RealmObjectBase, RealmObject {
  User(
    int id,
    String name,
    String email,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'email', email);
  }

  User._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get email => RealmObjectBase.get<String>(this, 'email') as String;
  @override
  set email(String value) => RealmObjectBase.set(this, 'email', value);

  @override
  Stream<RealmObjectChanges<User>> get changes =>
      RealmObjectBase.getChanges<User>(this);

  @override
  User freeze() => RealmObjectBase.freezeObject<User>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(User._);
    return const SchemaObject(ObjectType.realmObject, User, 'User', [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('email', RealmPropertyType.string),
    ]);
  }
}

class Project extends _Project with RealmEntity, RealmObjectBase, RealmObject {
  Project(
    int id,
    String name,
    int priorityValue,
    bool isActive,
    DateTime created,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'priorityValue', priorityValue);
    RealmObjectBase.set(this, 'isActive', isActive);
    RealmObjectBase.set(this, 'created', created);
  }

  Project._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  int get priorityValue =>
      RealmObjectBase.get<int>(this, 'priorityValue') as int;
  @override
  set priorityValue(int value) =>
      RealmObjectBase.set(this, 'priorityValue', value);

  @override
  bool get isActive => RealmObjectBase.get<bool>(this, 'isActive') as bool;
  @override
  set isActive(bool value) => RealmObjectBase.set(this, 'isActive', value);

  @override
  DateTime get created =>
      RealmObjectBase.get<DateTime>(this, 'created') as DateTime;
  @override
  set created(DateTime value) => RealmObjectBase.set(this, 'created', value);

  @override
  Stream<RealmObjectChanges<Project>> get changes =>
      RealmObjectBase.getChanges<Project>(this);

  @override
  Project freeze() => RealmObjectBase.freezeObject<Project>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Project._);
    return const SchemaObject(ObjectType.realmObject, Project, 'Project', [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('priorityValue', RealmPropertyType.int),
      SchemaProperty('isActive', RealmPropertyType.bool),
      SchemaProperty('created', RealmPropertyType.timestamp),
    ]);
  }
}

class Issue extends _Issue with RealmEntity, RealmObjectBase, RealmObject {
  Issue(
    int id,
    String creatorName,
    String title,
    int statusValue,
    int priorityValue,
    DateTime created, {
    String? description,
    String? link,
    DateTime? deadlineDate,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'creatorName', creatorName);
    RealmObjectBase.set(this, 'title', title);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'link', link);
    RealmObjectBase.set(this, 'statusValue', statusValue);
    RealmObjectBase.set(this, 'priorityValue', priorityValue);
    RealmObjectBase.set(this, 'deadlineDate', deadlineDate);
    RealmObjectBase.set(this, 'created', created);
  }

  Issue._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get creatorName =>
      RealmObjectBase.get<String>(this, 'creatorName') as String;
  @override
  set creatorName(String value) =>
      RealmObjectBase.set(this, 'creatorName', value);

  @override
  String get title => RealmObjectBase.get<String>(this, 'title') as String;
  @override
  set title(String value) => RealmObjectBase.set(this, 'title', value);

  @override
  String? get description =>
      RealmObjectBase.get<String>(this, 'description') as String?;
  @override
  set description(String? value) =>
      RealmObjectBase.set(this, 'description', value);

  @override
  String? get link => RealmObjectBase.get<String>(this, 'link') as String?;
  @override
  set link(String? value) => RealmObjectBase.set(this, 'link', value);

  @override
  int get statusValue => RealmObjectBase.get<int>(this, 'statusValue') as int;
  @override
  set statusValue(int value) => RealmObjectBase.set(this, 'statusValue', value);

  @override
  int get priorityValue =>
      RealmObjectBase.get<int>(this, 'priorityValue') as int;
  @override
  set priorityValue(int value) =>
      RealmObjectBase.set(this, 'priorityValue', value);

  @override
  DateTime? get deadlineDate =>
      RealmObjectBase.get<DateTime>(this, 'deadlineDate') as DateTime?;
  @override
  set deadlineDate(DateTime? value) =>
      RealmObjectBase.set(this, 'deadlineDate', value);

  @override
  DateTime get created =>
      RealmObjectBase.get<DateTime>(this, 'created') as DateTime;
  @override
  set created(DateTime value) => RealmObjectBase.set(this, 'created', value);

  @override
  Stream<RealmObjectChanges<Issue>> get changes =>
      RealmObjectBase.getChanges<Issue>(this);

  @override
  Issue freeze() => RealmObjectBase.freezeObject<Issue>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Issue._);
    return const SchemaObject(ObjectType.realmObject, Issue, 'Issue', [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('creatorName', RealmPropertyType.string),
      SchemaProperty('title', RealmPropertyType.string),
      SchemaProperty('description', RealmPropertyType.string, optional: true),
      SchemaProperty('link', RealmPropertyType.string, optional: true),
      SchemaProperty('statusValue', RealmPropertyType.int),
      SchemaProperty('priorityValue', RealmPropertyType.int),
      SchemaProperty('deadlineDate', RealmPropertyType.timestamp,
          optional: true),
      SchemaProperty('created', RealmPropertyType.timestamp),
    ]);
  }
}

class IssueChecklist extends _IssueChecklist
    with RealmEntity, RealmObjectBase, RealmObject {
  IssueChecklist(
    int id,
    bool isChecked,
    bool isActive, {
    String? name,
    String? description,
    Issue? issue,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'isChecked', isChecked);
    RealmObjectBase.set(this, 'isActive', isActive);
    RealmObjectBase.set(this, 'issue', issue);
  }

  IssueChecklist._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  String? get name => RealmObjectBase.get<String>(this, 'name') as String?;
  @override
  set name(String? value) => RealmObjectBase.set(this, 'name', value);

  @override
  String? get description =>
      RealmObjectBase.get<String>(this, 'description') as String?;
  @override
  set description(String? value) =>
      RealmObjectBase.set(this, 'description', value);

  @override
  bool get isChecked => RealmObjectBase.get<bool>(this, 'isChecked') as bool;
  @override
  set isChecked(bool value) => RealmObjectBase.set(this, 'isChecked', value);

  @override
  bool get isActive => RealmObjectBase.get<bool>(this, 'isActive') as bool;
  @override
  set isActive(bool value) => RealmObjectBase.set(this, 'isActive', value);

  @override
  Issue? get issue => RealmObjectBase.get<Issue>(this, 'issue') as Issue?;
  @override
  set issue(covariant Issue? value) =>
      RealmObjectBase.set(this, 'issue', value);

  @override
  Stream<RealmObjectChanges<IssueChecklist>> get changes =>
      RealmObjectBase.getChanges<IssueChecklist>(this);

  @override
  IssueChecklist freeze() => RealmObjectBase.freezeObject<IssueChecklist>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(IssueChecklist._);
    return const SchemaObject(
        ObjectType.realmObject, IssueChecklist, 'IssueChecklist', [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string, optional: true),
      SchemaProperty('description', RealmPropertyType.string, optional: true),
      SchemaProperty('isChecked', RealmPropertyType.bool),
      SchemaProperty('isActive', RealmPropertyType.bool),
      SchemaProperty('issue', RealmPropertyType.object,
          optional: true, linkTarget: 'Issue'),
    ]);
  }
}

class IssueActivity extends _IssueActivity
    with RealmEntity, RealmObjectBase, RealmObject {
  IssueActivity(
    int id,
    String userName,
    DateTime created, {
    String? message,
    Issue? issue,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'userName', userName);
    RealmObjectBase.set(this, 'message', message);
    RealmObjectBase.set(this, 'created', created);
    RealmObjectBase.set(this, 'issue', issue);
  }

  IssueActivity._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get userName =>
      RealmObjectBase.get<String>(this, 'userName') as String;
  @override
  set userName(String value) => RealmObjectBase.set(this, 'userName', value);

  @override
  String? get message =>
      RealmObjectBase.get<String>(this, 'message') as String?;
  @override
  set message(String? value) => RealmObjectBase.set(this, 'message', value);

  @override
  DateTime get created =>
      RealmObjectBase.get<DateTime>(this, 'created') as DateTime;
  @override
  set created(DateTime value) => RealmObjectBase.set(this, 'created', value);

  @override
  Issue? get issue => RealmObjectBase.get<Issue>(this, 'issue') as Issue?;
  @override
  set issue(covariant Issue? value) =>
      RealmObjectBase.set(this, 'issue', value);

  @override
  Stream<RealmObjectChanges<IssueActivity>> get changes =>
      RealmObjectBase.getChanges<IssueActivity>(this);

  @override
  IssueActivity freeze() => RealmObjectBase.freezeObject<IssueActivity>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(IssueActivity._);
    return const SchemaObject(
        ObjectType.realmObject, IssueActivity, 'IssueActivity', [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('userName', RealmPropertyType.string),
      SchemaProperty('message', RealmPropertyType.string, optional: true),
      SchemaProperty('created', RealmPropertyType.timestamp),
      SchemaProperty('issue', RealmPropertyType.object,
          optional: true, linkTarget: 'Issue'),
    ]);
  }
}

class Task extends _Task with RealmEntity, RealmObjectBase, RealmObject {
  Task(
    int id,
    String name,
    int statusValue,
    DateTime updated,
    DateTime created, {
    String? notes,
    String? link,
    Project? project,
    Issue? issue,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'statusValue', statusValue);
    RealmObjectBase.set(this, 'notes', notes);
    RealmObjectBase.set(this, 'link', link);
    RealmObjectBase.set(this, 'updated', updated);
    RealmObjectBase.set(this, 'created', created);
    RealmObjectBase.set(this, 'project', project);
    RealmObjectBase.set(this, 'issue', issue);
  }

  Task._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  int get statusValue => RealmObjectBase.get<int>(this, 'statusValue') as int;
  @override
  set statusValue(int value) => RealmObjectBase.set(this, 'statusValue', value);

  @override
  String? get notes => RealmObjectBase.get<String>(this, 'notes') as String?;
  @override
  set notes(String? value) => RealmObjectBase.set(this, 'notes', value);

  @override
  String? get link => RealmObjectBase.get<String>(this, 'link') as String?;
  @override
  set link(String? value) => RealmObjectBase.set(this, 'link', value);

  @override
  DateTime get updated =>
      RealmObjectBase.get<DateTime>(this, 'updated') as DateTime;
  @override
  set updated(DateTime value) => RealmObjectBase.set(this, 'updated', value);

  @override
  DateTime get created =>
      RealmObjectBase.get<DateTime>(this, 'created') as DateTime;
  @override
  set created(DateTime value) => RealmObjectBase.set(this, 'created', value);

  @override
  Project? get project =>
      RealmObjectBase.get<Project>(this, 'project') as Project?;
  @override
  set project(covariant Project? value) =>
      RealmObjectBase.set(this, 'project', value);

  @override
  Issue? get issue => RealmObjectBase.get<Issue>(this, 'issue') as Issue?;
  @override
  set issue(covariant Issue? value) =>
      RealmObjectBase.set(this, 'issue', value);

  @override
  Stream<RealmObjectChanges<Task>> get changes =>
      RealmObjectBase.getChanges<Task>(this);

  @override
  Task freeze() => RealmObjectBase.freezeObject<Task>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Task._);
    return const SchemaObject(ObjectType.realmObject, Task, 'Task', [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('statusValue', RealmPropertyType.int),
      SchemaProperty('notes', RealmPropertyType.string, optional: true),
      SchemaProperty('link', RealmPropertyType.string, optional: true),
      SchemaProperty('updated', RealmPropertyType.timestamp),
      SchemaProperty('created', RealmPropertyType.timestamp),
      SchemaProperty('project', RealmPropertyType.object,
          optional: true, linkTarget: 'Project'),
      SchemaProperty('issue', RealmPropertyType.object,
          optional: true, linkTarget: 'Issue'),
    ]);
  }
}

class TaskActivity extends _TaskActivity
    with RealmEntity, RealmObjectBase, RealmObject {
  TaskActivity(
    int id,
    int oldStatusValue,
    int newStatusValue,
    DateTime created, {
    Task? task,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'oldStatusValue', oldStatusValue);
    RealmObjectBase.set(this, 'newStatusValue', newStatusValue);
    RealmObjectBase.set(this, 'created', created);
    RealmObjectBase.set(this, 'task', task);
  }

  TaskActivity._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  int get oldStatusValue =>
      RealmObjectBase.get<int>(this, 'oldStatusValue') as int;
  @override
  set oldStatusValue(int value) =>
      RealmObjectBase.set(this, 'oldStatusValue', value);

  @override
  int get newStatusValue =>
      RealmObjectBase.get<int>(this, 'newStatusValue') as int;
  @override
  set newStatusValue(int value) =>
      RealmObjectBase.set(this, 'newStatusValue', value);

  @override
  DateTime get created =>
      RealmObjectBase.get<DateTime>(this, 'created') as DateTime;
  @override
  set created(DateTime value) => RealmObjectBase.set(this, 'created', value);

  @override
  Task? get task => RealmObjectBase.get<Task>(this, 'task') as Task?;
  @override
  set task(covariant Task? value) => RealmObjectBase.set(this, 'task', value);

  @override
  Stream<RealmObjectChanges<TaskActivity>> get changes =>
      RealmObjectBase.getChanges<TaskActivity>(this);

  @override
  TaskActivity freeze() => RealmObjectBase.freezeObject<TaskActivity>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(TaskActivity._);
    return const SchemaObject(
        ObjectType.realmObject, TaskActivity, 'TaskActivity', [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('oldStatusValue', RealmPropertyType.int),
      SchemaProperty('newStatusValue', RealmPropertyType.int),
      SchemaProperty('created', RealmPropertyType.timestamp),
      SchemaProperty('task', RealmPropertyType.object,
          optional: true, linkTarget: 'Task'),
    ]);
  }
}

class Comment extends _Comment with RealmEntity, RealmObjectBase, RealmObject {
  Comment(
    int id,
    String userName,
    String message,
    DateTime created, {
    Task? task,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'userName', userName);
    RealmObjectBase.set(this, 'message', message);
    RealmObjectBase.set(this, 'created', created);
    RealmObjectBase.set(this, 'task', task);
  }

  Comment._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get userName =>
      RealmObjectBase.get<String>(this, 'userName') as String;
  @override
  set userName(String value) => RealmObjectBase.set(this, 'userName', value);

  @override
  String get message => RealmObjectBase.get<String>(this, 'message') as String;
  @override
  set message(String value) => RealmObjectBase.set(this, 'message', value);

  @override
  DateTime get created =>
      RealmObjectBase.get<DateTime>(this, 'created') as DateTime;
  @override
  set created(DateTime value) => RealmObjectBase.set(this, 'created', value);

  @override
  Task? get task => RealmObjectBase.get<Task>(this, 'task') as Task?;
  @override
  set task(covariant Task? value) => RealmObjectBase.set(this, 'task', value);

  @override
  Stream<RealmObjectChanges<Comment>> get changes =>
      RealmObjectBase.getChanges<Comment>(this);

  @override
  Comment freeze() => RealmObjectBase.freezeObject<Comment>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Comment._);
    return const SchemaObject(ObjectType.realmObject, Comment, 'Comment', [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('userName', RealmPropertyType.string),
      SchemaProperty('message', RealmPropertyType.string),
      SchemaProperty('created', RealmPropertyType.timestamp),
      SchemaProperty('task', RealmPropertyType.object,
          optional: true, linkTarget: 'Task'),
    ]);
  }
}
