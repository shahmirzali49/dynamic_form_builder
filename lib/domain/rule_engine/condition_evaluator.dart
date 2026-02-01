import '../entities/rule_entity.dart';
import 'invalid_condition_exception.dart';
import 'value_comparator.dart';

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
