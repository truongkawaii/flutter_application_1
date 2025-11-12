import 'package:flutter/material.dart';
import '../../../models/task_model.dart';
import '../../../utils/statistics_calculator.dart';
import 'statistics_cards_section.dart';
import 'statistics_progress_section.dart';
import 'statistics_category_section.dart';
import 'statistics_priority_section.dart';

class StatisticsOverview extends StatelessWidget {
  final List<Task> tasks;

  const StatisticsOverview({required this.tasks});

  @override
  Widget build(BuildContext context) {
    final stats = StatisticsCalculator.calculate(tasks);

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Overview Cards
          StatisticsCardsSection(
            completedTasks: stats.completedTasks,
            pendingTasks: stats.pendingTasks,
            totalTasks: stats.totalTasks,
            completionRate: stats.completionRate,
          ),

          SizedBox(height: 32),

          // Completion Progress
          StatisticsProgressSection(
            completionRate: stats.completionRate,
            completedTasks: stats.completedTasks,
            totalTasks: stats.totalTasks,
          ),

          SizedBox(height: 32),

          // Category Breakdown
          StatisticsCategorySection(
            categoryStats: stats.categoryStats,
            totalTasks: stats.totalTasks,
          ),

          SizedBox(height: 32),

          // Priority Breakdown
          StatisticsPrioritySection(
            priorityStats: stats.priorityStats,
          ),
        ],
      ),
    );
  }
}
