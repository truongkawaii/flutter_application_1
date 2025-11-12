import 'package:flutter/material.dart';
import 'profile_setting_item.dart';
import 'profile_section_title.dart';
import '../../../utils/profile_actions.dart';

class ProfileSettingsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Account Section
        ProfileSectionTitle(title: 'Account'),
        SizedBox(height: 12),
        ProfileSettingItem(
          icon: Icons.person_rounded,
          title: 'Edit Profile',
          subtitle: 'Update your information',
          onTap: () => ProfileActions.showComingSoon(context, 'Edit Profile'),
        ),
        ProfileSettingItem(
          icon: Icons.lock_rounded,
          title: 'Change Password',
          subtitle: 'Update your password',
          onTap: () => ProfileActions.showComingSoon(context, 'Change Password'),
        ),

        SizedBox(height: 24),

        // Preferences Section
        ProfileSectionTitle(title: 'Preferences'),
        SizedBox(height: 12),
        ProfileSettingItem(
          icon: Icons.language_rounded,
          title: 'Language',
          subtitle: 'English (US)',
          onTap: () => ProfileActions.showComingSoon(context, 'Language Settings'),
        ),
        ProfileSettingItem(
          icon: Icons.palette_rounded,
          title: 'App Theme',
          subtitle: 'Customize appearance',
          onTap: () => ProfileActions.showComingSoon(context, 'Theme Settings'),
        ),

        SizedBox(height: 24),

        // Support Section
        ProfileSectionTitle(title: 'Support'),
        SizedBox(height: 12),
        ProfileSettingItem(
          icon: Icons.privacy_tip_rounded,
          title: 'Privacy Policy',
          subtitle: 'Read our privacy policy',
          onTap: () => ProfileActions.showComingSoon(context, 'Privacy Policy'),
        ),
        ProfileSettingItem(
          icon: Icons.description_rounded,
          title: 'Terms of Service',
          subtitle: 'Read our terms',
          onTap: () => ProfileActions.showComingSoon(context, 'Terms of Service'),
        ),
        ProfileSettingItem(
          icon: Icons.info_rounded,
          title: 'About App',
          subtitle: 'Version 1.0.0',
          onTap: () => ProfileActions.showAboutDialog(context),
        ),
        ProfileSettingItem(
          icon: Icons.help_rounded,
          title: 'Help & Support',
          subtitle: 'Get help with the app',
          onTap: () => ProfileActions.showComingSoon(context, 'Help & Support'),
        ),

        SizedBox(height: 24),

        // Data Management Section
        ProfileSectionTitle(title: 'Data Management'),
        SizedBox(height: 12),
        ProfileSettingItem(
          icon: Icons.backup_rounded,
          title: 'Backup Tasks',
          subtitle: 'Export tasks to clipboard',
          onTap: () => ProfileActions.backupTasks(context),
        ),
        ProfileSettingItem(
          icon: Icons.restore_rounded,
          title: 'Restore Tasks',
          subtitle: 'Import tasks from backup',
          onTap: () => ProfileActions.restoreTasks(context),
        ),
        ProfileSettingItem(
          icon: Icons.refresh_rounded,
          title: 'Reset to Defaults',
          subtitle: 'Restore default sample tasks',
          onTap: () => ProfileActions.resetToDefaults(context),
        ),
        ProfileSettingItem(
          icon: Icons.delete_sweep_rounded,
          title: 'Clear All Tasks',
          subtitle: 'Delete all tasks permanently',
          onTap: () => ProfileActions.clearAllTasks(context),
        ),
      ],
    );
  }
}
