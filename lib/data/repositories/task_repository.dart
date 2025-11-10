import 'package:flutter_application_1/models/task_model.dart';

import '../datasources/task_datasource.dart';
import '../datasources/task_local_datasource.dart';
import '../datasources/task_remote_datasource.dart';

class TaskRepository {
  final TaskDataSource _localDataSource;
  final TaskDataSource _remoteDataSource;

  TaskRepository({
    TaskDataSource? localDataSource,
    TaskDataSource? remoteDataSource,
  })  : _localDataSource = localDataSource ?? TaskLocalDataSource(),
        _remoteDataSource = remoteDataSource ?? TaskRemoteDataSource();

  // Factory constructor để dễ sử dụng
  factory TaskRepository.create() {
    return TaskRepository(
      localDataSource: TaskLocalDataSource(),
      remoteDataSource: TaskRemoteDataSource(),
    );
  }

  Future<List<Task>> getTasks(DataSource source) async {
    switch (source) {
      case DataSource.local:
        return await _localDataSource.getTasks();
      case DataSource.remote:
        return await _remoteDataSource.getTasks();
    }
  }

  Future<Task> getTaskById(String id, DataSource source) async {
    switch (source) {
      case DataSource.local:
        return await _localDataSource.getTaskById(id);
      case DataSource.remote:
        return await _remoteDataSource.getTaskById(id);
    }
  }

  Future<void> addTask(Task task, DataSource source) async {
    switch (source) {
      case DataSource.local:
        await _localDataSource.addTask(task);
        break;
      case DataSource.remote:
        await _remoteDataSource.addTask(task);
        break;
    }
  }

  Future<void> updateTask(Task task, DataSource source) async {
    switch (source) {
      case DataSource.local:
        await _localDataSource.updateTask(task);
        break;
      case DataSource.remote:
        await _remoteDataSource.updateTask(task);
        break;
    }
  }

  Future<void> deleteTask(String id, DataSource source) async {
    switch (source) {
      case DataSource.local:
        await _localDataSource.deleteTask(id);
        break;
      case DataSource.remote:
        await _remoteDataSource.deleteTask(id);
        break;
    }
  }
}
