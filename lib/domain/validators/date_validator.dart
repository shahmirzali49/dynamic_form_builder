import 'package:dynamic_form_builer/domain/entities/validation_result.dart';
import 'field_validator.dart';

class DateValidator implements FieldValidator {
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

    final dateValue = DateTime.tryParse(value.toString().trim());
    if (dateValue == null) {
      return ValidationResult.invalid('Invalid date');
    }

    final dateMin = validators['dateMin'] as String?;
    if (dateMin != null) {
      final minDate = DateTime.tryParse(dateMin);
      if (minDate != null &&
          dateValue.isBefore(
            DateTime(minDate.year, minDate.month, minDate.day),
          )) {
        return ValidationResult.invalid('Date must be on or after $dateMin');
      }
    }

    final dateMax = validators['dateMax'] as String?;
    if (dateMax != null) {
      final maxDate = DateTime.tryParse(dateMax);
      if (maxDate != null &&
          dateValue.isAfter(
            DateTime(maxDate.year, maxDate.month, maxDate.day, 23, 59, 59),
          )) {
        return ValidationResult.invalid('Date must be on or before $dateMax');
      }
    }

    return ValidationResult.valid;
  }
}
