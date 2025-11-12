import '../../models/task_model.dart';
import '../../utils/json_helper.dart';
import 'task_datasource.dart';

class TaskLocalDataSource implements TaskDataSource {
  List<Task> _localTasks = [];
  bool _isInitialized = false;

  /// Initialize and load tasks from SharedPreferences
  Future<void> _initialize() async {
    if (!_isInitialized) {
      _localTasks = await JsonHelper.loadTasks();
      
      // If no tasks in storage, load default tasks
      if (_localTasks.isEmpty) {
        _localTasks = _getDefaultTasks();
        await JsonHelper.saveTasks(_localTasks);
      }
      
      _isInitialized = true;
    }
  }

  /// Get default tasks (initial data)
  List<Task> _getDefaultTasks() {
    return [
      Task(
        id: '1',
        title: 'Complete Flutter Project',
        description: 'Finish the task manager app with beautiful UI and smooth animations',
        category: TaskCategory.work,
        priority: TaskPriority.high,
        dueDate: DateTime.now().add(Duration(days: 2)),
        imageUrl: 'https://picsum.photos/seed/flutter/400/200',
      ),
      Task(
        id: '2',
        title: 'Morning Workout',
        description: '30 minutes cardio and strength training at the gym',
        category: TaskCategory.health,
        priority: TaskPriority.medium,
        dueDate: DateTime.now().add(Duration(days: 1)),
        isCompleted: true,
        imageUrl: 'https://picsum.photos/seed/workout/400/200',
      ),
      Task(
        id: '3',
        title: 'Buy Groceries',
        description: 'Milk, eggs, bread, fruits, and vegetables for the week',
        category: TaskCategory.shopping,
        priority: TaskPriority.low,
        dueDate: DateTime.now(),
        imageUrl: 'https://picsum.photos/seed/groceries/400/200',
      ),
      Task(
        id: '4',
        title: 'Team Meeting',
        description: 'Quarterly review meeting with the development team',
        category: TaskCategory.work,
        priority: TaskPriority.high,
        dueDate: DateTime.now().add(Duration(hours: 5)),
        imageUrl: 'https://picsum.photos/seed/meeting/400/200',
      ),
      Task(
        id: '5',
        title: 'Read Book',
        description: 'Continue reading "Clean Code" - Chapter 5',
        category: TaskCategory.personal,
        priority: TaskPriority.low,
        dueDate: DateTime.now().add(Duration(days: 3)),
        imageUrl: 'https://picsum.photos/seed/book/400/200',
      ),
    ];
  }

  @override
  Future<List<Task>> getTasks() async {
    await _initialize();
    await Future.delayed(Duration(milliseconds: 500));
    return _localTasks;
  }

  @override
  Future<Task> getTaskById(String id) async {
    await _initialize();
    await Future.delayed(Duration(milliseconds: 300));
    return _localTasks.firstWhere((task) => task.id == id);
  }

  @override
  Future<void> addTask(Task task) async {
    await _initialize();
    _localTasks.add(task);
    await JsonHelper.saveTasks(_localTasks);
    await Future.delayed(Duration(milliseconds: 500));
  }

  @override
  Future<void> updateTask(Task task) async {
    await _initialize();
    final index = _localTasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _localTasks[index] = task;
      await JsonHelper.saveTasks(_localTasks);
    }
    await Future.delayed(Duration(milliseconds: 500));
  }

  @override
  Future<void> deleteTask(String id) async {
    await _initialize();
    _localTasks.removeWhere((task) => task.id == id);
    await JsonHelper.saveTasks(_localTasks);
    await Future.delayed(Duration(milliseconds: 500));
  }

  /// Clear all tasks
  Future<void> clearAllTasks() async {
    _localTasks.clear();
    await JsonHelper.clearTasks();
    _isInitialized = false;
  }

  /// Reset to default tasks
  Future<void> resetToDefaults() async {
    _localTasks = _getDefaultTasks();
    await JsonHelper.saveTasks(_localTasks);
  }
}
