import 'package:dynamic_form_builer/domain/entities/rule_entity.dart';
import 'package:dynamic_form_builer/domain/rule_engine/condition_evaluator.dart';
import 'package:dynamic_form_builer/domain/rule_engine/invalid_condition_exception.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ConditionEvaluator', () {
    group('Field based condition', () {
      test('evaluates to true when field value matches', () {
        final condition = ConditionEntity(
          fieldId: 'accountType',
          operator: '==',
          value: 'Business',
        );
        final values = {'accountType': 'Business'};
        expect(ConditionEvaluator.evaluate(condition, values), true);
      });

      test('evaluates to false when field value does not match', () {
        final condition = ConditionEntity(
          fieldId: 'accountType',
          operator: '==',
          value: 'Business',
        );
        final values = {'accountType': 'Personal'};
        expect(ConditionEvaluator.evaluate(condition, values), false);
      });

      test('throws when fieldId is null', () {
        final condition = ConditionEntity(
          fieldId: null,
          operator: '==',
          value: 'x',
        );
        expect(
          () => ConditionEvaluator.evaluate(condition, {}),
          throwsA(isA<InvalidConditionException>()),
        );
      });
    });

    group('and', () {
      test('returns true when all inner conditions are true', () {
        final condition = ConditionEntity(
          operator: 'and',
          conditions: [
            ConditionEntity(fieldId: 'x1', operator: '==', value: 1),
            ConditionEntity(fieldId: 'x2', operator: '==', value: 2),
          ],
        );
        final values = {'x1': 1, 'x2': 2};
        expect(ConditionEvaluator.evaluate(condition, values), true);
      });

      test('returns false when one inner condition is false', () {
        final condition = ConditionEntity(
          operator: 'and',
          conditions: [
            ConditionEntity(fieldId: 'x1', operator: '==', value: '1'),
            ConditionEntity(fieldId: 'x2', operator: '==', value: '2'),
          ],
        );
        final values = {'x1': '1', 'x2': '7'};
        expect(ConditionEvaluator.evaluate(condition, values), false);
      });

      test('empty conditions returns true', () {
        final condition = ConditionEntity(operator: 'and', conditions: []);
        expect(ConditionEvaluator.evaluate(condition, {}), true);
      });
    });

    group('or', () {
      test('returns true when one inner condition is true', () {
        final condition = ConditionEntity(
          operator: 'or',
          conditions: [
            ConditionEntity(fieldId: 'x1', operator: '==', value: '1'),
            ConditionEntity(fieldId: 'x2', operator: '==', value: '2'),
          ],
        );
        final values = {'x1': 'a', 'x2': '2'};
        expect(ConditionEvaluator.evaluate(condition, values), true);
      });

      test('returns false when all inner conditions are false', () {
        final condition = ConditionEntity(
          operator: 'or',
          conditions: [
            ConditionEntity(fieldId: 'x1', operator: '==', value: '1'),
            ConditionEntity(fieldId: 'x2', operator: '==', value: '2'),
          ],
        );
        final values = {'x1': 'a', 'x2': 'b'};
        expect(ConditionEvaluator.evaluate(condition, values), false);
      });
    });

    group('not', () {
      test('returns true when inner condition is false', () {
        final condition = ConditionEntity(
          operator: 'not',
          conditions: [
            ConditionEntity(fieldId: 'x1', operator: '==', value: '1'),
          ],
        );
        final values = {'x1': 'a'};
        expect(ConditionEvaluator.evaluate(condition, values), true);
      });

      test('returns false when inner condition is true', () {
        final condition = ConditionEntity(
          operator: 'not',
          conditions: [
            ConditionEntity(fieldId: 'x1', operator: '==', value: '1'),
          ],
        );
        final values = {'x1': '1'};
        expect(ConditionEvaluator.evaluate(condition, values), false);
      });

      test('empty conditions returns false', () {
        final condition = ConditionEntity(operator: 'not', conditions: []);
        expect(ConditionEvaluator.evaluate(condition, {}), false);
      });
    });
  });
}
