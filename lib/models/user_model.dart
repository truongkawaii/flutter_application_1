class User {
  final String name;
  final String email;
  final String avatarUrl;
  final int completedTasks;
  final int totalTasks;

  User({
    required this.name,
    required this.email,
    required this.avatarUrl,
    required this.completedTasks,
    required this.totalTasks,
  });
}
