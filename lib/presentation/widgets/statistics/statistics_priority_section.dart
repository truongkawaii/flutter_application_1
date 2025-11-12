import 'package:flutter/material.dart';
import '../../../models/task_model.dart';
import 'statistics_section_title.dart';
import 'statistics_priority_item.dart';

class StatisticsPrioritySection extends StatelessWidget {
  final Map<TaskPriority, int> priorityStats;

  const StatisticsPrioritySection({required this.priorityStats});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StatisticsSectionTitle(title: 'Tasks by Priority'),
        SizedBox(height: 16),
        Row(
          children: priorityStats.entries.map((entry) {
            return Expanded(
              child: StatisticsPriorityItem(
                priority: entry.key,
                count: entry.value,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
