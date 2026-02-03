import 'package:flutter/services.dart';

abstract class FormDatasource {
  Future<String> loadFormJson(String assetPath);
}

/// Default implementation that loads form JSON from Flutter assets (rootBundle).
class AssetFormDatasource implements FormDatasource {
  @override
  Future<String> loadFormJson(String assetPath) async {
    return rootBundle.loadString(assetPath);
  }
}
