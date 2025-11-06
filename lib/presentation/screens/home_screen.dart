import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/todo_cubit.dart';
import 'package:flutter_application_1/bloc/todo_state.dart';
import 'package:flutter_application_1/models/todo_model.dart';
import 'package:flutter_application_1/presentation/widgets/todo_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        actions: [
          PopupMenuButton<DataSource>(
            itemBuilder: (context) => [
              PopupMenuItem(value: DataSource.local, child: Text('Load Local')),
              PopupMenuItem(
                value: DataSource.remote,
                child: Text('Load remote'),
              ),
            ],
            onSelected: (source) {
              context.read<TodoCubit>().loadTodos(source);
            },
          ),
        ],
      ),
      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          if (state is TodoInitial) {
            return Center(child: Text('Select data source from menu'));
          }
          if (state is TodoLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is TodoError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          if (state is TodoLoaded) {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Source',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.todos.length,
                    itemBuilder: (context, index) {
                      return TodoItem(todo: state.todos[index], onToggle: (){
                        context.read<TodoCubit>().toggleTodo(state.todos[index].id);
                      });
                    },
                  ),
                ),
              ],
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/add'),
        child: Icon(Icons.add),
      ),
    );
  }
}
