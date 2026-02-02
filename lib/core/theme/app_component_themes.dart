import 'package:flutter/material.dart';


class AppComponentThemes {
  AppComponentThemes._();

  static AppBarTheme appBarTheme(
    ColorScheme colorScheme, {
    bool isDark = false,
  }) {
    return AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: isDark ? 4 : 2,
      centerTitle: true,
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      surfaceTintColor: colorScheme.primary.withValues(
        alpha: isDark ? 0.12 : 0.08,
      ),
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
      iconTheme: IconThemeData(color: colorScheme.onSurfaceVariant),
    );
  }

  static CardThemeData cardTheme(
    ColorScheme colorScheme, {
    bool isDark = false,
  }) {
    return CardThemeData(
      elevation: isDark ? 0 : 1,
      shadowColor: isDark ? null : Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: isDark ? colorScheme.surfaceContainerHighest : colorScheme.surface,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
    );
  }

  static InputDecorationTheme inputDecorationTheme(
    ColorScheme colorScheme, {
    bool isDark = false,
  }) {
    final fillOpacity = isDark ? 0.6 : 0.5;
    final outlineOpacity = isDark ? 0.5 : 1.0;
    final hintOpacity = isDark ? 0.8 : 0.7;
    return InputDecorationTheme(
      filled: true,
      fillColor: colorScheme.surfaceContainerHighest.withValues(
        alpha: fillOpacity,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(
          color: isDark
              ? colorScheme.outlineVariant.withValues(alpha: outlineOpacity)
              : colorScheme.outlineVariant,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: colorScheme.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: colorScheme.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: colorScheme.error, width: 2),
      ),
      labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
      floatingLabelStyle: TextStyle(color: colorScheme.primary),
      hintStyle: TextStyle(
        color: colorScheme.onSurfaceVariant.withValues(alpha: hintOpacity),
      ),
      errorStyle: TextStyle(color: colorScheme.error, fontSize: 13),
    );
  }

  static ElevatedButtonThemeData elevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 28),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  static OutlinedButtonThemeData outlinedButtonTheme() {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  static ListTileThemeData listTileTheme() {
    return ListTileThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    );
  }

  static DividerThemeData dividerTheme(
    ColorScheme colorScheme, {
    bool isDark = false,
  }) {
    return DividerThemeData(
      color: colorScheme.outlineVariant.withValues(alpha: isDark ? 0.4 : 0.6),
      thickness: 1,
    );
  }

  static CheckboxThemeData checkboxTheme(ColorScheme colorScheme) {
    return CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return colorScheme.primary;
        return null;
      }),
    );
  }

  static SliderThemeData sliderTheme(ColorScheme colorScheme) {
    return SliderThemeData(
      overlayShape: const RoundSliderOverlayShape(overlayRadius: 18),
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
      trackHeight: 6,
      activeTrackColor: colorScheme.primary,
      inactiveTrackColor: colorScheme.surfaceContainerHighest,
    );
  }
}
