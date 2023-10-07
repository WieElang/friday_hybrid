import 'package:friday_hybrid/data/local/dao/task_dao.dart';
import 'package:friday_hybrid/data/remote/models/task_api_model.dart';
import 'package:realm/realm.dart';

import '../../../utils/date_utils.dart';
import '../realm_database_helper.dart';
import '../schemas.dart';

class TaskActivityDao {
  static RealmResults<TaskActivity> getAll(Realm realm) {
    return realm.all<TaskActivity>();
  }

  static RealmResults<TaskActivity> getByIds(Realm realm, List<int> ids) {
    return realm.query<TaskActivity>('id IN {${ids.join(", ")}}');
  }

  static void fromApiModels(TaskActivityListApiModel taskActivityListApiModel) {
    final realm = realmInstance;

    List<int> activityIds = [];
    List<int> taskIds = [];
    for (final taskActivityApiModel in taskActivityListApiModel.activities) {
      activityIds.add(taskActivityApiModel.id);
      taskIds.add(taskActivityApiModel.taskId);
    }

    final existingActivities = getByIds(realm, activityIds);
    Map<int, TaskActivity> existingActivityMapping = { for (var activity in existingActivities) activity.id: activity };

    final existingTasks = TaskDao.getByIds(realm, taskIds);
    Map<int, Task> existingTaskMapping = { for (var task in existingTasks) task.id : task };

    realm.writeAsync(() {
      for (final taskActivityApiModel in taskActivityListApiModel.activities) {
        final existingActivity = existingActivityMapping[taskActivityApiModel.id];
        final existingTask = existingTaskMapping[taskActivityApiModel.taskId];
        if (existingActivity != null) {
          _updateFromApiModel(existingActivity, taskActivityApiModel, existingTask);
        } else {
          realm.add(_createFromApiModel(taskActivityApiModel, existingTask));
        }
      }
    });
  }

  static TaskActivity _createFromApiModel(TaskActivityApiModel taskActivityApiModel, Task? task) {
    return TaskActivity(
        taskActivityApiModel.id,
        taskActivityApiModel.oldStatus,
        taskActivityApiModel.newStatus,
        DateUtils.getDateTimeFromString(taskActivityApiModel.created),
        task: task
    );
  }

  static TaskActivity _updateFromApiModel(TaskActivity existingActivity, TaskActivityApiModel taskActivityApiModel, Task? task) {
    existingActivity.id = taskActivityApiModel.id;
    existingActivity.oldStatusValue = taskActivityApiModel.oldStatus;
    existingActivity.newStatusValue = taskActivityApiModel.newStatus;
    existingActivity.created = DateUtils.getDateTimeFromString(taskActivityApiModel.created);
    existingActivity.task = task;
    return existingActivity;
  }
}