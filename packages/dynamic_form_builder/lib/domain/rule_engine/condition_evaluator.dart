import 'package:dynamic_form_builder/domain/entities/rule_entity.dart';
import 'package:dynamic_form_builder/domain/rule_engine/invalid_condition_exception.dart';
import 'package:dynamic_form_builder/domain/rule_engine/value_comparator.dart';

/// Evaluates a condition tree: logical operators (and, or, not) or a single field comparison.
class ConditionEvaluator {
  ConditionEvaluator._();

  static bool evaluate(ConditionEntity condition, Map<String, dynamic> values) {
    final String? operator = condition.operator;

    if (operator == 'and') {
      final innerConditions = condition.conditions ?? [];
      for (final inner in innerConditions) {
        if (!evaluate(inner, values)) return false;
      }
      return true;
    }

    if (operator == 'or') {
      final innerConditions = condition.conditions ?? [];
      for (final inner in innerConditions) {
        if (evaluate(inner, values)) return true;
      }
      return false;
    }

    if (operator == 'not') {
      final innerConditions = condition.conditions ?? [];
      if (innerConditions.isEmpty) return false;
      return !evaluate(innerConditions.first, values);
    }

    final fieldId = condition.fieldId;
    final expectedValue = condition.value;
    if (fieldId == null || operator == null || expectedValue == null) {
      throw InvalidConditionException(
        'Condition must have fieldId, operator and value',
      );
    }

    final fieldValue = values[fieldId];
    return ValueComparator.compare(
      actualValue: fieldValue,
      operator: operator,
      expectedValue: expectedValue,
    );
  }
}
