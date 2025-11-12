import 'package:flutter/material.dart';
import '../../models/task_model.dart';
import '../../config/app_theme.dart';
import 'category_chip.dart';

class CategoryFilter extends StatelessWidget {
  final TaskCategory? selectedCategory;
  final ValueChanged<TaskCategory?> onCategoryChanged;

  const CategoryFilter({
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  // Static list of filter options
  static final List<_FilterOption> _filterOptions = [
    _FilterOption(label: 'All', category: null, color: AppTheme.primaryColor),
    _FilterOption(
      label: 'WORK',
      category: TaskCategory.work,
      color: AppTheme.categoryColors[TaskCategory.work]!,
    ),
    _FilterOption(
      label: 'PERSONAL',
      category: TaskCategory.personal,
      color: AppTheme.categoryColors[TaskCategory.personal]!,
    ),
    _FilterOption(
      label: 'SHOPPING',
      category: TaskCategory.shopping,
      color: AppTheme.categoryColors[TaskCategory.shopping]!,
    ),
    _FilterOption(
      label: 'HEALTH',
      category: TaskCategory.health,
      color: AppTheme.categoryColors[TaskCategory.health]!,
    ),
    _FilterOption(
      label: 'OTHER',
      category: TaskCategory.other,
      color: AppTheme.categoryColors[TaskCategory.other]!,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: _filterOptions.length,
        itemBuilder: (context, index) {
          final option = _filterOptions[index];
          return CategoryChip(
            label: option.label,
            color: option.color,
            isSelected: selectedCategory == option.category,
            onTap: () => onCategoryChanged(option.category),
          );
        },
      ),
    );
  }
}

// Private class for filter options
class _FilterOption {
  final String label;
  final TaskCategory? category;
  final Color color;

  const _FilterOption({
    required this.label,
    required this.category,
    required this.color,
  });
}
