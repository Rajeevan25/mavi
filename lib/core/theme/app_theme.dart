import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mavi_security/core/theme/app_colors.dart';

class AppTheme {
  static const Color primaryColor = Color(0001436); // #000e24 - Adjusted for better visibility in Flutter deep navy
  static const Color navyDeep = AppColors.navyDeep;
  static const Color navyLight = AppColors.navyLight;
  static const Color slate = AppColors.slate;
  static const Color background = AppColors.background;
  static const Color surface = Colors.white;
  static const Color error = AppColors.error;
  static const Color errorContainer = AppColors.errorContainer;
  static const Color onPrimary = Colors.white;
  static const Color primaryContainer = AppColors.primaryContainer;

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: navyDeep,
        onPrimary: onPrimary,
        primaryContainer: primaryContainer,
        secondary: slate,
        onSecondary: Colors.white,
        background: background,
        surface: surface,
        error: error,
        errorContainer: errorContainer,
        onSurface: AppColors.onSurface,
        outline: AppColors.outline,
      ),
      textTheme: GoogleFonts.interTextTheme(),
      scaffoldBackgroundColor: background,
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: navyDeep,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.black.withOpacity(0.05)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: navyDeep,
          foregroundColor: onPrimary,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
