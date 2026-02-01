import 'package:dynamic_form_builer/domain/entities/validation_result.dart';
import 'field_validator.dart';

class NumberValidator implements FieldValidator {
  @override
  ValidationResult validate(dynamic value, Map<String, dynamic> validators) {
    if (validators['required'] == true) {
      if (value == null || value.toString().trim().isEmpty) {
        return ValidationResult.invalid('This field is required');
      }
    }
    if (value == null || value.toString().trim().isEmpty) {
      return ValidationResult.valid;
    }

    final numValue = num.tryParse(value.toString().trim());
    if (numValue == null) {
      return ValidationResult.invalid('Must be a valid number');
    }

    final min = validators['min'];
    if (min != null) {
      final minNum = num.tryParse(min.toString());
      if (minNum != null && numValue < minNum) {
        return ValidationResult.invalid('Must be at least $min');
      }
    }

    final max = validators['max'];
    if (max != null) {
      final maxNum = num.tryParse(max.toString());
      if (maxNum != null && numValue > maxNum) {
        return ValidationResult.invalid('Must be at most $max');
      }
    }

    final integerOnly = validators['integerOnly'] as bool?;
    if (integerOnly == true && numValue != numValue.toInt()) {
      return ValidationResult.invalid('Must be a whole number');
    }

    return ValidationResult.valid;
  }
}
