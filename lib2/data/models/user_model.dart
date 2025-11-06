import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String avatar;
  final String position;
  final String department;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.avatar,
    required this.position,
    required this.department,
  });

  // Tạo User từ Json
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      avatar: json['avatar'] as String,
      position: json['position'] as String,
      department: json['department'] as String,
    );
  }

  // Convert User sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'avatar': avatar,
      'position': position,
      'department': department,
    };
  }

  // CopyWith để update một số field
  UserModel copyWith(
    String? id,
    String? name,
    String? email,
    String? phone,
    String? avatar,
    String? position,
    String? department,
  ) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
      position: position ?? this.position,
      department: department ?? this.department,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    phone,
    avatar,
    position,
    department,
  ];
}
