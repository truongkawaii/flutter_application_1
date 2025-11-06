import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/blocs/user_bloc/user_bloc.dart';
import '../../logic/blocs/user_bloc/user_event.dart';
import '../../logic/blocs/user_bloc/user_state.dart';
import '../../data/models/user_model.dart';
import '../widgets/custom_text_field.dart';
import '../../utils/validators.dart';
import '../../utils/constants.dart';

/// Screen chỉnh sửa user
class EditUserScreen extends StatefulWidget {
  final UserModel user;

  const EditUserScreen({
    super.key,
    required this.user,
  });

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _positionController;
  late TextEditingController _departmentController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers với dữ liệu user hiện tại
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
    _phoneController = TextEditingController(text: widget.user.phone);
    _positionController = TextEditingController(text: widget.user.position);
    _departmentController = TextEditingController(text: widget.user.department);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _positionController.dispose();
    _departmentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit User'),
        centerTitle: true,
      ),
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppConstants.successColor,
              ),
            );
            Navigator.pop(context);
          } else if (state is UserError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppConstants.errorColor,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // User Avatar
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: AppConstants.largeAvatarRadius,
                        backgroundImage: NetworkImage(widget.user.avatar),
                        onBackgroundImageError: (_, __) {},
                        child: const Icon(Icons.person, size: 60),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppConstants.primaryColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Name Field
                CustomTextField(
                  controller: _nameController,
                  label: 'Full Name',
                  hint: 'Enter full name',
                  icon: Icons.person,
                  validator: Validators.validateName,
                ),
                const SizedBox(height: 16),

                // Email Field
                CustomTextField(
                  controller: _emailController,
                  label: 'Email',
                  hint: 'Enter email address',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.validateEmail,
                ),
                const SizedBox(height: 16),

                // Phone Field
                CustomTextField(
                  controller: _phoneController,
                  label: 'Phone',
                  hint: 'Enter phone number',
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  validator: Validators.validatePhone,
                ),
                const SizedBox(height: 16),

                // Position Field
                CustomTextField(
                  controller: _positionController,
                  label: 'Position',
                  hint: 'Enter job position',
                  icon: Icons.work,
                  validator: (value) => Validators.validateRequired(value, 'Position'),
                ),
                const SizedBox(height: 16),

                // Department Field
                CustomTextField(
                  controller: _departmentController,
                  label: 'Department',
                  hint: 'Enter department',
                  icon: Icons.business,
                  validator: (value) => Validators.validateRequired(value, 'Department'),
                ),
                const SizedBox(height: 32),

                // Update Button
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    final isLoading = state is UserLoading;

                    return ElevatedButton(
                      onPressed: isLoading ? null : _submitForm,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppConstants.defaultRadius,
                          ),
                        ),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : const Text(
                              'Update User',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    );
                  },
                ),
                const SizedBox(height: 16),

                // Cancel Button
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppConstants.defaultRadius,
                      ),
                    ),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Create updated user model
      // final updatedUser = widget.user.copyWith(
      //   name: _nameController.text.trim(),
      //   email: _emailController.text.trim(),
      //   phone: _phoneController.text.trim(),
      //   position: _positionController.text.trim(),
      //   department: _departmentController.text.trim(),
      // );

      // Dispatch update event
      // context.read<UserBloc>().add(UpdateUserEvent(updatedUser));
    }
  }
}
