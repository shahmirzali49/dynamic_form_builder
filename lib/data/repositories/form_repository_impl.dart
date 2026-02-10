import 'dart:convert';

import 'package:dynamic_form_builder/data/datasources/form_datasource.dart';
import 'package:dynamic_form_builder/data/models/form_dto.dart';
import 'package:dynamic_form_builder/domain/entities/form_entity.dart';
import 'package:dynamic_form_builder/domain/repositories/form_repository.dart';

class FormRepositoryImpl implements FormRepository {
  FormRepositoryImpl(this._datasource);

  final FormDatasource _datasource;

  @override
  Future<FormEntity> loadForm(String assetPath) async {
    try {
      final jsonString = await _datasource.loadFormJson(assetPath);
      final json = jsonDecode(jsonString);
      return FormDto.fromJson(json).toEntity();
    } catch (e) {
      throw Exception('Failed to load form from $assetPath: $e');
    }
  }
}
