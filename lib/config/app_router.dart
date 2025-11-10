import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_routes.dart';
import '../presentation/screens/main_screen.dart';
import '../presentation/screens/home_screen.dart';
import '../presentation/screens/statistics_screen.dart';
import '../presentation/screens/profile_screen.dart';
import '../presentation/screens/task_detail_screen.dart';

class AppRouter {
  // Private constructor
  AppRouter._();

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.home,
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return MainScreen(child: child);
        },
        routes: [
          GoRoute(
            path: AppRoutes.home,
            name: AppRoutes.homeName,
            pageBuilder: (context, state) => NoTransitionPage(
              child: HomeScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.statistics,
            name: AppRoutes.statisticsName,
            pageBuilder: (context, state) => NoTransitionPage(
              child: StatisticsScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.profile,
            name: AppRoutes.profileName,
            pageBuilder: (context, state) => NoTransitionPage(
              child: ProfileScreen(),
            ),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.taskDetail,
        name: AppRoutes.taskDetailName,
        builder: (context, state) {
          final taskId = state.pathParameters['id']!;
          return TaskDetailScreen(taskId: taskId);
        },
      ),
    ],
    // Error handler
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red),
            SizedBox(height: 16),
            Text(
              'Page not found',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('The page you are looking for does not exist.'),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: Text('Go to Home'),
            ),
          ],
        ),
      ),
    ),
  );
}
