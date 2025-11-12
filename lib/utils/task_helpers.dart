import 'package:flutter/material.dart';
import '../models/task_model.dart';

class TaskHelpers {
  static IconData getCategoryIcon(TaskCategory category) {
    switch (category) {
      case TaskCategory.work:
        return Icons.work_rounded;
      case TaskCategory.personal:
        return Icons.person_rounded;
      case TaskCategory.shopping:
        return Icons.shopping_cart_rounded;
      case TaskCategory.health:
        return Icons.favorite_rounded;
      case TaskCategory.other:
        return Icons.more_horiz_rounded;
    }
  }

  static String getCategoryName(TaskCategory category) {
    return category.name.toUpperCase();
  }

  static String getPriorityName(TaskPriority priority) {
    return priority.name.toUpperCase();
  }
}
