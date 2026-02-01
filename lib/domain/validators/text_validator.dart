import 'package:dynamic_form_builer/domain/entities/validation_result.dart';
import 'field_validator.dart';

class TextValidator implements FieldValidator {
  @override
  ValidationResult validate(dynamic value, Map<String, dynamic> validators) {
    final str = value == null ? '' : value.toString().trim();

    if (validators['required'] == true && str.isEmpty) {
      return ValidationResult.invalid('This field is required');
    }
    if (str.isEmpty) return ValidationResult.valid;

    final minLength = validators['minLength'] as int?;
    if (minLength != null && str.length < minLength) {
      return ValidationResult.invalid('Must be at least $minLength characters');
    }

    final maxLength = validators['maxLength'] as int?;
    if (maxLength != null && str.length > maxLength) {
      return ValidationResult.invalid('Must be at most $maxLength characters');
    }

    final regex = validators['regex'] as String?;
    if (regex != null) {
      try {
        final pattern = RegExp(regex);
        if (!pattern.hasMatch(str)) {
          return ValidationResult.invalid('Invalid format');
        }
      } catch (_) {
        return ValidationResult.invalid('Invalid format');
      }
    }

    final contains = validators['contains'] as String?;
    if (contains != null && !str.contains(contains)) {
      return ValidationResult.invalid('Must contain "$contains"');
    }

    final notContains = validators['notContains'] as String?;
    if (notContains != null && str.contains(notContains)) {
      return ValidationResult.invalid('Must not contain "$notContains"');
    }

    return ValidationResult.valid;
  }
}
