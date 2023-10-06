import 'package:friday_hybrid/data/local/schemas.dart' as schemas;
import 'package:realm/realm.dart';

final realmSchemaClass = [
  schemas.User.schema,
  schemas.Project.schema,
  schemas.Issue.schema,
  schemas.IssueChecklist.schema,
  schemas.IssueActivity.schema,
  schemas.Task.schema,
  schemas.TaskActivity.schema,
  schemas.Comment.schema
];

final config = Configuration.local(realmSchemaClass);
final realmInstance = Realm(config);