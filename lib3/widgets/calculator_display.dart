import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/app_colors.dart';

class CalculatorDisplay extends StatelessWidget {
  final String displayText;

  const CalculatorDisplay({super.key, required this.displayText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.displayBackground,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.displayBorder, width: 1),
      ),
      child: Text(
        displayText,
        textAlign: TextAlign.right,
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: AppColors.displayTextColor,
        ),
      ),
    );
  }
}
