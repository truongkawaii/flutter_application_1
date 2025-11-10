class AppRoutes {
  // Private constructor để ngăn khởi tạo
  AppRoutes._();

  // Route paths
  static const String home = '/home';
  static const String statistics = '/statistics';
  static const String profile = '/profile';
  static const String taskDetail = '/task/:id';

  // Route names
  static const String homeName = 'home';
  static const String statisticsName = 'statistics';
  static const String profileName = 'profile';
  static const String taskDetailName = 'task-detail';

  // Helper methods để tạo route với parameters
  static String taskDetailRoute(String taskId) => '/task/$taskId';
}
