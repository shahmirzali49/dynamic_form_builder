import 'package:flutter/material.dart';

 
class AppColors {
  AppColors._();

  static const Color seedLight = Color(0xFF5C6BC0);
  static const Color seedDark = Color(0xFF7986CB);

  static ColorScheme get lightColorScheme {
    return ColorScheme.fromSeed(
      seedColor: seedLight,
      brightness: Brightness.light,
      primary: const Color(0xFF3949AB),
      secondary: const Color(0xFF00897B),
      surface: Colors.white,
    );
  }

  static ColorScheme get darkColorScheme {
    return ColorScheme.fromSeed(
      seedColor: seedDark,
      brightness: Brightness.dark,
      primary: const Color(0xFF7986CB),
      secondary: const Color(0xFF4DB6AC),
      surface: const Color(0xFF1E1E2E),
    ).copyWith(
      surface: const Color(0xFF1E1E2E),
      surfaceContainerHighest: const Color(0xFF2D2D3D),
    );
  }

  static const Color scaffoldBackgroundLight = Color(0xFFF5F5F7);
  static const Color scaffoldBackgroundDark = Color(0xFF12121A);
}
