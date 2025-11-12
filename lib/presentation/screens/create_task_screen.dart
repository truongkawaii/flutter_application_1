import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../bloc/task_cubit.dart';
import '../../models/task_model.dart';
import '../widgets/create_task/create_task_app_bar.dart';
import '../widgets/create_task/create_task_form.dart';
import '../../utils/create_task_controller.dart';

class CreateTaskScreen extends StatefulWidget {
  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  late final CreateTaskController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CreateTaskController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CreateTaskAppBar(),
      body: CreateTaskForm(
        controller: _controller,
        onSubmit: _createTask,
      ),
    );
  }

  Future<void> _createTask() async {
    if (!_controller.validate()) {
      return;
    }

    _controller.setLoading(true);

    try {
      final newTask = Task(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _controller.titleController.text.trim(),
        description: _controller.descriptionController.text.trim(),
        category: _controller.selectedCategory,
        priority: _controller.selectedPriority,
        dueDate: _controller.selectedDate,
        imageUrl: _controller.imageUrl,
      );

      await context.read<TaskCubit>().addTask(newTask);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 12),
                Text('Task created successfully!'),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.error, color: Colors.white),
                SizedBox(width: 12),
                Expanded(child: Text('Failed to create task: $e')),
              ],
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        _controller.setLoading(false);
      }
    }
  }
}
