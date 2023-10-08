import 'package:realm/realm.dart';

import '../../../utils/date_utils.dart';
import '../../remote/models/project_api_model.dart';
import '../schemas.dart';
import '../realm_database_helper.dart';

class ProjectDao {
  static RealmResults<Project> getAll(Realm realm) {
    return realm.all<Project>();
  }

  static RealmResults<Project> getActive(Realm realm) {
    return realm.query<Project>('isActive == ${true}');
  }

  static RealmResults<Project> getByIds(Realm realm, List<int> ids) {
    return realm.query<Project>('id IN {${ids.join(", ")}}');
  }

  static void fromApiModels(ProjectListApiModel projectListApiModel) {
    final realm = realmInstance;

    List<int> projectIds = [];
    for (final projectApiModel in projectListApiModel.projects) {
      projectIds.add(projectApiModel.id);
    }

    final existingProjects = getByIds(realm, projectIds);
    Map<int, Project> existingProjectMapping = { for (var project in existingProjects) project.id : project };
    realm.writeAsync(() {
      for (final projectApiModel in projectListApiModel.projects) {
        final existingProject = existingProjectMapping[projectApiModel.id];
        if (existingProject != null) {
          _updateFromApiModel(existingProject, projectApiModel);
        } else {
          realm.add(_createFromApiModel(projectApiModel));
        }
      }
    });
  }

  static Project _createFromApiModel(ProjectApiModel projectApiModel) {
    return Project(
        projectApiModel.id,
        projectApiModel.name,
        projectApiModel.priority,
        projectApiModel.isActive,
        DateUtils.getDateTimeFromString(projectApiModel.created)!
    );
  }

  static Project _updateFromApiModel(Project existingProject, ProjectApiModel projectApiModel) {
    existingProject.id = projectApiModel.id;
    existingProject.name = projectApiModel.name;
    existingProject.priorityValue = projectApiModel.priority;
    existingProject.isActive = projectApiModel.isActive;
    existingProject.created = DateUtils.getDateTimeFromString(projectApiModel.created)!;
    return existingProject;
  }
}