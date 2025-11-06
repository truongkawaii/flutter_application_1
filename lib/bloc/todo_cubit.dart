import 'package:flutter_application_1/bloc/todo_state.dart';
import 'package:flutter_application_1/data/repositories/todo_repository.dart';
import 'package:flutter_application_1/models/todo_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoCubit extends Cubit<TodoState> {
  final TodoRepository repository;

  TodoCubit(this.repository) : super(TodoInitial());

  // Load todos từ local hoặc remote
  Future<void> loadTodos(DataSource source) async {
    emit(TodoLoading());
    try {
      final todos = await repository.getTodos(source);
      emit(TodoLoaded(todos, source));
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  // Toggle complete
  void toggleTodo(String id) {
    if (state is TodoLoaded) {
      final currentState = state as TodoLoaded;
      final updatedTodos = currentState.todos.map((todo) {
        if (todo.id == id) {
          return todo.copyWith(isComplete: !todo.isCompleted);
        }
        return todo;
      }).toList();
      emit(TodoLoaded(updatedTodos, currentState.source));
    }
  }
  // Add todo
  Future<void> addTodo(String title) async {
    if(state is TodoLoaded){
      final currentState = state as TodoLoaded;
      final newTodo = Todo(id: DateTime.now().toString(),title: title);
      await repository.addTodo(newTodo);
      final updatedTodos = [...currentState.todos,newTodo];
      emit(TodoLoaded(updatedTodos, currentState.source));
    }
  }
}
