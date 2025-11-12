import 'package:flutter/material.dart';
import '../../../config/app_theme.dart';
import '../stat_card.dart';

class StatisticsCardsSection extends StatelessWidget {
  final int completedTasks;
  final int pendingTasks;
  final int totalTasks;
  final double completionRate;

  const StatisticsCardsSection({
    required this.completedTasks,
    required this.pendingTasks,
    required this.totalTasks,
    required this.completionRate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: StatCard(
                icon: Icons.check_circle_rounded,
                title: 'Completed',
                value: completedTasks.toString(),
                color: Colors.green,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: StatCard(
                icon: Icons.pending_rounded,
                title: 'Pending',
                value: pendingTasks.toString(),
                color: Colors.orange,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: StatCard(
                icon: Icons.task_rounded,
                title: 'Total Tasks',
                value: totalTasks.toString(),
                color: AppTheme.primaryColor,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: StatCard(
                icon: Icons.trending_up_rounded,
                title: 'Completion',
                value: '${completionRate.toStringAsFixed(1)}%',
                color: AppTheme.secondaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
