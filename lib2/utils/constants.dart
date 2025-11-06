import 'package:flutter/material.dart';

/// Constants cho toàn app
class AppConstants {
  AppConstants._();

  // Colors
  static const Color primaryColor = Colors.blue;
  static const Color accentColor = Colors.blueAccent;
  static const Color errorColor = Colors.red;
  static const Color successColor = Colors.green;

  // Text Styles
  static const TextStyle titleStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle subtitleStyle = TextStyle(
    fontSize: 16,
    color: Colors.grey,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontSize: 14,
  );

  // Padding & Margins
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;

  // Border Radius
  static const double defaultRadius = 12.0;
  static const double cardRadius = 16.0;

  // Avatar Size
  static const double avatarRadius = 30.0;
  static const double largeAvatarRadius = 60.0;
}
