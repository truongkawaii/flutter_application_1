import 'package:flutter/material.dart';
import '../../../models/task_model.dart';
import '../../../config/app_theme.dart';

class StatisticsPriorityItem extends StatelessWidget {
  final TaskPriority priority;
  final int count;

  const StatisticsPriorityItem({
    required this.priority,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
              color: AppTheme.priorityColors[priority]!.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.priorityColors[priority],
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            priority.name.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
