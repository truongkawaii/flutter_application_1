import '../../models/task_model.dart';

class TaskLocalDataSource {
  final List<Task> _localTasks = [
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

  Future<List<Task>> getTasks() async {
    await Future.delayed(Duration(milliseconds: 800));
    return _localTasks;
  }

  Future<Task> getTaskById(String id) async {
    await Future.delayed(Duration(milliseconds: 500));
    return _localTasks.firstWhere((task) => task.id == id);
  }

  Future<void> addTask(Task task) async {
    await Future.delayed(Duration(milliseconds: 500));
    _localTasks.add(task);
  }

  Future<void> updateTask(Task task) async {
    await Future.delayed(Duration(milliseconds: 500));
    final index = _localTasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _localTasks[index] = task;
    }
  }
}
