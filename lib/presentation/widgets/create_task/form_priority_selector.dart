import 'package:flutter/material.dart';
import '../../../models/task_model.dart';
import '../../../config/app_theme.dart';
import 'form_section_title.dart';

class FormPrioritySelector extends StatelessWidget {
  final TaskPriority selectedPriority;
  final ValueChanged<TaskPriority> onChanged;

  const FormPrioritySelector({
    required this.selectedPriority,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormSectionTitle(title: 'Priority', icon: Icons.flag),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: TaskPriority.values.map((priority) {
              final isSelected = selectedPriority == priority;
              return GestureDetector(
                onTap: () => onChanged(priority),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppTheme.priorityColors[priority]
                        : AppTheme.priorityColors[priority]!.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppTheme.priorityColors[priority]!,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Text(
                    priority.name.toUpperCase(),
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : AppTheme.priorityColors[priority],
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
