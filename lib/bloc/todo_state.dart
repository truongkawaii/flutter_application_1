import 'package:flutter_application_1/models/todo_model.dart';

abstract class TodoState {}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<Todo> todos;
  final DataSource source;

  TodoLoaded(this.todos, this.source);
}

class TodoError extends TodoState {
  final String message;
  TodoError(this.message);
}
