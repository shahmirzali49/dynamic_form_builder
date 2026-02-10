import 'package:dynamic_form_builder/domain/rule_engine/condition_evaluator.dart';
import 'package:dynamic_form_builder/domain/rule_engine/rule_application_result.dart';

import 'package:dynamic_form_builder/domain/entities/field_entity.dart';
import 'package:dynamic_form_builder/domain/entities/rule_entity.dart';

/// Applies all rules in order: evaluates each condition, then runs then/else actions to update visibility, required, values, options.
class RuleApplier {
  RuleApplier._();

  static RuleApplicationResult apply(
    List<RuleEntity> rules,
    List<FieldEntity> fields,
    Map<String, dynamic> currentValues,
  ) {
    final Map<String, bool> visibility = {};
    final Map<String, bool> requiredFlags = {};
    final Map<String, dynamic> values = Map<String, dynamic>.from(
      currentValues,
    );
    final Map<String, List<String>> options = {};

    // Start from default: all visible, required from field config.
    for (final FieldEntity f in fields) {
      visibility[f.id] = true;
      requiredFlags[f.id] = f.required;
    }
    final result = RuleApplicationResult(
      visibility: visibility,
      requiredFlags: requiredFlags,
      values: values,
      options: options,
    );

    for (final rule in rules) {
      final conditionMet = ConditionEvaluator.evaluate(
        rule.when,
        result.values,
      );
      final actions = conditionMet ? rule.then : rule.elseActions;

      for (final action in actions) {
        switch (action.action) {
          case 'setVisible':
            result.visibility[action.targetFieldId] = action.value == true;
            break;
          case 'setRequired':
            result.requiredFlags[action.targetFieldId] = action.value == true;
            break;
          case 'setValue':
            result.values[action.targetFieldId] = action.value;
            break;
          case 'setOptions':
            if (action.value is List) {
              result.options[action.targetFieldId] = (action.value as List)
                  .map((e) => e.toString())
                  .toList();
            }
            break;
        }
      }
    }

    return result;
  }
}
