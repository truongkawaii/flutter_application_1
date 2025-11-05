import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/business_profile.dart';
import 'package:flutter_application_1/utils/app_colors.dart';
import 'package:flutter_application_1/widgets/business_card.dart';
import 'package:flutter_application_1/widgets/calculator_widget.dart';

class SmartBusinessCalculatorPage extends StatelessWidget {
  const SmartBusinessCalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = BusinessProfile.sample();
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: const Text(
          'Smart Business Calculator',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Business Card Section
                BusinessCard(profile: profile),
                const SizedBox(height: 24),

                // Calculator Section
                const CalculatorWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
