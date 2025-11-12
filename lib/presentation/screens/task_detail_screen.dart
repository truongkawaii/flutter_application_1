import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/task_cubit.dart';
import '../../bloc/task_state.dart';
import '../widgets/task_detail/task_detail_app_bar.dart';
import '../widgets/task_detail/task_detail_content.dart';

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
              TaskDetailAppBar(task: task),
              TaskDetailContent(task: task),
            ],
          ),
        );
      },
    );
  }
}
