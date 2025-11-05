import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/data/models/user_model.dart';


// Các event cho User BLoC 
abstract class UserEvent extends Equatable{
  const UserEvent();

  @override
  List<Object?> get props => [];
}

// Event: load danh sách users
class LoadUsersEvent extends UserEvent {}

// Event: thêm user mới
class CreateUserEvent extends UserEvent {
  final UserModel user;
  const CreateUserEvent(this.user);

  @override
  List<Object?> get props => [user];
}

// Event: cập nhật user
class UpdateUserEvent extends UserEvent{
  final UserModel user;

  const UpdateUserEvent(this.user);
  @override
  List<Object?> get props => [user];
}

// Event: xóa user
class DeleteUserEvent extends UserEvent{
  final String userId;

  const DeleteUserEvent(this.userId);
  @override
  List<Object?> get props => [userId];
}

// Event: load chi tiết user
class SelectUserEvent extends UserEvent{
  final UserModel? user;
  const SelectUserEvent(this.user);

  @override
  List<Object?> get props => [user];
}