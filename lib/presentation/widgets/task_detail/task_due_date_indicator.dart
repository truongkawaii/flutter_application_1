import 'package:flutter/material.dart';

class TaskDueDateIndicator extends StatelessWidget {
  final DateTime dueDate;

  const TaskDueDateIndicator({required this.dueDate});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final difference = dueDate.difference(now);

    String timeText;
    Color timeColor;
    IconData timeIcon;

    if (difference.isNegative) {
      timeText = 'Overdue by ${difference.inDays.abs()} days';
      timeColor = Colors.red;
      timeIcon = Icons.error_rounded;
    } else if (difference.inDays == 0) {
      timeText = 'Due today';
      timeColor = Colors.orange;
      timeIcon = Icons.today_rounded;
    } else if (difference.inDays == 1) {
      timeText = 'Due tomorrow';
      timeColor = Colors.orange;
      timeIcon = Icons.event_rounded;
    } else {
      timeText = 'Due in ${difference.inDays} days';
      timeColor = Colors.green;
      timeIcon = Icons.calendar_month_rounded;
    }

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: timeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: timeColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(timeIcon, color: timeColor, size: 24),
          SizedBox(width: 12),
          Text(
            timeText,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: timeColor,
            ),
          ),
        ],
      ),
    );
  }
}
