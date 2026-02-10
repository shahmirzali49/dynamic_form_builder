import 'package:dynamic_form_builder/core/enums/field_types.dart';
import 'package:dynamic_form_builder/domain/entities/field_entity.dart';
import 'package:dynamic_form_builder/domain/entities/validation_result.dart';

import 'date_validator.dart';
import 'number_validator.dart';
import 'text_validator.dart';

/// Validates a field value (required first, then type-specific rules).
class Validators {
  Validators._();

  static final TextValidator _textValidator = TextValidator();
  static final NumberValidator _numberValidator = NumberValidator();
  static final DateValidator _dateValidator = DateValidator();

  static ValidationResult validateField(FieldEntity field, dynamic value) {
    final validators = field.validators;
    final isRequired = field.required;

    if (isRequired) {
      if (value == null ||
          (value is String && value.trim().isEmpty) ||
          (value is bool && !value && field.type == FieldType.checkbox)) {
        if (field.type == FieldType.checkbox) {
          return ValidationResult.invalid('This field is required');
        }
        return ValidationResult.invalid('This field is required');
      }
    }

    if (value == null || (value is String && value.trim().isEmpty)) {
      return ValidationResult.valid;
    }

    switch (field.type) {
      case FieldType.text:
      case FieldType.multiline:
      case FieldType.phone:
        return _textValidator.validate(value, {
          ...validators,
          'required': isRequired,
        });
      case FieldType.number:
      case FieldType.slider:
        return _numberValidator.validate(value, {
          ...validators,
          'required': isRequired,
        });
      case FieldType.date:
        return _dateValidator.validate(value, {
          ...validators,
          'required': isRequired,
        });
      case FieldType.dropdown:
      case FieldType.radio:
        final normalized = value.toString();
        if (!field.options.contains(normalized)) {
          return ValidationResult.invalid('Please select a valid option');
        }
        return ValidationResult.valid;
      case FieldType.checkbox:
        return ValidationResult.valid;
    }
  }
}
