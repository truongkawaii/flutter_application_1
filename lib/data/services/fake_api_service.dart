class FakeApiService {
  static const Duration _apiDelay = Duration(seconds: 1);

  // Fake data Json
  static final List<Map<String, dynamic>> _fakeUsersData = [
    {
      'id': '1',
      'name': 'Nguyễn Văn An',
      'email': 'an.nguyen@example.com',
      'phone': '+84 901 234 567',
      'avatar': 'https://i.pravatar.cc/150?img=1',
      'position': 'Senior Developer',
      'department': 'Engineering',
    },
    {
      'id': '2',
      'name': 'Trần Thị Bình',
      'email': 'binh.tran@example.com',
      'phone': '+84 902 345 678',
      'avatar': 'https://i.pravatar.cc/150?img=2',
      'position': 'Product Manager',
      'department': 'Product',
    },
    {
      'id': '3',
      'name': 'Lê Hoàng Cường',
      'email': 'cuong.le@example.com',
      'phone': '+84 903 456 789',
      'avatar': 'https://i.pravatar.cc/150?img=3',
      'position': 'UI/UX Designer',
      'department': 'Design',
    },
    {
      'id': '4',
      'name': 'Phạm Minh Đức',
      'email': 'duc.pham@example.com',
      'phone': '+84 904 567 890',
      'avatar': 'https://i.pravatar.cc/150?img=4',
      'position': 'DevOps Engineer',
      'department': 'Engineering',
    },
    {
      'id': '5',
      'name': 'Võ Thị Hoa',
      'email': 'hoa.vo@example.com',
      'phone': '+84 905 678 901',
      'avatar': 'https://i.pravatar.cc/150?img=5',
      'position': 'QA Engineer',
      'department': 'Quality Assurance',
    },
  ];

  // Dữ liệu mutable để thực hiện CRUD
  static List<Map<String, dynamic>> _users = List.from(_fakeUsersData);

  // GET - lấy tất cả users
  static Future<List<Map<String, dynamic>>> fetchUsers() async {
    await Future.delayed(_apiDelay);
    return List.from(_users);
  }

  // GET - lấy user theo ID
  static Future<Map<String, dynamic>?> fetchUserById(String id) async {
    await Future.delayed(_apiDelay);
    try {
      return _users.firstWhere((user) => user['id'] == id);
    } catch (e) {
      return null;
    }
  }

  // POST - tạo user mới
  static Future<Map<String, dynamic>> createUser(
    Map<String, dynamic> userData,
  ) async {
    await Future.delayed(_apiDelay);

    // Generate ID mới
    final newId = (_users.length + 1).toString();
    final newUser = {'id': newId, ...userData};

    _users.add(newUser);
    return newUser;
  }

  // PUT - cập nhật user
  static Future<Map<String, dynamic>> updateUser(
    String id,
    Map<String, dynamic> userData,
  ) async {
    await Future.delayed(_apiDelay);

    final index = _users.indexWhere((user) => user['id'] == id);
    if (index != -1) {
      _users[index] = {'id': id, ...userData};
      return _users[index];
    }
    throw Exception('User not found');
  }

  // DELETE - xóa user
  static Future<bool> deleteUser(String id) async {
    await Future.delayed(_apiDelay);

    final index = _users.indexWhere((user) => user['id'] == id);
    if (index != -1) {
      _users.removeAt(index);
      return true;
    }
    return false;
  }

  // Reset về dữ liệu ban đầu
  static void resetData() {
    _users = List.from(_fakeUsersData);
  }
}
