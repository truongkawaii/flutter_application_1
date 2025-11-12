import 'package:flutter/material.dart';
import '../../../models/task_model.dart';
import 'statistics_section_title.dart';
import 'statistics_category_item.dart';

class StatisticsCategorySection extends StatelessWidget {
  final Map<TaskCategory, int> categoryStats;
  final int totalTasks;

  const StatisticsCategorySection({
    required this.categoryStats,
    required this.totalTasks,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StatisticsSectionTitle(title: 'Tasks by Category'),
        SizedBox(height: 16),
        ...categoryStats.entries.map((entry) {
          return StatisticsCategoryItem(
            category: entry.key,
            count: entry.value,
            totalTasks: totalTasks,
          );
        }).toList(),
      ],
    );
  }
}
