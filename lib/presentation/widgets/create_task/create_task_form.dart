import 'package:flutter/material.dart';
import '../../../utils/create_task_controller.dart';
import 'form_title_field.dart';
import 'form_description_field.dart';
import 'form_category_selector.dart';
import 'form_priority_selector.dart';
import 'form_date_selector.dart';
import 'form_image_url_field.dart';
import 'form_submit_button.dart';

class CreateTaskForm extends StatefulWidget {
  final CreateTaskController controller;
  final VoidCallback onSubmit;

  const CreateTaskForm({
    required this.controller,
    required this.onSubmit,
  });

  @override
  State<CreateTaskForm> createState() => _CreateTaskFormState();
}

class _CreateTaskFormState extends State<CreateTaskForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.controller.formKey,
      child: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // Title Field
          FormTitleField(controller: widget.controller.titleController),
          SizedBox(height: 24),

          // Description Field
          FormDescriptionField(controller: widget.controller.descriptionController),
          SizedBox(height: 24),

          // Category Selector
          FormCategorySelector(
            selectedCategory: widget.controller.selectedCategory,
            onChanged: (category) {
              setState(() {
                widget.controller.setCategory(category);
              });
            },
          ),
          SizedBox(height: 24),

          // Priority Selector
          FormPrioritySelector(
            selectedPriority: widget.controller.selectedPriority,
            onChanged: (priority) {
              setState(() {
                widget.controller.setPriority(priority);
              });
            },
          ),
          SizedBox(height: 24),

          // Date Selector
          FormDateSelector(
            selectedDate: widget.controller.selectedDate,
            onDateSelected: (date) {
              setState(() {
                widget.controller.setDate(date);
              });
            },
          ),
          SizedBox(height: 24),

          // Image URL Field
          FormImageUrlField(
            imageUrl: widget.controller.imageUrl,
            onChanged: (url) {
              setState(() {
                widget.controller.setImageUrl(url);
              });
            },
          ),
          SizedBox(height: 32),

          // Submit Button
          FormSubmitButton(
            isLoading: widget.controller.isLoading,
            onPressed: widget.onSubmit,
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
