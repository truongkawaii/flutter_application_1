import 'package:flutter_application_1/data/datasources/todo_local_datasource.dart';
import 'package:flutter_application_1/data/datasources/todo_remote_datasource.dart';
import 'package:flutter_application_1/models/todo_model.dart';

class TodoRepository {
  final TodoLocalDatasource localDatasource;
  final TodoRemoteDatasource remoteDatasource;

  TodoRepository({
    required this.localDatasource,
    required this.remoteDatasource,
  });

  Future<List<Todo>> getTodos(DataSource source) async {
    switch (source) {
      case DataSource.local:
        return await localDatasource.getTodos();
      case DataSource.remote:
        return await remoteDatasource.getTodos();
    }
  }

  Future<void> addTodo(Todo todo) async {
    await localDatasource.addTodo(todo);
  }
}
