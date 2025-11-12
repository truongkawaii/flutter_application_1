import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/task_model.dart';
import '../../../bloc/task_cubit.dart';

class TaskStatusHeader extends StatelessWidget {
  final Task task;

  const TaskStatusHeader({required this.task});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Status Badge
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
            backgroundColor: task.isCompleted ? Colors.grey : Colors.green,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ],
    );
  }
}
