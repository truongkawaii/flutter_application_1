import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/app_router.dart';
import 'config/app_theme.dart';
import 'data/datasources/task_local_datasource.dart';
import 'data/datasources/task_remote_datasource.dart';
import 'data/repositories/task_repository.dart';
import 'bloc/task_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskCubit(
        TaskRepository(
          localDataSource: TaskLocalDataSource(),
          remoteDataSource: TaskRemoteDataSource(),
        ),
      ),
      child: MaterialApp.router(
        title: 'Task Manager',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
