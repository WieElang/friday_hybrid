import 'package:friday_hybrid/data/local/dao/issue_dao.dart';
import 'package:friday_hybrid/data/local/dao/project_dao.dart';
import 'package:friday_hybrid/data/remote/models/task_api_model.dart';
import 'package:realm/realm.dart';

import '../../../utils/date_utils.dart';
import '../schemas.dart';
import '../realm_database_helper.dart';

class TaskDao {
  static RealmResults<Task> getAll(Realm realm) {
    return realm.all<Task>();
  }

  static RealmResults<Task> getByIds(Realm realm, List<int> ids) {
    return realm.query<Task>('id IN {${ids.join(", ")}}');
  }

  static void fromApiModels(TaskListApiModel taskListApiModel) {
    final realm = realmInstance;

    List<int> taskIds = [];
    List<int> projectIds = [];
    List<int> issueIds = [];
    for (final taskApiModel in taskListApiModel.tasks) {
      taskIds.add(taskApiModel.id);
      projectIds.add(taskApiModel.projectId);
      issueIds.add(taskApiModel.issueId);
    }

    final existingTasks = getByIds(realm, taskIds);
    Map<int, Task> existingTaskMapping = { for (var task in existingTasks) task.id : task };

    final existingProjects = ProjectDao.getByIds(realm, projectIds);
    Map<int, Project> existingProjectMapping = { for (var project in existingProjects) project.id : project };

    final existingIssues = IssueDao.getByIds(realm, issueIds);
    Map<int, Issue> existingIssueMapping = { for (var issue in existingIssues) issue.id : issue };

    realm.writeAsync(() {
      for (final taskApiModel in taskListApiModel.tasks) {
        final existingTask = existingTaskMapping[taskApiModel.id];
        final existingProject = existingProjectMapping[taskApiModel.projectId];
        final existingIssue = existingIssueMapping[taskApiModel.issueId];
        if (existingTask != null) {
          _updateFromApiModel(existingTask, taskApiModel, existingProject, existingIssue);
        } else {
          realm.add(_createFromApiModel(taskApiModel, existingProject, existingIssue));
        }
      }
    });
  }

  static Task _createFromApiModel(TaskApiModel taskApiModel, Project? project, Issue? issue) {
    return Task(
        taskApiModel.id,
        taskApiModel.name,
        taskApiModel.status,
        taskApiModel.notes,
        taskApiModel.link,
        DateUtils.getDateTimeFromString(taskApiModel.updated),
        DateUtils.getDateTimeFromString(taskApiModel.created),
        project: project,
        issue: issue
    );
  }

  static Task _updateFromApiModel(Task existingTask, TaskApiModel taskApiModel, Project? project, Issue? issue) {
    existingTask.id = taskApiModel.id;
    existingTask.name = taskApiModel.name;
    existingTask.statusValue = taskApiModel.status;
    existingTask.notes = taskApiModel.notes;
    existingTask.link = taskApiModel.link;
    existingTask.updated = DateUtils.getDateTimeFromString(taskApiModel.updated);
    existingTask.created = DateUtils.getDateTimeFromString(taskApiModel.created);
    existingTask.project = project;
    existingTask.issue = issue;
    return existingTask;
  }
}