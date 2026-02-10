import 'package:dynamic_form_builder/core/models/form_info.dart';

class AppConstants {
  AppConstants._();

  static const List<FormInfo> forms = [
    FormInfo(
      title: 'New Connection Request',
      assetPath: 'assets/forms/customer_onboarding.json',
      urlName: 'customer_onboarding',
    ),
    FormInfo(
      title: 'Travel Request',
      assetPath: 'assets/forms/travel_request.json',
      urlName: 'travel_request',
    ),
    FormInfo(
      title: 'Feedback & Registration',
      assetPath: 'assets/forms/feedback_and_registration.json',
      urlName: 'feedback_and_registration',
    ),
  ];
}
