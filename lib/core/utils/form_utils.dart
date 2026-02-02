import 'package:dynamic_form_builer/core/constants/app_constants.dart';

class FormUtils {
  FormUtils._();

  static String? getAssetPathForFormName(String urlName) {
    for (final f in AppConstants.forms) {
      if (f.urlName == urlName) return f.assetPath;
    }
    return null;
  }
}
