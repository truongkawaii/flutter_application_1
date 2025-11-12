import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/task_cubit.dart';
import '../models/task_model.dart';
import '../data/datasources/task_local_datasource.dart';
import '../config/app_theme.dart';
import 'json_helper.dart';
import 'ui_helper.dart';

class ProfileActions {
  // Backup Tasks
  static Future<void> backupTasks(BuildContext context) async {
    try {
      final jsonString = await JsonHelper.exportTasks();

      if (jsonString == null || jsonString.isEmpty) {
        UiHelper.showSnackBar(context, 'No tasks to backup', Colors.orange);
        return;
      }

      await Clipboard.setData(ClipboardData(text: jsonString));
      UiHelper.showSnackBar(
        context,
        'Tasks backed up to clipboard!',
        Colors.green,
      );
    } catch (e) {
      UiHelper.showSnackBar(context, 'Backup failed: $e', Colors.red);
    }
  }

  // Restore Tasks
  static Future<void> restoreTasks(BuildContext context) async {
    final clipboardData = await Clipboard.getData('text/plain');

    if (clipboardData == null || clipboardData.text == null) {
      UiHelper.showSnackBar(
        context,
        'No backup data in clipboard',
        Colors.orange,
      );
      return;
    }

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.restore, color: AppTheme.primaryColor),
            SizedBox(width: 8),
            Text('Restore Tasks'),
          ],
        ),
        content: Text(
          'This will replace all current tasks with the backup data. Continue?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(dialogContext);

              final success = await JsonHelper.importTasks(clipboardData.text!);

              if (success && context.mounted) {
                await context.read<TaskCubit>().loadTasks(DataSource.local);
                UiHelper.showSnackBar(
                  context,
                  'Tasks restored successfully!',
                  Colors.green,
                );
              } else if (context.mounted) {
                UiHelper.showSnackBar(context, 'Invalid backup data', Colors.red);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
            ),
            child: Text('Restore'),
          ),
        ],
      ),
    );
  }

  // Reset to Defaults
  static Future<void> resetToDefaults(BuildContext context) async {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.refresh, color: Colors.orange),
            SizedBox(width: 8),
            Text('Reset to Defaults'),
          ],
        ),
        content: Text(
          'This will replace all current tasks with default sample tasks. Continue?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(dialogContext);

              try {
                final dataSource = TaskLocalDataSource();
                await dataSource.resetToDefaults();

                if (context.mounted) {
                  await context.read<TaskCubit>().loadTasks(DataSource.local);
                  UiHelper.showSnackBar(
                    context,
                    'Tasks reset to defaults!',
                    Colors.green,
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  UiHelper.showSnackBar(context, 'Reset failed: $e', Colors.red);
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
            child: Text('Reset'),
          ),
        ],
      ),
    );
  }

  // Clear All Tasks
  static Future<void> clearAllTasks(BuildContext context) async {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.warning, color: Colors.red),
            SizedBox(width: 8),
            Text('Clear All Tasks'),
          ],
        ),
        content: Text(
          'This will permanently delete ALL tasks. This action cannot be undone!',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(dialogContext);

              try {
                final dataSource = TaskLocalDataSource();
                await dataSource.clearAllTasks();

                if (context.mounted) {
                  await context.read<TaskCubit>().loadTasks(DataSource.local);
                  UiHelper.showSnackBar(
                    context,
                    'All tasks cleared!',
                    Colors.green,
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  UiHelper.showSnackBar(context, 'Clear failed: $e', Colors.red);
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: Text('Clear All'),
          ),
        ],
      ),
    );
  }

  // Show Coming Soon Dialog
  static void showComingSoon(BuildContext context, String feature) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.info_outline, color: AppTheme.primaryColor),
            SizedBox(width: 8),
            Text('Coming Soon'),
          ],
        ),
        content: Text('$feature feature will be available in the next update!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  // Show About Dialog
  static void showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.task_alt, color: AppTheme.primaryColor, size: 28),
            SizedBox(width: 8),
            Text('Task Manager'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Version: 1.0.0'),
            SizedBox(height: 8),
            Text('A beautiful task management app built with Flutter.'),
            SizedBox(height: 16),
            Text('Features:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('• Task management with categories'),
            Text('• Priority levels'),
            Text('• Statistics and insights'),
            Text('• Local and remote data sources'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  // Show Logout Dialog
  static void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.logout, color: Colors.red),
            SizedBox(width: 8),
            Text('Logout'),
          ],
        ),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              UiHelper.showSnackBar(
                context,
                'Logged out successfully',
                Colors.green,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }
}
