import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/task_cubit.dart';
import '../models/task_model.dart';
import '../config/app_theme.dart';
import 'ui_helper.dart';

class TaskDetailActions {
  // Edit Task
  static void editTask(BuildContext context, Task task) {
    UiHelper.showSnackBar(
      context,
      'Edit task feature coming soon!',
      AppTheme.primaryColor,
    );
  }

  // Delete Task
  static Future<void> deleteTask(BuildContext context, String taskId) async {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.warning, color: Colors.red),
            SizedBox(width: 8),
            Text('Delete Task'),
          ],
        ),
        content: Text(
          'Are you sure you want to delete this task? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(dialogContext);

              // Delete task
              await context.read<TaskCubit>().deleteTask(taskId);

              // Navigate back
              if (context.mounted) {
                context.pop();
                UiHelper.showSnackBar(
                  context,
                  'Task deleted successfully',
                  Colors.green,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

  // Share Task
  static void shareTask(BuildContext context, Task task) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.share, color: AppTheme.primaryColor),
            SizedBox(width: 8),
            Text('Share Task'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Share "${task.title}" with:'),
            SizedBox(height: 16),
            _ShareOption(
              icon: Icons.message,
              label: 'Message',
              onTap: () {
                Navigator.pop(dialogContext);
                UiHelper.showSnackBar(
                  context,
                  'Message sharing coming soon!',
                  AppTheme.primaryColor,
                );
              },
            ),
            _ShareOption(
              icon: Icons.email,
              label: 'Email',
              onTap: () {
                Navigator.pop(dialogContext);
                UiHelper.showSnackBar(
                  context,
                  'Email sharing coming soon!',
                  AppTheme.primaryColor,
                );
              },
            ),
            _ShareOption(
              icon: Icons.link,
              label: 'Copy Link',
              onTap: () {
                Navigator.pop(dialogContext);
                UiHelper.showSnackBar(
                  context,
                  'Link copied to clipboard!',
                  Colors.green,
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  // Remind Me
  static void remindMe(BuildContext context, Task task) {
    UiHelper.showSnackBar(
      context,
      'Reminder feature coming soon!',
      AppTheme.primaryColor,
    );
    // TODO: Implement reminder functionality
  }
}

// Private widget for share options
class _ShareOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ShareOption({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey.shade700),
            SizedBox(width: 16),
            Text(label, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
