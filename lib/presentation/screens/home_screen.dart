import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../bloc/task_cubit.dart';
import '../../bloc/task_state.dart';
import '../../models/task_model.dart';
import '../../config/app_theme.dart';
import '../widgets/task_card.dart';
import '../widgets/category_chip.dart';

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
                ],
              ),
            );
          }

          if (state is TaskLoaded) {
            final filteredTasks = _selectedCategory == null
                ? state.tasks
                : state.tasks
                      .where((t) => t.category == _selectedCategory)
                      .toList();

            return Column(
              children: [
                // Category Filter
                Container(
                  height: 60,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      CategoryChip(
                        label: 'All',
                        isSelected: _selectedCategory == null,
                        onTap: () => setState(() => _selectedCategory = null),
                      ),
                      ...TaskCategory.values.map(
                        (category) => CategoryChip(
                          label: category.name.toUpperCase(),
                          color: AppTheme.categoryColors[category]!,
                          isSelected: _selectedCategory == category,
                          onTap: () =>
                              setState(() => _selectedCategory = category),
                        ),
                      ),
                    ],
                  ),
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
                        '${filteredTasks.length} tasks',
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
                  child: filteredTasks.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.inbox_rounded,
                                size: 64,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 16),
                              Text(
                                'No tasks found',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.all(16),
                          itemCount: filteredTasks.length,
                          itemBuilder: (context, index) {
                            return TaskCard(
                              task: filteredTasks[index],
                              onTap: () {
                                context.push(
                                  '/task/${filteredTasks[index].id}',
                                );
                              },
                              onToggle: () {
                                context.read<TaskCubit>().toggleTask(
                                  filteredTasks[index].id,
                                );
                              },
                            );
                          },
                        ),
                ),
              ],
            );
          }

          return Center(child: Text('Start by loading tasks'));
        },
      ),
    );
  }
}
