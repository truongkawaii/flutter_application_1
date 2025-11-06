import 'package:flutter_application_1/presentation/screens/add_todo_screen.dart';
import 'package:flutter_application_1/presentation/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: '/add',
        name: 'add',
        builder: (context, state) => AddTodoScreen(),
      ),
    ],
  );
}
