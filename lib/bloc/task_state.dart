import '../models/task_model.dart';

abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> tasks;
  final DataSource source;

  TaskLoaded(this.tasks, this.source);
}

class TaskError extends TaskState {
  final String message;

  TaskError(this.message);
}
