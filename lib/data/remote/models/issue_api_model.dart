// Issue
class IssueListApiModel {
  final List<IssueApiModel> issues;

  const IssueListApiModel({
    required this.issues
  });

  factory IssueListApiModel.fromJson(Map<String, dynamic> json) {
    List<IssueApiModel> issues = [];
    List<dynamic> issueResponse = json['issues'];
    for (final issue in issueResponse) {
      issues.add(IssueApiModel.fromJson(issue));
    }
    return IssueListApiModel(issues: issues);
  }
}

class IssueApiModel {
  final int id;
  final int creatorId;
  final String creatorName;
  final int assignedId;
  final String assignedName;
  final String title;
  final String description;
  final String link;
  final int status;
  final int priority;
  final String deadlineDate;
  final String created;

  const IssueApiModel({
    required this.id,
    required this.creatorId,
    required this.creatorName,
    required this.assignedId,
    required this.assignedName,
    required this.title,
    required this.description,
    required this.link,
    required this.status,
    required this.priority, 
    required this.deadlineDate,
    required this.created
  });
  
  factory IssueApiModel.fromJson(Map<String, dynamic> json) => IssueApiModel(
      id: json['id'],
      creatorId: json['creator_id'],
      creatorName: json['creator_name'],
      assignedId: json['assigned_id'],
      assignedName: json['assigned_name'],
      title: json['title'],
      description: json['description'],
      link: json['link'],
      status: json['status'],
      priority: json['priority'],
      deadlineDate: json['deadline_date'],
      created: json['created']
  );
}

// Issue Checklist
class IssueChecklistListApiModel {
  final List<IssueChecklistApiModel> checklists;

  const IssueChecklistListApiModel({
    required this.checklists
  });

  factory IssueChecklistListApiModel.fromJson(Map<String, dynamic> json) {
    List<IssueChecklistApiModel> checklists = [];
    List<dynamic> checklistResponse = json['checklists'];
    for (final checklist in checklistResponse) {
      checklists.add(IssueChecklistApiModel.fromJson(checklist));
    }
    return IssueChecklistListApiModel(checklists: checklists);
  }
}

class IssueChecklistApiModel {
  final int id;
  final int issueId;
  final String name;
  final String description;
  final bool isChecked;

  const IssueChecklistApiModel({
    required this.id,
    required this.issueId,
    required this.name,
    required this.description,
    required this.isChecked
  });

  factory IssueChecklistApiModel.fromJson(Map<String, dynamic> json) => IssueChecklistApiModel(
      id: json['id'],
      issueId: json['issue_id'],
      name: json['name'],
      description: json['description'],
      isChecked: json['is_checked']
  );
}

// Issue Activity
class IssueActivityListApiModel {
  final List<IssueActivityApiModel> activities;

  const IssueActivityListApiModel({
    required this.activities
  });

  factory IssueActivityListApiModel.fromJson(Map<String, dynamic> json) {
    List<IssueActivityApiModel> activities = [];
    List<dynamic> activityResponse = json['activities'];
    for (final activity in activityResponse) {
      activities.add(IssueActivityApiModel.fromJson(activity));
    }
    return IssueActivityListApiModel(activities: activities);
  }
}

class IssueActivityApiModel {
  final int id;
  final int issueId;
  final String userName;
  final String message;
  final String created;

  const IssueActivityApiModel({
    required this.id,
    required this.issueId,
    required this.userName,
    required this.message,
    required this.created
  });

  factory IssueActivityApiModel.fromJson(Map<String, dynamic> json) => IssueActivityApiModel(
      id: json['id'],
      issueId: json['issue_id'],
      userName: json['user_name'],
      message: json['message'],
      created: json['created']
  );
}