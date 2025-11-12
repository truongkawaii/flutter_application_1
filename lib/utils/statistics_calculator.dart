import '../models/task_model.dart';

class StatisticsData {
  final int completedTasks;
  final int pendingTasks;
  final int totalTasks;
  final double completionRate;
  final Map<TaskCategory, int> categoryStats;
  final Map<TaskPriority, int> priorityStats;

  StatisticsData({
    required this.completedTasks,
    required this.pendingTasks,
    required this.totalTasks,
    required this.completionRate,
    required this.categoryStats,
    required this.priorityStats,
  });
}

class StatisticsCalculator {
  static StatisticsData calculate(List<Task> tasks) {
    final completedTasks = tasks.where((t) => t.isCompleted).length;
    final pendingTasks = tasks.length - completedTasks;
    final completionRate = tasks.isEmpty ? 0.0 : (completedTasks / tasks.length * 100);

    // Category breakdown
    final categoryStats = <TaskCategory, int>{};
    for (var task in tasks) {
      categoryStats[task.category] = (categoryStats[task.category] ?? 0) + 1;
    }

    // Priority breakdown
    final priorityStats = <TaskPriority, int>{};
    for (var task in tasks) {
      priorityStats[task.priority] = (priorityStats[task.priority] ?? 0) + 1;
    }

    return StatisticsData(
      completedTasks: completedTasks,
      pendingTasks: pendingTasks,
      totalTasks: tasks.length,
      completionRate: completionRate,
      categoryStats: categoryStats,
      priorityStats: priorityStats,
    );
  }

  // Get top category
  static TaskCategory? getTopCategory(List<Task> tasks) {
    if (tasks.isEmpty) return null;

    final categoryStats = <TaskCategory, int>{};
    for (var task in tasks) {
      categoryStats[task.category] = (categoryStats[task.category] ?? 0) + 1;
    }

    return categoryStats.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }

  // Get top priority
  static TaskPriority? getTopPriority(List<Task> tasks) {
    if (tasks.isEmpty) return null;

    final priorityStats = <TaskPriority, int>{};
    for (var task in tasks) {
      priorityStats[task.priority] = (priorityStats[task.priority] ?? 0) + 1;
    }

    return priorityStats.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }

  // Get overdue tasks count
  static int getOverdueCount(List<Task> tasks) {
    final now = DateTime.now();
    return tasks.where((t) => !t.isCompleted && t.dueDate.isBefore(now)).length;
  }

  // Get tasks due today count
  static int getDueTodayCount(List<Task> tasks) {
    final now = DateTime.now();
    return tasks.where((t) {
      return !t.isCompleted &&
          t.dueDate.year == now.year &&
          t.dueDate.month == now.month &&
          t.dueDate.day == now.day;
    }).length;
  }
}
