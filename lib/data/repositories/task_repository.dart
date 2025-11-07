import 'package:flutter_application_1/models/task_model.dart';

import '../datasources/task_local_datasource.dart';
import '../datasources/task_remote_datasource.dart';

class TaskRepository {
  final TaskLocalDataSource localDataSource;
  final TaskRemoteDataSource remoteDataSource;

  TaskRepository({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  Future<List<Task>> getTasks(DataSource source) async {
    switch (source) {
      case DataSource.local:
        return await localDataSource.getTasks();
      case DataSource.remote:
        return await remoteDataSource.getTasks();
    }
  }

  Future<Task> getTaskById(String id) async {
    return await localDataSource.getTaskById(id);
  }

  Future<void> addTask(Task task) async {
    await localDataSource.addTask(task);
  }

  Future<void> updateTask(Task task) async {
    await localDataSource.updateTask(task);
  }
}
