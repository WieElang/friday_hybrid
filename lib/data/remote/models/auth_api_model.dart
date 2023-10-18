class BaseStatusApiModel {
  final String status;

  const BaseStatusApiModel({
    required this.status
  });

  factory BaseStatusApiModel.fromJson(Map<String, dynamic> json) => BaseStatusApiModel(
      status: json["status"]
  );
}

class LoginApiModel {
  final String status;
  final UserApiModel user;

  const LoginApiModel({
    required this.status,
    required this.user
  });

  factory LoginApiModel.fromJson(Map<String, dynamic> json) => LoginApiModel(
      status: json["status"],
      user: UserApiModel.fromJson(json["user"])
  );
}

class UserApiModel {
  final int id;
  final String name;
  final String email;
  final String employeeCode;

  const UserApiModel({
    required this.id,
    required this.name,
    required this.email,
    required this.employeeCode
  });

  factory UserApiModel.fromJson(Map<String, dynamic> json) => UserApiModel(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      employeeCode: json["employee_code"]
  );
}