import 'package:flutter/services.dart';

abstract class FormDatasource {
  Future<String> loadFormJson(String assetPath);
}

class FormDatasourceImpl implements FormDatasource {
  @override
  Future<String> loadFormJson(String assetPath) async {
    final jsonString = await rootBundle.loadString(assetPath);
    return jsonString;
  }
}
