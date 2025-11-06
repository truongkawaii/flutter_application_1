import 'package:flutter_application_1/data/models/user_model.dart';
import 'package:flutter_application_1/data/respositories/user_respository.dart';
import 'package:flutter_application_1/logic/blocs/user_bloc/user_event.dart';
import 'package:flutter_application_1/logic/blocs/user_bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository repository;

  UserBloc(this.repository) : super(UserInitial()) {
    // Đăng ký handlers cho từng event
    on<LoadUsersEvent>(_onLoadUsers);
    on<CreateUserEvent>(_onCreateUser);
    on<UpdateUserEvent>(_onUpdateUser);
    on<DeleteUserEvent>(_onDeleteUser);
    on<SelectUserEvent>(_onSelectUser);
  }
  // Xử lý LoadUsersEvent
  Future<void> _onLoadUsers(
    LoadUsersEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    try {
      final users = await repository.getUsers();
      emit(UserLoaded(users: users));
    } catch (e) {
      emit(UserError('Lỗi khi tải danh sách users: $e'));
    }
  }

  // Xử lý CreateUserEvent
  Future<void> _onCreateUser(
    CreateUserEvent event,
    Emitter<UserState> emit,
  ) async {
    if (state is UserLoaded) {
      emit(UserLoading());
      try {
        final newUser = await repository.createUser(event.user);
        final currentState = state as UserLoaded;
        final updatedUsers = List<UserModel>.from(currentState.users)
          ..add(newUser);
        emit(UserLoaded(users: updatedUsers));
        emit(const UserOperationSuccess('Thêm user thành công'));
        emit(UserLoaded(users: updatedUsers));
      } catch (e) {
        emit(UserError('Lỗi khi thêm user: $e'));
      }
    }
  }

  /// Handler: Update user
  Future<void> _onUpdateUser(
    UpdateUserEvent event,
    Emitter<UserState> emit,
  ) async {
    if (state is UserLoaded) {
      emit(UserLoading());
      try {
        final updatedUser = await repository.updateUser(event.user);
        final currentState = state as UserLoaded;
        final updatedUsers = currentState.users.map((user) {
          return user.id == updatedUser.id ? updatedUser : user;
        }).toList();

        emit(UserLoaded(users: updatedUsers));
        emit(const UserOperationSuccess('User updated successfully'));
        emit(UserLoaded(users: updatedUsers));
      } catch (e) {
        emit(UserError('Failed to update user: ${e.toString()}'));
      }
    }
  }

  /// Handler: Delete user
  Future<void> _onDeleteUser(
    DeleteUserEvent event,
    Emitter<UserState> emit,
  ) async {
    if (state is UserLoaded) {
      emit(UserLoading());
      try {
        await repository.deleteUser(event.userId);
        final currentState = state as UserLoaded;
        final updatedUsers = currentState.users
            .where((user) => user.id != event.userId)
            .toList();

        emit(UserLoaded(users: updatedUsers));
        emit(const UserOperationSuccess('User deleted successfully'));
        emit(UserLoaded(users: updatedUsers));
      } catch (e) {
        emit(UserError('Failed to delete user: ${e.toString()}'));
      }
    }
  }

  /// Handler: Select user
  Future<void> _onSelectUser(
    SelectUserEvent event,
    Emitter<UserState> emit,
  ) async {
    if (state is UserLoaded) {
      final currentState = state as UserLoaded;
      emit(UserLoaded(users: currentState.users, selectedUser: event.user));
    }
  }
}
