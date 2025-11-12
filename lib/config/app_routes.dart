class AppRoutes {
  AppRoutes._();

  // Route paths
  static const String home = '/home';
  static const String statistics = '/statistics';
  static const String profile = '/profile';
  static const String taskDetail = '/task/:id';
  static const String createTask = '/create-task'; // NEW

  // Route names
  static const String homeName = 'home';
  static const String statisticsName = 'statistics';
  static const String profileName = 'profile';
  static const String taskDetailName = 'task-detail';
  static const String createTaskName = 'create-task'; // NEW

  // Helper methods
  static String taskDetailRoute(String taskId) => '/task/$taskId';
}
