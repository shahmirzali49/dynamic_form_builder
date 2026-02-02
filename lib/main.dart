import 'package:dynamic_form_builer/core/constants/app_constants.dart';
import 'package:dynamic_form_builer/core/theme/app_theme.dart';
import 'package:dynamic_form_builer/core/theme/theme_cubit.dart';
import 'package:dynamic_form_builer/data/datasources/form_datasource.dart';
import 'package:dynamic_form_builer/data/repositories/form_repository_impl.dart';
import 'package:dynamic_form_builer/domain/repositories/form_repository.dart';
import 'package:dynamic_form_builer/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
        RepositoryProvider<FormRepository>(
          create: (_) => FormRepositoryImpl(FormDatasourceImpl()),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppConstants.appTitle,
        theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeMode,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
