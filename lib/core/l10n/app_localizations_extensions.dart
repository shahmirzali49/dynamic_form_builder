import 'package:dynamic_form_builder/core/models/form_info.dart';

import 'app_localizations.dart';

extension AppLocalizationsExtensions on AppLocalizations {
  String formTitleFor(FormInfo formInfo) {
    switch (formInfo.urlName) {
      case 'customer_onboarding':
        return formTitleNewConnectionRequest;
      case 'travel_request':
        return formTitleTravelRequest;
      case 'feedback_and_registration':
        return formTitleFeedbackRegistration;
      default:
        return formInfo.title;
    }
  }
}
