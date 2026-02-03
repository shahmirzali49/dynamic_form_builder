import 'package:dynamic_form_builder/domain/rule_engine/value_comparator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ValueComparator', () {
    test('equals (==) returns true for same value', () {
      expect(
        ValueComparator.compare(
          actualValue: 5,
          operator: '==',
          expectedValue: 5,
        ),
        isTrue,
      );
      expect(
        ValueComparator.compare(
          actualValue: 'hello',
          operator: '==',
          expectedValue: 'hello',
        ),
        isTrue,
      );
    });

    test('not equals (!=) returns true when values differ', () {
      expect(
        ValueComparator.compare(
          actualValue: 5,
          operator: '!=',
          expectedValue: 10,
        ),
        isTrue,
      );
    });

    test('numeric comparison (>, <, >=, <=) works for numbers', () {
      expect(
        ValueComparator.compare(
          actualValue: 10,
          operator: '>',
          expectedValue: 3,
        ),
        isTrue,
      );
      expect(
        ValueComparator.compare(
          actualValue: 2,
          operator: '<',
          expectedValue: 5,
        ),
        isTrue,
      );
      expect(
        ValueComparator.compare(
          actualValue: 5,
          operator: '>=',
          expectedValue: 5,
        ),
        isTrue,
      );
    });

    test('numeric comparison parses string numbers', () {
      expect(
        ValueComparator.compare(
          actualValue: '42',
          operator: '>',
          expectedValue: 40,
        ),
        isTrue,
      );
    });

    test('in operator returns true when value is in list', () {
      expect(
        ValueComparator.compare(
          actualValue: 'b',
          operator: 'in',
          expectedValue: ['a', 'b', 'c'],
        ),
        isTrue,
      );
    });

    test('contains returns true when string contains substring', () {
      expect(
        ValueComparator.compare(
          actualValue: 'hello world',
          operator: 'contains',
          expectedValue: 'world',
        ),
        isTrue,
      );
    });

    test('unknown operator returns false', () {
      expect(
        ValueComparator.compare(
          actualValue: 1,
          operator: '??',
          expectedValue: 1,
        ),
        isFalse,
      );
    });
  });
}
