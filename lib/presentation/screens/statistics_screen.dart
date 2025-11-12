import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/task_cubit.dart';
import '../../bloc/task_state.dart';
import '../widgets/statistics/statistics_app_bar.dart';
import '../widgets/statistics/statistics_overview.dart';
import '../widgets/statistics/statistics_empty_state.dart';

class StatisticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StatisticsAppBar(),
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state is! TaskLoaded) {
            return StatisticsEmptyState();
          }

          return StatisticsOverview(tasks: state.tasks);
        },
      ),
    );
  }
}
