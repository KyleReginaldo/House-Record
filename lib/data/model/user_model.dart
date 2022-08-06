import '../../domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  @override
  final String email;
  @override
  final String password;
  @override
  final String role;
  @override
  final String username;
  UserModel({
    required this.email,
    required this.password,
    required this.role,
    required this.username,
  }) : super(
          email: email,
          password: password,
          role: role,
          username: username,
        );
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? "",
      password: map['password'] ?? '',
      role: map['role'],
      username: map['username'],
    );
  }
  factory UserModel.fromEntity(UserEntity user) {
    return UserModel(
      email: user.email,
      password: user.password,
      role: user.role,
      username: user.username,
    );
  }
  Map<String, dynamic> toMap() => {
        'email': email,
        'password': password,
        'role': role,
        'username': username,
      };
}
