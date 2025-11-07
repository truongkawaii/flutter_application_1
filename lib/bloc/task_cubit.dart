import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repositories/task_repository.dart';
import '../models/task_model.dart';
import 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskRepository repository;

  TaskCubit(this.repository) : super(TaskInitial());

  Future<void> loadTasks(DataSource source) async {
    emit(TaskLoading());
    try {
      final tasks = await repository.getTasks(source);
      emit(TaskLoaded(tasks, source));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  void toggleTask(String id) {
    if (state is TaskLoaded) {
      final currentState = state as TaskLoaded;
      final updatedTasks = currentState.tasks.map((task) {
        if (task.id == id) {
          return task.copyWith(isCompleted: !task.isCompleted);
        }
        return task;
      }).toList();
      emit(TaskLoaded(updatedTasks, currentState.source));
    }
  }

  Future<void> addTask(Task task) async {
    if (state is TaskLoaded) {
      final currentState = state as TaskLoaded;
      await repository.addTask(task);
      final updatedTasks = [...currentState.tasks, task];
      emit(TaskLoaded(updatedTasks, currentState.source));
    }
  }

  Future<void> updateTask(Task task) async {
    if (state is TaskLoaded) {
      final currentState = state as TaskLoaded;
      await repository.updateTask(task);
      final updatedTasks = currentState.tasks.map((t) {
        return t.id == task.id ? task : t;
      }).toList();
      emit(TaskLoaded(updatedTasks, currentState.source));
    }
  }

  void filterByCategory(TaskCategory? category) {
    if (state is TaskLoaded) {
      final currentState = state as TaskLoaded;
      // You can implement filtering logic here or in UI
      emit(TaskLoaded(currentState.tasks, currentState.source));
    }
  }
}
