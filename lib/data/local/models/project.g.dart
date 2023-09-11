// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

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
