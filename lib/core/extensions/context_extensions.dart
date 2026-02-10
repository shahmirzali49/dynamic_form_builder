import 'package:dynamic_form_builder/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;

  AppLocalizations get locale =>
      AppLocalizations.of(this) ?? lookupAppLocalizations(const Locale('en'));
}
