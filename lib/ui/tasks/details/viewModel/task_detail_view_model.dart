import 'package:flutter/material.dart';
import 'package:friday_hybrid/data/local/dao/comment_dao.dart';
import 'package:friday_hybrid/data/local/dao/task_activity_dao.dart';
import 'package:friday_hybrid/data/local/realm_database_helper.dart';
import 'package:friday_hybrid/data/repository/task_repository.dart';

import '../../../../data/base_data.dart';
import '../../../../data/local/schemas.dart';


class TaskDetailViewModel with ChangeNotifier {
  BaseData<Task> _taskData = BaseData(null, null, exception: null);
  BaseData<Task> get taskData {
    return _taskData;
  }

  List<TaskActivity> _activities = [];
  List<TaskActivity> get activities {
    return _activities;
  }

  List<Comment> _comments = [];
  List<Comment> get comments {
    return _comments;
  }

  void getTask(int taskId) async {
    _taskData = await TaskRepository().getTask(taskId);
    if (_taskData.data != null) {
      final realm = realmInstance;
      final task = _taskData.data!;
      final taskActivities = TaskActivityDao.getByTask(realm, task.id);
      _activities = taskActivities.toList();

      final taskComments = CommentDao.getByTask(realm, task.id);
      _comments = taskComments.toList();
    } else {
      _activities = [];
      _comments = [];
    }
    notifyListeners();
  }
}
