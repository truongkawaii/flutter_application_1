import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/task_model.dart';
import '../../../config/app_theme.dart';
import 'task_info_card.dart';

class TaskInfoSection extends StatelessWidget {
  final Task task;

  const TaskInfoSection({required this.task});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Category and Priority Row
        Row(
          children: [
            Expanded(
              child: TaskInfoCard(
                icon: Icons.category_rounded,
                label: 'Category',
                value: task.category.name.toUpperCase(),
                color: AppTheme.categoryColors[task.category]!,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: TaskInfoCard(
                icon: Icons.flag_rounded,
                label: 'Priority',
                value: task.priority.name.toUpperCase(),
                color: AppTheme.priorityColors[task.priority]!,
              ),
            ),
          ],
        ),

        SizedBox(height: 12),

        // Due Date (Full Width)
        TaskInfoCard(
          icon: Icons.calendar_today_rounded,
          label: 'Due Date',
          value: DateFormat('EEEE, MMM dd, yyyy').format(task.dueDate),
          color: AppTheme.primaryColor,
          isFullWidth: true,
        ),
      ],
    );
  }
}
