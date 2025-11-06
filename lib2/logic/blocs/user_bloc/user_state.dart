import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/data/models/user_model.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

// State: khởi tạo
class UserInitial extends UserState {}

// State: Đang loading
class UserLoading extends UserState {}

// State: Load thành công
class UserLoaded extends UserState {
  final List<UserModel> users;
  final UserModel? selectedUser;

  const UserLoaded({required this.users, this.selectedUser});

  @override
  List<Object?> get props => [users, selectedUser];

  // CopyWith để update state
  UserLoaded copyWith(List<UserModel>? users, UserModel? selectedUser) {
    return UserLoaded(
      users: users ?? this.users,
      selectedUser: selectedUser ?? this.selectedUser,
    );
  }
}

// State : Lỗi xảy ra
class UserError extends UserState {
  final String message;
  const UserError(this.message);
  @override
  List<Object?> get props => [message];
}

// State: Operation thành công (thêm, sửa, xóa)
class UserOperationSuccess extends UserState {
  final String message;
  const UserOperationSuccess(this.message);
  @override
  List<Object?> get props => [message];
}