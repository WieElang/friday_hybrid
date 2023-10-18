class ApiConstants {
  static String baseUrl = "127.0.0.1:8000";
  // static String baseUrl = "10.0.2.2:8000";

  // Auth
  static String loginEndpoint = "/api/auth/login";
  static String logoutEndPoint = "/api/auth/logout";

  static String projectsEndpoint = "/api/projects/";

  // Issue
  static String issuesEndpoint = "/api/issues/";
  static String issueDetailEndpoint = "/api/issues/details";
  static String editStatusIssueEndpoint = "/api/issues/edit-status";
  static String editIssueChecklistEndpoint = "/api/issues/edit-checklist";

  // Task
  static String tasksEndpoint = "/api/tasks/";
  static String taskDetailEndpoint = "/api/tasks/details";
  static String dailyTaskEndpoint = "/api/tasks/daily";
  static String addTaskEndpoint = "/api/tasks/add-task";
  static String editTaskEndpoint = "/api/tasks/edit-task";
  static String deleteTaskEndpoint = "/api/tasks/delete";

  static const String apiToken = "ZnJpZGF5LXRhc2stbWFuYWdlbWVudC1hcHAtc3RhbXBzLWluZG9uZXNpYS0yMDIz=";
}
