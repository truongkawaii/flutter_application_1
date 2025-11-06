import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/todo_cubit.dart';
import 'package:flutter_application_1/config/app_router.dart';
import 'package:flutter_application_1/data/datasources/todo_local_datasource.dart';
import 'package:flutter_application_1/data/datasources/todo_remote_datasource.dart';
import 'package:flutter_application_1/data/repositories/todo_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit(
        TodoRepository(
          localDatasource: TodoLocalDatasource(),
          remoteDatasource: TodoRemoteDatasource(),
        ),
      ),
      child: MaterialApp.router(
        title: 'Todo BLoC App',
        theme: ThemeData(primarySwatch: Colors.blue),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
