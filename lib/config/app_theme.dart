import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/task_model.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF6C63FF);
  static const Color secondaryColor = Color(0xFFFF6584);
  static const Color backgroundColor = Color(0xFFF8F9FA);
  static const Color cardColor = Colors.white;
  static const Color textPrimary = Color(0xFF2D3436);
  static const Color textSecondary = Color(0xFF636E72);

  // Category Colors
  static const Map<TaskCategory, Color> categoryColors = {
    TaskCategory.work: Color(0xFF6C63FF),
    TaskCategory.personal: Color(0xFFFF6584),
    TaskCategory.shopping: Color(0xFF26DE81),
    TaskCategory.health: Color(0xFFFD79A8),
    TaskCategory.other: Color(0xFF74B9FF),
  };

  // Priority Colors
  static const Map<TaskPriority, Color> priorityColors = {
    TaskPriority.low: Color(0xFF26DE81),
    TaskPriority.medium: Color(0xFFFECE2F),
    TaskPriority.high: Color(0xFFFF6584),
  };

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: backgroundColor,
        foregroundColor: textPrimary,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: primaryColor,
        unselectedItemColor: textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }
}
