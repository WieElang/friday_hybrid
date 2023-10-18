enum TaskStatus implements Comparable<TaskStatus> {
  todo(value: 1, displayName: "Todo"),
  wip(value: 2, displayName: "WIP"),
  needReview(value: 3, displayName: "Need Review"),
  needChanges(value: 4, displayName: "Need Changes"),
  done(value: 5, displayName: "Done"),
  hold(value: 6, displayName: "Hold");

  const TaskStatus({
    required this.value,
    required this.displayName
  });

  final int value;
  final String displayName;

  @override
  int compareTo(TaskStatus other) => value - other.value;

  static TaskStatus? getStatus(int value) {
    return TaskStatus.values.where((element) => element.value == value).firstOrNull;
  }
}

enum IssueStatus implements Comparable<IssueStatus> {
  todo(value: 1, displayName: "Todo"),
  wip(value: 2, displayName: "WIP"),
  pendingReview(value: 3, displayName: "Pending Review"),
  needDeploy(value: 4, displayName: "Need Deploy"),
  needUpload(value: 5, displayName: "Need Upload"),
  testing(value: 6, displayName: "Testing"),
  done(value: 7, displayName: "Done"),
  close(value: 8, displayName: "Close"),
  hold(value: 9, displayName: "Hold");

  const IssueStatus({
    required this.value,
    required this.displayName
  });

  final int value;
  final String displayName;

  @override
  int compareTo(IssueStatus other) => value - other.value;

  static IssueStatus? getStatus(int value) {
    return IssueStatus.values.where((element) => element.value == value).firstOrNull;
  }
}

enum IssuePriority implements Comparable<IssuePriority> {
  low(value: 1, displayName: "Low"),
  medium(value: 2, displayName: "Medium"),
  high(value: 3, displayName: "High"),
  highest(value: 4, displayName: "Highest");

  const IssuePriority({
    required this.value,
    required this.displayName
  });

  final int value;
  final String displayName;

  @override
  int compareTo(IssuePriority other) => value - other.value;

  static IssuePriority? getPriority(int value) {
    return IssuePriority.values.where((element) => element.value == value).firstOrNull;
  }
}