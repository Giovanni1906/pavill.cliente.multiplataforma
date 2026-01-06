import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_theme_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      extensions: const [
        AppThemeColors(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          text: AppColors.text,
          background: AppColors.background,
          box: AppColors.boxBackground,
          glow: AppColors.glowBackground,
          shadow: AppColors.shadow,
          slowPrimary: AppColors.slowPrimary,
          green: AppColors.green,
        ),
      ],
      colorScheme: const ColorScheme.light(
        primary: AppColors.text,
        secondary: AppColors.secondary,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(fontSize: 14, color: AppColors.text),
        bodyMedium: TextStyle(fontSize: 14, color: AppColors.text),
        bodySmall: TextStyle(fontSize: 14, color: AppColors.text),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.darkPrimary,
      scaffoldBackgroundColor: AppColors.darkBackground,
      extensions: const [
        AppThemeColors(
          primary: AppColors.darkPrimary,
          secondary: AppColors.darkSecondary,
          text: AppColors.darkText,
          background: AppColors.darkBackground,
          box: AppColors.darkBoxBackground,
          glow: AppColors.darkGlowBackground,
          shadow: AppColors.darkShadow,
          slowPrimary: AppColors.darkSlowPrimary,
          green: AppColors.green,
        ),
      ],
      colorScheme: const ColorScheme.dark(
        primary: AppColors.darkPrimary,
        secondary: AppColors.darkSecondary,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(fontSize: 14, color: AppColors.darkText),
        bodyMedium: TextStyle(fontSize: 14, color: AppColors.darkText),
        bodySmall: TextStyle(fontSize: 14, color: AppColors.darkText),
      ),
    );
  }
}
