import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_component_themes.dart';
import 'app_text_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final colorScheme = AppColors.lightColorScheme;
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.scaffoldBackgroundLight,
      appBarTheme: AppComponentThemes.appBarTheme(colorScheme),
      cardTheme: AppComponentThemes.cardTheme(colorScheme),
      inputDecorationTheme: AppComponentThemes.inputDecorationTheme(colorScheme),
      elevatedButtonTheme: AppComponentThemes.elevatedButtonTheme(),
      outlinedButtonTheme: AppComponentThemes.outlinedButtonTheme(),
      textTheme: AppTextTheme.textTheme(colorScheme.onSurface),
      listTileTheme: AppComponentThemes.listTileTheme(),
      dividerTheme: AppComponentThemes.dividerTheme(colorScheme),
      checkboxTheme: AppComponentThemes.checkboxTheme(colorScheme),
      sliderTheme: AppComponentThemes.sliderTheme(colorScheme),
    );
  }

  static ThemeData get dark {
    final colorScheme = AppColors.darkColorScheme;
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.scaffoldBackgroundDark,
      appBarTheme: AppComponentThemes.appBarTheme(colorScheme, isDark: true),
      cardTheme: AppComponentThemes.cardTheme(colorScheme, isDark: true),
      inputDecorationTheme: AppComponentThemes.inputDecorationTheme(
        colorScheme,
        isDark: true,
      ),
      elevatedButtonTheme: AppComponentThemes.elevatedButtonTheme(),
      outlinedButtonTheme: AppComponentThemes.outlinedButtonTheme(),
      textTheme: AppTextTheme.textTheme(colorScheme.onSurface),
      listTileTheme: AppComponentThemes.listTileTheme(),
      dividerTheme: AppComponentThemes.dividerTheme(colorScheme, isDark: true),
      checkboxTheme: AppComponentThemes.checkboxTheme(colorScheme),
      sliderTheme: AppComponentThemes.sliderTheme(colorScheme),
    );
  }
}
