import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/respositories/user_respository.dart';
import 'package:flutter_application_1/logic/blocs/user_bloc/user_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'logic/blocs/user_bloc/user_bloc.dart';
import 'presentation/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Khởi tạo Repository
    final userRepository = UserRepository();

    return RepositoryProvider.value(
      value: userRepository,
      child: BlocProvider(
        // Tạo BLoC global cho toàn app
        create: (context) => UserBloc(userRepository)
          ..add(LoadUsersEvent()), // Load users khi khởi động
        child: MaterialApp(
          title: 'User Management',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
