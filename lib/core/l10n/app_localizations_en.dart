// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Dynamic Form Builder';

  @override
  String get selectAForm => 'Select a form';

  @override
  String loadFormFrom(String path) {
    return 'Load form from $path';
  }

  @override
  String get formTitleNewConnectionRequest => 'New Connection Request';

  @override
  String get formTitleTravelRequest => 'Travel Request';

  @override
  String get formTitleFeedbackRegistration => 'Feedback & Registration';

  @override
  String get form => 'Form';

  @override
  String get loadingForm => 'Loading form…';

  @override
  String get unknownError => 'Unknown error';

  @override
  String get back => 'Back';

  @override
  String get fillFieldsHint =>
      'Fill in the fields below. Validation updates as you type.';

  @override
  String get submit => 'Submit';

  @override
  String get submissionOutput => 'Submission output';

  @override
  String formNotFound(String formName) {
    return 'Form \"$formName\" not found';
  }

  @override
  String get pageNotFound => 'Page not found';

  @override
  String get error => 'Error';

  @override
  String get goToHome => 'Go to Home';

  @override
  String get switchToLightMode => 'Switch to light mode';

  @override
  String get switchToDarkMode => 'Switch to dark mode';

  @override
  String get selectDate => 'Select date';
}
