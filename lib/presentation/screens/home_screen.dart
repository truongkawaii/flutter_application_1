import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../bloc/task_cubit.dart';
import '../../bloc/task_state.dart';
import '../../models/task_model.dart';
import '../../config/app_theme.dart';
import '../../config/app_routes.dart';
import '../widgets/task_card.dart';
import '../widgets/category_filter.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TaskCategory? _selectedCategory;

  @override
  void initState() {
    super.initState();
    context.read<TaskCubit>().loadTasks(DataSource.local);
  }

  // Filter tasks based on selected category
  List<Task> _getFilteredTasks(List<Task> allTasks) {
    if (_selectedCategory == null) {
      return allTasks;
    }
    return allTasks.where((task) => task.category == _selectedCategory).toList();
  }

  void _onCategoryChanged(TaskCategory? category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tasks',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Text(
              'Manage your daily tasks',
              style: TextStyle(fontSize: 14, color: AppTheme.textSecondary),
            ),
          ],
        ),
        actions: [
          PopupMenuButton<DataSource>(
            icon: Icon(Icons.cloud_download_rounded),
            onSelected: (source) {
              context.read<TaskCubit>().loadTasks(source);
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: DataSource.local,
                child: Row(
                  children: [
                    Icon(Icons.storage, size: 20),
                    SizedBox(width: 8),
                    Text('Load Local'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: DataSource.remote,
                child: Row(
                  children: [
                    Icon(Icons.cloud, size: 20),
                    SizedBox(width: 8),
                    Text('Load Remote'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is TaskError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red),
                  SizedBox(height: 16),
                  Text('Error: ${state.message}'),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<TaskCubit>().loadTasks(DataSource.local);
                    },
                    child: Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is TaskLoaded) {
            final allTasks = state.tasks;
            final filteredTasks = _getFilteredTasks(allTasks);

            return Column(
              children: [
                // Category Filter Component
                CategoryFilter(
                  selectedCategory: _selectedCategory,
                  onCategoryChanged: _onCategoryChanged,
                ),

                // Data Source Indicator
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      Icon(
                        state.source == DataSource.local
                            ? Icons.storage
                            : Icons.cloud,
                        size: 16,
                        color: AppTheme.textSecondary,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Source: ${state.source.name.toUpperCase()}',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text(
                        '${filteredTasks.length} of ${allTasks.length} tasks',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

                // Task List
                Expanded(
                  child: _buildTaskList(filteredTasks),
                ),
              ],
            );
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.inbox_rounded, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'Start by loading tasks',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    context.read<TaskCubit>().loadTasks(DataSource.local);
                  },
                  icon: Icon(Icons.storage),
                  label: Text('Load Local Tasks'),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push(AppRoutes.createTask);
        },
        icon: Icon(Icons.add),
        label: Text('New Task'),
        backgroundColor: AppTheme.primaryColor,
      ),
    );
  }

  Widget _buildTaskList(List<Task> tasks) {
    if (tasks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_rounded, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              _selectedCategory == null
                  ? 'No tasks found'
                  : 'No ${_selectedCategory!.name} tasks',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            if (_selectedCategory != null) ...[
              SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectedCategory = null;
                  });
                },
                child: Text('Clear filter'),
              ),
            ],
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return TaskCard(
          task: task,
          onTap: () {
            context.push(AppRoutes.taskDetailRoute(task.id));
          },
          onToggle: () {
            context.read<TaskCubit>().toggleTask(task.id);
          },
        );
      },
    );
  }
}
