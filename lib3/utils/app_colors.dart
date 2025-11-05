import 'package:flutter/material.dart';

/// Quản lý màu sắc toàn ứng dụng
class AppColors {
  // Private constructor để ngăn khởi tạo
  AppColors._();

  // Business Card Colors
  static const Color primaryColor = Colors.deepPurple;
  static final Color primaryLight = Colors.deepPurple.shade400;
  static final Color primaryDark = Colors.deepPurple.shade700;
  static const Color cardTextColor = Colors.white;

  // Calculator Colors
  static const Color displayBackground = Color(0xFFF5F5F5);
  static final Color displayBorder = Colors.grey.shade300;
  static final Color displayTextColor = Colors.deepPurple.shade700;

  // Button Colors
  static const Color numberButtonBg = Colors.white;
  static const Color numberButtonText = Colors.black87;

  static final Color operatorButtonBg = Colors.orange.shade400;
  static const Color operatorButtonText = Colors.white;

  static final Color functionButtonBg = Colors.grey.shade300;
  static const Color functionButtonText = Colors.black87;

  static final Color clearButtonBg = Colors.red.shade400;
  static const Color clearButtonText = Colors.white;

  static final Color equalsButtonBg = Colors.green.shade400;
  static const Color equalsButtonText = Colors.white;

  // General
  static final Color scaffoldBackground = Colors.grey.shade100;
  static final Color cardShadow = Colors.grey.withOpacity(0.2);
}
