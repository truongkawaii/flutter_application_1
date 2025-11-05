import 'package:flutter_application_1/data/models/user_model.dart';
import 'package:flutter_application_1/data/services/fake_api_service.dart';

class UserRepository {
  // Lấy tất cả users
  Future<List<UserModel>> getUsers() async {
    try {
      final usersJson = await FakeApiService.fetchUsers();
      return usersJson.map((json) => UserModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Lỗi khi lấy danh sách users: $e');
    }
  }

  // Lấy user theo ID
  Future<UserModel?> getUserById(String id) async {
    try {
      final userJson = await FakeApiService.fetchUserById(id);
      if (userJson != null) {
        return UserModel.fromJson(userJson);
      }
    } catch (e) {
      throw Exception('Lỗi khi lấy user theo ID: $e');
    }
  }

  // Tạo user mới
  Future<UserModel> createUser(UserModel user) async {
    try {
      final userJson = await FakeApiService.createUser(user.toJson());
      return UserModel.fromJson(userJson);
    } catch (e) {
      throw Exception('Lỗi khi tạo user mới: $e');
    }
  }

  // Cập nhật user
  Future<UserModel> updateUser(UserModel user) async {
    try {
      final userJson = await FakeApiService.updateUser(user.id, user.toJson());
      return UserModel.fromJson(userJson);
    } catch (e) {
      throw Exception('Lỗi khi cập nhật user: $e');
    }
  }

  // Xóa user
  Future<bool> deleteUser(String id) async {
    try {
      return await FakeApiService.deleteUser(id);
    } catch (e) {
      throw Exception('Lỗi khi xóa user: $e');
    }
  }
}
