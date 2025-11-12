import 'package:flutter/material.dart';
import '../../../config/app_theme.dart';
import 'form_section_title.dart';

class FormImageUrlField extends StatelessWidget {
  final String? imageUrl;
  final ValueChanged<String?> onChanged;

  const FormImageUrlField({
    required this.imageUrl,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormSectionTitle(title: 'Image URL (Optional)', icon: Icons.image),
        SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Enter image URL',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            prefixIcon: Icon(Icons.link, color: AppTheme.primaryColor),
          ),
          onChanged: (value) => onChanged(value.isEmpty ? null : value),
        ),

        // Image Preview
        if (imageUrl != null && imageUrl!.isNotEmpty) ...[
          SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl!,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 150,
                  color: Colors.grey.shade200,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.broken_image, size: 48, color: Colors.grey),
                        SizedBox(height: 8),
                        Text(
                          'Invalid image URL',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ],
    );
  }
}
