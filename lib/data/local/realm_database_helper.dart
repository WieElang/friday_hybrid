import 'package:friday_hybrid/data/local/models/project.dart';
import 'package:realm/realm.dart';

final realmSchemaClass = [
  Project.schema
];

final config = Configuration.local(realmSchemaClass);
final realmInstance = Realm(config);