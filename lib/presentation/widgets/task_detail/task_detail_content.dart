import 'package:flutter/material.dart';
import '../../../models/task_model.dart';
import 'task_status_header.dart';
import 'task_info_section.dart';
import 'task_description_section.dart';
import 'task_due_date_indicator.dart';
import 'task_action_buttons.dart';

class TaskDetailContent extends StatelessWidget {
  final Task task;

  const TaskDetailContent({required this.task});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Badge and Toggle Button
            TaskStatusHeader(task: task),

            SizedBox(height: 24),

            // Task Title
            Text(
              task.title,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),

            SizedBox(height: 24),

            // Task Info Section (Category, Priority, Due Date)
            TaskInfoSection(task: task),

            SizedBox(height: 24),

            // Description Section
            TaskDescriptionSection(description: task.description),

            SizedBox(height: 24),

            // Time Until Due Indicator
            TaskDueDateIndicator(dueDate: task.dueDate),

            SizedBox(height: 32),

            // Action Buttons
            TaskActionButtons(task: task),

            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
