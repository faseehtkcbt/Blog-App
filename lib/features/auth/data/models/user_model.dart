import '../../../../core/utils/entities/user.dart';

class UserModel extends UserEntity {
  final String id;
  final String email;
  final String name;
  UserModel({
    required this.email,
    required this.name,
    required this.id,
  }) : super(email: email, name: name, id: id);

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
        email: map['email'] ?? '',
        name: map['name'] ?? '',
        id: map['id'] ?? '');
  }

  UserModel copyWith({String? id, String? name, String? email}) {
    return UserModel(
        email: email ?? this.email, name: name ?? this.name, id: id ?? this.id);
  }
}
