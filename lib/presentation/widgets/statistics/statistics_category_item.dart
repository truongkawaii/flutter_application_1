import 'package:flutter/material.dart';
import '../../../models/task_model.dart';
import '../../../config/app_theme.dart';
import '../../../utils/task_helpers.dart';

class StatisticsCategoryItem extends StatelessWidget {
  final TaskCategory category;
  final int count;
  final int totalTasks;

  const StatisticsCategoryItem({
    required this.category,
    required this.count,
    required this.totalTasks,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (count / totalTasks * 100).toStringAsFixed(1);

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
              color: AppTheme.categoryColors[category]!.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              TaskHelpers.getCategoryIcon(category),
              color: AppTheme.categoryColors[category],
              size: 20,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.name.toUpperCase(),
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4),
                LinearProgressIndicator(
                  value: count / totalTasks,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppTheme.categoryColors[category]!,
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
                count.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                '$percentage%',
                style: TextStyle(fontSize: 12, color: AppTheme.textSecondary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
