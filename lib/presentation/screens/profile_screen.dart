import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/user_model.dart';
import '../../config/app_theme.dart';
import '../../bloc/task_cubit.dart';
import '../../bloc/task_state.dart';

class ProfileScreen extends StatelessWidget {
  final User user = User(
    name: 'John Doe',
    email: 'john.doe@example.com',
    avatarUrl: 'https://i.pravatar.cc/300',
    completedTasks: 0,
    totalTasks: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Profile', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            Text('Your account information', style: TextStyle(fontSize: 14, color: AppTheme.textSecondary)),
          ],
        ),
      ),
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          int completedTasks = 0;
          int totalTasks = 0;

          if (state is TaskLoaded) {
            totalTasks = state.tasks.length;
            completedTasks = state.tasks.where((t) => t.isCompleted).length;
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                // Profile Header
                Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 47,
                          backgroundImage: NetworkImage(user.avatarUrl),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        user.name,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        user.email,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatItem('Total Tasks', totalTasks.toString()),
                          Container(width: 1, height: 40, color: Colors.white.withOpacity(0.3)),
                          _buildStatItem('Completed', completedTasks.toString()),
                          Container(width: 1, height: 40, color: Colors.white.withOpacity(0.3)),
                          _buildStatItem('Pending', (totalTasks - completedTasks).toString()),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24),

                // Account Section
                _buildSectionTitle('Account'),
                SizedBox(height: 12),
                _buildSettingItem(
                  icon: Icons.person_rounded,
                  title: 'Edit Profile',
                  subtitle: 'Update your information',
                  onTap: () {
                    _showComingSoonDialog(context, 'Edit Profile');
                  },
                ),
                _buildSettingItem(
                  icon: Icons.lock_rounded,
                  title: 'Change Password',
                  subtitle: 'Update your password',
                  onTap: () {
                    _showComingSoonDialog(context, 'Change Password');
                  },
                ),

                SizedBox(height: 24),

                // Preferences Section
                _buildSectionTitle('Preferences'),
                SizedBox(height: 12),
                _buildSettingItem(
                  icon: Icons.language_rounded,
                  title: 'Language',
                  subtitle: 'English (US)',
                  onTap: () {
                    _showComingSoonDialog(context, 'Language Settings');
                  },
                ),
                _buildSettingItem(
                  icon: Icons.palette_rounded,
                  title: 'App Theme',
                  subtitle: 'Customize appearance',
                  onTap: () {
                    _showComingSoonDialog(context, 'Theme Settings');
                  },
                ),

                SizedBox(height: 24),

                // Support Section
                _buildSectionTitle('Support'),
                SizedBox(height: 12),
                _buildSettingItem(
                  icon: Icons.privacy_tip_rounded,
                  title: 'Privacy Policy',
                  subtitle: 'Read our privacy policy',
                  onTap: () {
                    _showComingSoonDialog(context, 'Privacy Policy');
                  },
                ),
                _buildSettingItem(
                  icon: Icons.description_rounded,
                  title: 'Terms of Service',
                  subtitle: 'Read our terms',
                  onTap: () {
                    _showComingSoonDialog(context, 'Terms of Service');
                  },
                ),
                _buildSettingItem(
                  icon: Icons.info_rounded,
                  title: 'About App',
                  subtitle: 'Version 1.0.0',
                  onTap: () {
                    _showAboutDialog(context);
                  },
                ),
                _buildSettingItem(
                  icon: Icons.help_rounded,
                  title: 'Help & Support',
                  subtitle: 'Get help with the app',
                  onTap: () {
                    _showComingSoonDialog(context, 'Help & Support');
                  },
                ),

                SizedBox(height: 24),

                // Logout Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _showLogoutDialog(context);
                    },
                    icon: Icon(Icons.logout_rounded),
                    label: Text('Logout'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppTheme.textPrimary,
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppTheme.primaryColor),
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(fontSize: 12, color: AppTheme.textSecondary),
        ),
        trailing: Icon(Icons.chevron_right_rounded, color: AppTheme.textSecondary),
        onTap: onTap,
      ),
    );
  }

  void _showComingSoonDialog(BuildContext context, String feature) {
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

  void _showAboutDialog(BuildContext context) {
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
            Text(
              'Features:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
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

  void _showLogoutDialog(BuildContext context) {
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
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Logged out successfully'),
                  backgroundColor: Colors.green,
                ),
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
