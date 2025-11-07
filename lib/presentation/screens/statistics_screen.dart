import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/task_cubit.dart';
import '../../bloc/task_state.dart';
import '../../models/task_model.dart';
import '../../config/app_theme.dart';
import '../widgets/stat_card.dart';

class StatisticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Statistics', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            Text('Your task overview', style: TextStyle(fontSize: 14, color: AppTheme.textSecondary)),
          ],
        ),
      ),
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state is! TaskLoaded) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bar_chart_rounded, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No data available', style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 8),
                  Text('Load tasks from Home screen', style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            );
          }

          final tasks = state.tasks;
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

          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Overview Cards
                Row(
                  children: [
                    Expanded(
                      child: StatCard(
                        icon: Icons.check_circle_rounded,
                        title: 'Completed',
                        value: completedTasks.toString(),
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: StatCard(
                        icon: Icons.pending_rounded,
                        title: 'Pending',
                        value: pendingTasks.toString(),
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: StatCard(
                        icon: Icons.task_rounded,
                        title: 'Total Tasks',
                        value: tasks.length.toString(),
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: StatCard(
                        icon: Icons.trending_up_rounded,
                        title: 'Completion',
                        value: '${completionRate.toStringAsFixed(1)}%',
                        color: AppTheme.secondaryColor,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 32),

                // Completion Progress
                Text(
                  'Completion Progress',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 120,
                        width: 120,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            CircularProgressIndicator(
                              value: completionRate / 100,
                              strokeWidth: 12,
                              backgroundColor: Colors.grey.shade200,
                              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
                            ),
                            Center(
                              child: Text(
                                '${completionRate.toStringAsFixed(0)}%',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        '$completedTasks of ${tasks.length} tasks completed',
                        style: TextStyle(color: AppTheme.textSecondary),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 32),

                // Category Breakdown
                Text(
                  'Tasks by Category',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                ...categoryStats.entries.map((entry) {
                  final percentage = (entry.value / tasks.length * 100).toStringAsFixed(1);
                  return Container(
                    margin: EdgeInsets.only(bottom: 12),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppTheme.categoryColors[entry.key]!.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            _getCategoryIcon(entry.key),
                            color: AppTheme.categoryColors[entry.key],
                            size: 20,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                entry.key.name.toUpperCase(),
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 4),
                              LinearProgressIndicator(
                                value: entry.value / tasks.length,
                                backgroundColor: Colors.grey.shade200,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppTheme.categoryColors[entry.key]!,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              entry.value.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '$percentage%',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),

                SizedBox(height: 32),

                // Priority Breakdown
                Text(
                  'Tasks by Priority',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Row(
                  children: priorityStats.entries.map((entry) {
                    return Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: 8),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: AppTheme.priorityColors[entry.key]!.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  entry.value.toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.priorityColors[entry.key],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              entry.key.name.toUpperCase(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  IconData _getCategoryIcon(TaskCategory category) {
    switch (category) {
      case TaskCategory.work:
        return Icons.work_rounded;
      case TaskCategory.personal:
        return Icons.person_rounded;
      case TaskCategory.shopping:
        return Icons.shopping_cart_rounded;
      case TaskCategory.health:
        return Icons.favorite_rounded;
      case TaskCategory.other:
        return Icons.more_horiz_rounded;
    }
  }
}
