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

class TaskApiModel {
  final int id;
  final String name;
  final int issueId;
  final int status;
  final String notes;
  final String link;
  final String updated;
  final String created;

  const TaskApiModel({
    required this.id,
    required this.name,
    required this.issueId,
    required this.status,
    required this.notes,
    required this.link,
    required this.updated,
    required this.created
  });

  factory TaskApiModel.fromJson(Map<String, dynamic> json) => TaskApiModel(
      id: json['id'],
      name: json['name'],
      issueId: json['issue_id'],
      status: json['status'],
      notes: json['notes'],
      link: json['link'],
      updated: json['updated'],
      created: json['created']
  );
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
  final String name;
  final String description;
  final String created;

  const TaskActivityApiModel({
    required this.id,
    required this.taskId,
    required this.name,
    required this.description,
    required this.created
  });

  factory TaskActivityApiModel.fromJson(Map<String, dynamic> json) => TaskActivityApiModel(
      id: json['id'],
      taskId: json['task_id'],
      name: json['name'],
      description: json['description'],
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
