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

  const UserApiModel({
    required this.id,
    required this.name,
    required this.email
  });

  factory UserApiModel.fromJson(Map<String, dynamic> json) => UserApiModel(
      id: json["id"],
      name: json["name"],
      email: json["email"]
  );
}