class ProjectListApiModel {
  final List<ProjectApiModel> projects;

  const ProjectListApiModel({
    required this.projects
  });

  factory ProjectListApiModel.fromJson(Map<String, dynamic> json) {
    List<ProjectApiModel> projects = [];
    List<dynamic> projectResponse = json['projects'];
    for (final project in projectResponse) {
      projects.add(ProjectApiModel.fromJson(project));
    }
    return ProjectListApiModel(projects: projects);
  }
}

class ProjectApiModel {
  final int id;
  final String name;
  final int priority;
  final bool isActive;
  final String createdString;

  const ProjectApiModel({
    required this.id,
    required this.name,
    required this.priority,
    required this.isActive,
    required this.createdString
  });

  factory ProjectApiModel.fromJson(Map<String, dynamic> json) => ProjectApiModel(
      id: json['id'],
      name: json['name'],
      priority: json['priority'],
      isActive: json['is_active'],
      createdString: json['created']
  );
}