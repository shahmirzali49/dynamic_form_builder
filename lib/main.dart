import 'package:dynamic_form_builder/core/di/injection.dart';
import 'package:dynamic_form_builder/core/extensions/context_extensions.dart';
import 'package:dynamic_form_builder/core/l10n/app_localizations.dart';
import 'package:dynamic_form_builder/core/navigation/app_router.dart';
import 'package:dynamic_form_builder/core/theme/app_theme.dart';
import 'package:dynamic_form_builder/core/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  // Use path-based URLs (e.g. /form/foo) instead of hash (#) for web.
  usePathUrlStrategy();
  setupInjection();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<ThemeCubit>(create: (_) => getIt<ThemeCubit>())],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: context.locale.appTitle,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeMode,
            locale: const Locale('en'),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('en')],
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
