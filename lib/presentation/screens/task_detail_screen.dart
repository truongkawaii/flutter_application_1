import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../bloc/task_cubit.dart';
import '../../bloc/task_state.dart';
import '../../models/task_model.dart';
import '../../config/app_theme.dart';

class TaskDetailScreen extends StatelessWidget {
  final String taskId;

  const TaskDetailScreen({required this.taskId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        if (state is! TaskLoaded) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final task = state.tasks.firstWhere(
          (t) => t.id == taskId,
          orElse: () => state.tasks.first,
        );

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              // App Bar with Image
              SliverAppBar(
                expandedHeight: 250,
                pinned: true,
                leading: IconButton(
                  icon: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  onPressed: () => context.pop(),
                ),
                actions: [
                  IconButton(
                    icon: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.edit, color: Colors.white),
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    onPressed: () {},
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        task.imageUrl ?? 'https://picsum.photos/seed/default/400/300',
                        fit: BoxFit.cover,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Content
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Status Badge
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: task.isCompleted ? Colors.green : Colors.orange,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  task.isCompleted ? Icons.check_circle : Icons.pending,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  task.isCompleted ? 'Completed' : 'Pending',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          // Toggle Complete Button
                          ElevatedButton.icon(
                            onPressed: () {
                              context.read<TaskCubit>().toggleTask(task.id);
                            },
                            icon: Icon(
                              task.isCompleted ? Icons.restart_alt : Icons.check,
                              size: 18,
                            ),
                            label: Text(task.isCompleted ? 'Reopen' : 'Complete'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: task.isCompleted 
                                  ? Colors.grey 
                                  : Colors.green,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 24),

                      // Title
                      Text(
                        task.title,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                      ),

                      SizedBox(height: 24),

                      // Info Cards
                      Row(
                        children: [
                          Expanded(
                            child: _buildInfoCard(
                              icon: Icons.category_rounded,
                              label: 'Category',
                              value: task.category.name.toUpperCase(),
                              color: AppTheme.categoryColors[task.category]!,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: _buildInfoCard(
                              icon: Icons.flag_rounded,
                              label: 'Priority',
                              value: task.priority.name.toUpperCase(),
                              color: AppTheme.priorityColors[task.priority]!,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 12),

                      _buildInfoCard(
                        icon: Icons.calendar_today_rounded,
                        label: 'Due Date',
                        value: DateFormat('EEEE, MMM dd, yyyy').format(task.dueDate),
                        color: AppTheme.primaryColor,
                        isFullWidth: true,
                      ),

                      SizedBox(height: 24),

                      // Description Section
                      Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          task.description,
                          style: TextStyle(
                            fontSize: 16,
                            color: AppTheme.textSecondary,
                            height: 1.6,
                          ),
                        ),
                      ),

                      SizedBox(height: 24),

                      // Time Until Due
                      _buildTimeUntilDue(task.dueDate),

                      SizedBox(height: 32),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {},
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
                              onPressed: () {},
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
                      ),

                      SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    bool isFullWidth = false,
  }) {
    return Container(
      width: isFullWidth ? double.infinity : null,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeUntilDue(DateTime dueDate) {
    final now = DateTime.now();
    final difference = dueDate.difference(now);
    
    String timeText;
    Color timeColor;
    IconData timeIcon;

    if (difference.isNegative) {
      timeText = 'Overdue by ${difference.inDays.abs()} days';
      timeColor = Colors.red;
      timeIcon = Icons.error_rounded;
    } else if (difference.inDays == 0) {
      timeText = 'Due today';
      timeColor = Colors.orange;
      timeIcon = Icons.today_rounded;
    } else if (difference.inDays == 1) {
      timeText = 'Due tomorrow';
      timeColor = Colors.orange;
      timeIcon = Icons.abc_outlined;
    } else {
      timeText = 'Due in ${difference.inDays} days';
      timeColor = Colors.green;
      timeIcon = Icons.calendar_month_rounded;
    }

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: timeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: timeColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(timeIcon, color: timeColor, size: 24),
          SizedBox(width: 12),
          Text(
            timeText,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: timeColor,
            ),
          ),
        ],
      ),
    );
  }
}

