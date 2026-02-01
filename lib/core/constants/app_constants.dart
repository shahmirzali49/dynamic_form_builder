class FormInfo {
  final String title;
  final String assetPath;

  const FormInfo({required this.title, required this.assetPath});
}

class AppConstants {
  AppConstants._();

  static const String appTitle = 'Dynamic Form Builder';

  static const List<FormInfo> forms = [
    FormInfo(
      title: 'New Connection Request',
      assetPath: 'assets/forms/customer_onboarding.json',
    ),
    FormInfo(
      title: 'Travel Request',
      assetPath: 'assets/forms/travel_request.json',
    ),
    FormInfo(
      title: 'Feedback & Registration',
      assetPath: 'assets/forms/feedback_and_registration.json',
    ),
  ];
}
