import 'package:friday_hybrid/data/remote/models/issue_api_model.dart';

// Task
class TaskListApiModel {
  final List<TaskApiModel> tasks;

  const TaskListApiModel({
    required this.tasks
  });

  factory TaskListApiModel.fromJson(Map<String, dynamic> json) {
    List<TaskApiModel> tasks = [];
    List<dynamic> taskResponse = json['tasks'];
    for (final task in taskResponse) {
      tasks.add(TaskApiModel.fromJson(task));
    }
    return TaskListApiModel(tasks: tasks);
  }
}

class TaskDetailApiModel {
  final TaskApiModel task;
  final IssueApiModel issue;

  const TaskDetailApiModel({
    required this.task,
    required this.issue
  });

  factory TaskDetailApiModel.fromJson(Map<String, dynamic> json) => TaskDetailApiModel(
      task: TaskApiModel.fromJson(json['task']),
      issue: IssueApiModel.fromJson(json['issue'])
  );
}

class DailyTaskApiModel {
  final TaskListApiModel tasks;
  final TaskActivityListApiModel activities;

  const DailyTaskApiModel({
    required this.tasks,
    required this.activities
  });

  factory DailyTaskApiModel.fromJson(Map<String, dynamic> json) => DailyTaskApiModel(
      tasks: TaskListApiModel.fromJson(json),
      activities: TaskActivityListApiModel.fromJson(json)
  );
}

class SuccessTaskApiModel {
  final String status;
  final TaskApiModel task;

  const SuccessTaskApiModel({
    required this.status,
    required this.task
  });

  factory SuccessTaskApiModel.fromJson(Map<String, dynamic> json) => SuccessTaskApiModel(
      status: json['status'],
      task: TaskApiModel.fromJson(json['task']),
  );
}

class TaskApiModel {
  final int id;
  final String name;
  final int projectId;
  final int issueId;
  final int status;
  final String? notes;
  final String? link;
  final String updated;
  final String created;
  final TaskActivityListApiModel? activities;

  const TaskApiModel({
    required this.id,
    required this.name,
    required this.projectId,
    required this.issueId,
    required this.status,
    required this.notes,
    required this.link,
    required this.updated,
    required this.created,
    required this.activities
  });

  factory TaskApiModel.fromJson(Map<String, dynamic> json) {
    TaskActivityListApiModel? activities;

    if (json['activities'] != null) {
      activities = TaskActivityListApiModel.fromJson(json);
    }

    return TaskApiModel(
        id: json['id'],
        name: json['name'],
        projectId: json['project_id'],
        issueId: json['issue_id'],
        status: json['status'],
        notes: json['notes'],
        link: json['link'],
        updated: json['updated'],
        created: json['created'],
        activities: activities
    );
  }
}

// Task Activity
class TaskActivityListApiModel {
  final List<TaskActivityApiModel> activities;

  const TaskActivityListApiModel({
    required this.activities
  });

  factory TaskActivityListApiModel.fromJson(Map<String, dynamic> json) {
    List<TaskActivityApiModel> activities = [];
    List<dynamic> activityResponse = json['activities'];
    for (final activity in activityResponse) {
      activities.add(TaskActivityApiModel.fromJson(activity));
    }
    return TaskActivityListApiModel(activities: activities);
  }
}

class TaskActivityApiModel {
  final int id;
  final int taskId;
  final int oldStatus;
  final int newStatus;
  final String created;

  const TaskActivityApiModel({
    required this.id,
    required this.taskId,
    required this.oldStatus,
    required this.newStatus,
    required this.created
  });

  factory TaskActivityApiModel.fromJson(Map<String, dynamic> json) => TaskActivityApiModel(
      id: json['id'],
      taskId: json['task_id'],
      oldStatus: json['old_status'],
      newStatus: json['new_status'],
      created: json['created']
  );
}

// Comment
class CommentListApiModel {
  final List<CommentApiModel> comments;

  const CommentListApiModel({
    required this.comments
  });

  factory CommentListApiModel.fromJson(Map<String, dynamic> json) {
    List<CommentApiModel> comments = [];
    List<dynamic> commentResponse = json['comments'];
    for (final comment in commentResponse) {
      comments.add(CommentApiModel.fromJson(comment));
    }
    return CommentListApiModel(comments: comments);
  }
}

class CommentApiModel {
  final int id;
  final int taskId;
  final String userName;
  final String message;
  final String created;

  const CommentApiModel({
    required this.id,
    required this.taskId,
    required this.userName,
    required this.message,
    required this.created
  });

  factory CommentApiModel.fromJson(Map<String, dynamic> json) => CommentApiModel(
      id: json['id'],
      taskId: json['task_id'],
      userName: json['user_name'],
      message: json['message'],
      created: json['created']
  );
}
