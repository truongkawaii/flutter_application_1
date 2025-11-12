import 'package:flutter/material.dart';
import '../../../models/task_model.dart';
import '../../../config/app_theme.dart';
import '../../../utils/task_helpers.dart';
import 'form_section_title.dart';

class FormCategorySelector extends StatelessWidget {
  final TaskCategory selectedCategory;
  final ValueChanged<TaskCategory> onChanged;

  const FormCategorySelector({
    required this.selectedCategory,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormSectionTitle(title: 'Category', icon: Icons.category),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: TaskCategory.values.map((category) {
              return RadioListTile<TaskCategory>(
                title: Row(
                  children: [
                    Icon(
                      TaskHelpers.getCategoryIcon(category),
                      color: AppTheme.categoryColors[category],
                    ),
                    SizedBox(width: 12),
                    Text(category.name.toUpperCase()),
                  ],
                ),
                value: category,
                groupValue: selectedCategory,
                activeColor: AppTheme.categoryColors[category],
                onChanged: (value) => onChanged(value!),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
