import 'package:dynamic_form_builder/core/extensions/context_extensions.dart';
import 'package:dynamic_form_builder/core/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, mode) {
        final isDark = mode == ThemeMode.dark;
        return IconButton(
          onPressed: () => context.read<ThemeCubit>().toggleTheme(),
          icon: Icon(
            isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
          ),
          tooltip: isDark
              ? context.locale.switchToLightMode
              : context.locale.switchToDarkMode,
        );
      },
    );
  }
}
