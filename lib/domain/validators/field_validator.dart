import 'package:dynamic_form_builder/domain/entities/validation_result.dart';

abstract class FieldValidator {
  ValidationResult validate(dynamic value, Map<String, dynamic> validators);
}
