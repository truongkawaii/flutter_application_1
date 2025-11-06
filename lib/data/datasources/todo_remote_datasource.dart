import 'package:flutter_application_1/models/todo_model.dart';

class TodoRemoteDatasource {
  Future<List<Todo>> getTodos () async {
    await Future.delayed(Duration(seconds: 1));
    return [
      Todo(id: '10', title: 'Remote Task 1'),
      Todo(id: '11', title: 'Remote Task 2'),
      Todo(id: '12', title: 'Remote Task 3')
    ];
  }
}