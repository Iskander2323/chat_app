class UserModel {
  final String id;
  final String name;
  final String email;

  const UserModel({required this.id, required this.email, required this.name});

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }
}
