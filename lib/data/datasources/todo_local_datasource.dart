import 'package:flutter_application_1/models/todo_model.dart';

class TodoLocalDatasource {
  final List<Todo> _localTodos = [
    Todo(id: '1', title: 'Learn Flutter'),
    Todo(id: '2', title: 'Build Todo App'),
  ];

  Future<List<Todo>> getTodos() async {
    await Future.delayed(Duration(seconds: 1));
    return _localTodos;
  }

  Future<void> addTodo(Todo todo) async {
    _localTodos.add(todo);
  }
}
