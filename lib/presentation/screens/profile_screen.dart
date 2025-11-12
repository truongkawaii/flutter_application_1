import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/user_model.dart';
import '../../bloc/task_cubit.dart';
import '../../bloc/task_state.dart';
import '../widgets/profile/profile_header.dart';
import '../widgets/profile/profile_settings_section.dart';
import '../widgets/profile/profile_logout_button.dart';
import '../widgets/profile/profile_app_bar.dart';

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
      appBar: ProfileAppBar(),
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
                // Profile Header with stats
                ProfileHeader(
                  user: user,
                  totalTasks: totalTasks,
                  completedTasks: completedTasks,
                  pendingTasks: totalTasks - completedTasks,
                ),

                SizedBox(height: 24),

                // Settings Sections
                ProfileSettingsSection(),

                SizedBox(height: 24),

                // Logout Button
                ProfileLogoutButton(),

                SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    );
  }
}
