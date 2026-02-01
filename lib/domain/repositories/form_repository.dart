import 'package:dynamic_form_builer/domain/entities/form_entity.dart';

abstract class FormRepository {
  Future<FormEntity> loadForm(String assetPath);
}
