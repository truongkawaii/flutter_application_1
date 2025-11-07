import '../../models/task_model.dart';

class TaskRemoteDataSource {
  Future<List<Task>> getTasks() async {
    await Future.delayed(Duration(seconds: 2));
    return [
      Task(
        id: '10',
        title: 'Client Presentation',
        description: 'Present Q4 results to stakeholders and discuss future roadmap',
        category: TaskCategory.work,
        priority: TaskPriority.high,
        dueDate: DateTime.now().add(Duration(days: 1)),
        imageUrl: 'https://picsum.photos/seed/presentation/400/200',
      ),
      Task(
        id: '11',
        title: 'Yoga Session',
        description: 'Evening yoga class for relaxation and flexibility',
        category: TaskCategory.health,
        priority: TaskPriority.medium,
        dueDate: DateTime.now().add(Duration(hours: 8)),
        imageUrl: 'https://picsum.photos/seed/yoga/400/200',
      ),
      Task(
        id: '12',
        title: 'Birthday Gift Shopping',
        description: 'Find a perfect gift for mom\'s birthday next week',
        category: TaskCategory.shopping,
        priority: TaskPriority.medium,
        dueDate: DateTime.now().add(Duration(days: 5)),
        imageUrl: 'https://picsum.photos/seed/gift/400/200',
      ),
      Task(
        id: '13',
        title: 'Learn Dart Async',
        description: 'Deep dive into Futures, Streams, and async/await patterns',
        category: TaskCategory.personal,
        priority: TaskPriority.low,
        dueDate: DateTime.now().add(Duration(days: 7)),
        imageUrl: 'https://picsum.photos/seed/dart/400/200',
      ),
    ];
  }
}
