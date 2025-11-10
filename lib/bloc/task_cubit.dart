import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repositories/task_repository.dart';
import '../models/task_model.dart';
import 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskRepository _repository;
  DataSource _currentSource = DataSource.local; // Track current data source

  TaskCubit(this._repository) : super(TaskInitial());

  // Getter để lấy current source
  DataSource get currentSource => _currentSource;

  /// Load tasks từ local hoặc remote
  Future<void> loadTasks(DataSource source) async {
    emit(TaskLoading());
    try {
      _currentSource = source; // Update current source
      final tasks = await _repository.getTasks(source);
      emit(TaskLoaded(tasks, source));
    } catch (e) {
      emit(TaskError('Failed to load tasks: ${e.toString()}'));
    }
  }

  /// Toggle complete status của task
  void toggleTask(String id) {
    if (state is TaskLoaded) {
      final currentState = state as TaskLoaded;
      final updatedTasks = currentState.tasks.map((task) {
        if (task.id == id) {
          return task.copyWith(isCompleted: !task.isCompleted);
        }
        return task;
      }).toList();
      
      // Update repository (async operation không block UI)
      _repository.updateTask(
        updatedTasks.firstWhere((t) => t.id == id),
        _currentSource,
      );
      
      emit(TaskLoaded(updatedTasks, currentState.source));
    }
  }

  /// Add new task
  Future<void> addTask(Task task) async {
    if (state is TaskLoaded) {
      final currentState = state as TaskLoaded;
      
      try {
        await _repository.addTask(task, _currentSource);
        final updatedTasks = [...currentState.tasks, task];
        emit(TaskLoaded(updatedTasks, currentState.source));
      } catch (e) {
        emit(TaskError('Failed to add task: ${e.toString()}'));
        // Restore previous state
        emit(currentState);
      }
    } else {
      emit(TaskError('Cannot add task: No tasks loaded'));
    }
  }

  /// Update existing task
  Future<void> updateTask(Task task) async {
    if (state is TaskLoaded) {
      final currentState = state as TaskLoaded;
      
      try {
        await _repository.updateTask(task, _currentSource);
        final updatedTasks = currentState.tasks.map((t) {
          return t.id == task.id ? task : t;
        }).toList();
        emit(TaskLoaded(updatedTasks, currentState.source));
      } catch (e) {
        emit(TaskError('Failed to update task: ${e.toString()}'));
        // Restore previous state
        emit(currentState);
      }
    } else {
      emit(TaskError('Cannot update task: No tasks loaded'));
    }
  }

  /// Delete task
  Future<void> deleteTask(String id) async {
    if (state is TaskLoaded) {
      final currentState = state as TaskLoaded;
      
      try {
        await _repository.deleteTask(id, _currentSource);
        final updatedTasks = currentState.tasks.where((t) => t.id != id).toList();
        emit(TaskLoaded(updatedTasks, currentState.source));
      } catch (e) {
        emit(TaskError('Failed to delete task: ${e.toString()}'));
        // Restore previous state
        emit(currentState);
      }
    } else {
      emit(TaskError('Cannot delete task: No tasks loaded'));
    }
  }

  /// Get task by ID
  Task? getTaskById(String id) {
    if (state is TaskLoaded) {
      final currentState = state as TaskLoaded;
      try {
        return currentState.tasks.firstWhere((t) => t.id == id);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Reload current tasks
  Future<void> refresh() async {
    if (state is TaskLoaded) {
      final currentState = state as TaskLoaded;
      await loadTasks(currentState.source);
    }
  }

  /// Get statistics
  Map<String, dynamic> getStatistics() {
    if (state is TaskLoaded) {
      final currentState = state as TaskLoaded;
      final tasks = currentState.tasks;
      
      final completed = tasks.where((t) => t.isCompleted).length;
      final pending = tasks.length - completed;
      final completionRate = tasks.isEmpty ? 0.0 : (completed / tasks.length * 100);
      
      // Category breakdown
      final categoryStats = <TaskCategory, int>{};
      for (var task in tasks) {
        categoryStats[task.category] = (categoryStats[task.category] ?? 0) + 1;
      }
      
      // Priority breakdown
      final priorityStats = <TaskPriority, int>{};
      for (var task in tasks) {
        priorityStats[task.priority] = (priorityStats[task.priority] ?? 0) + 1;
      }
      
      return {
        'total': tasks.length,
        'completed': completed,
        'pending': pending,
        'completionRate': completionRate,
        'categoryStats': categoryStats,
        'priorityStats': priorityStats,
      };
    }
    
    return {
      'total': 0,
      'completed': 0,
      'pending': 0,
      'completionRate': 0.0,
      'categoryStats': <TaskCategory, int>{},
      'priorityStats': <TaskPriority, int>{},
    };
  }

  /// Filter tasks by category
  List<Task> filterByCategory(TaskCategory? category) {
    if (state is TaskLoaded) {
      final currentState = state as TaskLoaded;
      if (category == null) {
        return currentState.tasks;
      }
      return currentState.tasks.where((t) => t.category == category).toList();
    }
    return [];
  }

  /// Filter tasks by priority
  List<Task> filterByPriority(TaskPriority priority) {
    if (state is TaskLoaded) {
      final currentState = state as TaskLoaded;
      return currentState.tasks.where((t) => t.priority == priority).toList();
    }
    return [];
  }

  /// Filter completed tasks
  List<Task> getCompletedTasks() {
    if (state is TaskLoaded) {
      final currentState = state as TaskLoaded;
      return currentState.tasks.where((t) => t.isCompleted).toList();
    }
    return [];
  }

  /// Filter pending tasks
  List<Task> getPendingTasks() {
    if (state is TaskLoaded) {
      final currentState = state as TaskLoaded;
      return currentState.tasks.where((t) => !t.isCompleted).toList();
    }
    return [];
  }

  /// Get overdue tasks
  List<Task> getOverdueTasks() {
    if (state is TaskLoaded) {
      final currentState = state as TaskLoaded;
      final now = DateTime.now();
      return currentState.tasks.where((t) {
        return !t.isCompleted && t.dueDate.isBefore(now);
      }).toList();
    }
    return [];
  }

  /// Get tasks due today
  List<Task> getTasksDueToday() {
    if (state is TaskLoaded) {
      final currentState = state as TaskLoaded;
      final now = DateTime.now();
      return currentState.tasks.where((t) {
        return !t.isCompleted &&
            t.dueDate.year == now.year &&
            t.dueDate.month == now.month &&
            t.dueDate.day == now.day;
      }).toList();
    }
    return [];
  }

  /// Switch data source
  Future<void> switchDataSource(DataSource newSource) async {
    if (_currentSource != newSource) {
      await loadTasks(newSource);
    }
  }
}
