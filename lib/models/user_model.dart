class UserModel {
  final int id;
  final String token;

  UserModel({required this.id, required this.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      token: json['token'],
    );
  }
}
