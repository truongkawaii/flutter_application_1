import 'package:flutter/material.dart';
import '../../../models/task_model.dart';
import '../../../config/app_theme.dart';
import '../../../utils/task_detail_actions.dart';

class TaskActionButtons extends StatelessWidget {
  final Task task;

  const TaskActionButtons({required this.task});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => TaskDetailActions.shareTask(context, task),
            icon: Icon(Icons.share_rounded),
            label: Text('Share'),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16),
              side: BorderSide(color: AppTheme.primaryColor),
              foregroundColor: AppTheme.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => TaskDetailActions.remindMe(context, task),
            icon: Icon(Icons.notifications_active_rounded),
            label: Text('Remind Me'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16),
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
