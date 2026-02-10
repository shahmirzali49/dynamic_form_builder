import 'package:dynamic_form_builder/domain/entities/apply_rules_result.dart';
import 'package:dynamic_form_builder/domain/entities/field_entity.dart';
import 'package:dynamic_form_builder/domain/entities/form_entity.dart';
import 'package:dynamic_form_builder/domain/rule_engine/rule_application_result.dart';
import 'package:dynamic_form_builder/domain/rule_engine/rule_applier.dart';
import 'package:dynamic_form_builder/domain/validators/validators.dart';

class ApplyRulesAndValidateUseCase {
  ApplyRulesResult call(FormEntity form, Map<String, dynamic> currentValues) {
    final result = RuleApplier.apply(form.rules, form.fields, currentValues);
    final errors = _validateVisible(form, result);
    return ApplyRulesResult(ruleResult: result, errors: errors);
  }

  /// Validates only visible fields using rule-derived required flags and options.
  static Map<String, String> _validateVisible(
    FormEntity form,
    RuleApplicationResult result,
  ) {
    final errors = <String, String>{};
    for (final field in form.fields) {
      if (result.visibility[field.id] != true) continue;
      final effectiveRequired =
          result.requiredFlags[field.id] ?? field.required;
      final fieldWithRequired = FieldEntity(
        id: field.id,
        label: field.label,
        type: field.type,
        required: effectiveRequired,
        defaultValue: field.defaultValue,
        options: result.options[field.id] ?? field.options,
        validators: field.validators,
      );
      final value = result.values[field.id];
      final validation = Validators.validateField(fieldWithRequired, value);
      if (!validation.isValid && validation.errorMessage != null) {
        errors[field.id] = validation.errorMessage!;
      }
    }
    return errors;
  }
}
