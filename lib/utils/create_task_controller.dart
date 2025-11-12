import 'package:flutter/material.dart';
import '../models/task_model.dart';

class CreateTaskController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  TaskCategory _selectedCategory = TaskCategory.work;
  TaskPriority _selectedPriority = TaskPriority.medium;
  DateTime _selectedDate = DateTime.now().add(Duration(days: 1));
  String? _imageUrl;
  bool _isLoading = false;

  // Getters
  TaskCategory get selectedCategory => _selectedCategory;
  TaskPriority get selectedPriority => _selectedPriority;
  DateTime get selectedDate => _selectedDate;
  String? get imageUrl => _imageUrl;
  bool get isLoading => _isLoading;

  // Setters
  void setCategory(TaskCategory category) {
    _selectedCategory = category;
  }

  void setPriority(TaskPriority priority) {
    _selectedPriority = priority;
  }

  void setDate(DateTime date) {
    _selectedDate = date;
  }

  void setImageUrl(String? url) {
    _imageUrl = url;
  }

  void setLoading(bool loading) {
    _isLoading = loading;
  }

  // Validation
  bool validate() {
    return formKey.currentState?.validate() ?? false;
  }

  // Dispose
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
  }
}
