import 'package:dynamic_form_builer/domain/rule_engine/condition_evaluator.dart';
import 'package:dynamic_form_builer/domain/rule_engine/rule_application_result.dart';

import 'package:dynamic_form_builer/domain/entities/field_entity.dart';
import 'package:dynamic_form_builer/domain/entities/rule_entity.dart';

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
          case 'setvisible':
            result.visibility[action.targetFieldId] = action.value == true;
            break;
          case 'setrequired':
            result.requiredFlags[action.targetFieldId] = action.value == true;
            break;
          case 'setvalue':
            result.values[action.targetFieldId] = action.value;
            break;
          case 'setoptions':
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
